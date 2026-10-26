"""Generate Lackluster color themes for Visual Studio 2026.

The palette and syntax variants below are copied from lua/lackluster/color.lua,
lua/lackluster/color-special.lua and lua/lackluster/create-theme.lua.

How it works:
  1. Read every color token of the built-in VS 2026 "Dark" theme from the
     local Visual Studio installation (so nothing in the IDE is left unthemed).
  2. Remap each of those colors onto the lackluster palette: neutrals are
     pushed through a gray ramp tuned to lackluster's backgrounds, colored
     tokens are re-hued onto the nearest lackluster accent.
  3. Apply explicit overrides that mirror the Neovim highlight groups
     (lua/lackluster/highlight.lua + create-theme.lua) for the editor, syntax
     classifications and the VS 2026 Fluent shell tokens.
  4. Serialize to .pkgdef (VS color theme binary format v11).

Usage:
  python generate.py [--vs "C:\\Program Files\\Microsoft Visual Studio\\18\\Community"]
"""

import argparse
import colorsys
import json
import pathlib
import re
import struct
import subprocess
import uuid

HERE = pathlib.Path(__file__).resolve().parent
OUT_DIR = HERE / "Lackluster.VS" / "Themes"

DARK_THEME_ID = "{1ded0138-47ce-435e-84ef-9ec1f439b749}"
VS_THEME_FILES = ["Theme.Dark.pkgdef", "Shell.Dark.pkgdef", "EditorColors.pkgdef"]

CT_INVALID, CT_RAW = 0, 1
COLOR_TYPES_WITH_DATA = (1, 2, 3, 5)  # CT_RAW, CT_COLORINDEX, CT_SYSCOLOR, CT_AUTOMATIC

# --------------------------------------------------------------------------
# palette (lua/lackluster/color.lua, lua/lackluster/color-special.lua)
# --------------------------------------------------------------------------

C = {
    "lack": "#708090",
    "luster": "#deeeed",
    "orange": "#ffaa88",
    "yellow": "#abab77",
    "green": "#789978",
    "blue": "#7788AA",
    "red": "#D70000",
    "black": "#000000",
    "gray1": "#080808",
    "gray2": "#191919",
    "gray3": "#2a2a2a",
    "gray4": "#444444",
    "gray5": "#555555",
    "gray6": "#7a7a7a",
    "gray7": "#aaaaaa",
    "gray8": "#cccccc",
    "gray9": "#DDDDDD",
}

S = {
    "main_background": "#101010",
    "menu_background": "#191919",
    "popup_background": "#1A1A1A",
    "statusline": "#242424",
    "comment": "#3A3A3A",
    "exception": "#505050",
    "keyword": "#666666",
    "param": "#8E8E8E",
    "whitespace": "#202020",
}

# --------------------------------------------------------------------------
# syntax variants (lua/lackluster/create-theme.lua)
# --------------------------------------------------------------------------

SYNTAX_DEFAULT = {
    "tag": C["gray5"],
    "var": C["gray8"],
    "var_member": C["gray7"],
    "const": C["gray7"],
    "const_builtin": C["gray6"],
    "func_def": C["luster"],
    "func_call": C["gray6"],
    "func_param": S["param"],
    "special": C["lack"],
    "type": C["gray7"],
    "type_def": C["gray8"],
    "type_primitive": C["gray7"],
    "builtin": C["gray5"],
    "keyword": S["keyword"],
    "keyword_return": S["exception"],
    "keyword_exception": S["exception"],
    "string": C["lack"],
    "string_escape": C["green"],
    "punctuation": C["gray6"],
    "comment": S["comment"],
}

VARIANTS = {
    "Lackluster": SYNTAX_DEFAULT,
    "Lackluster Hack": {
        **SYNTAX_DEFAULT,
        "keyword_return": C["green"],
        "keyword_exception": C["blue"],
    },
    "Lackluster Mint": {
        **SYNTAX_DEFAULT,
        "type": C["green"],
        "type_primitive": C["green"],
        "func_param": C["gray7"],
    },
    "Lackluster Night": {
        **SYNTAX_DEFAULT,
        "string": C["yellow"],
        "string_escape": C["blue"],
        "builtin": C["blue"],
        "keyword": C["lack"],
        "keyword_return": C["blue"],
        "keyword_exception": C["blue"],
    },
    "Lackluster Dark": {
        "var": C["gray6"],
        "var_member": C["gray6"],
        "const": C["gray5"],
        "const_builtin": C["gray5"],
        "tag": C["gray5"],
        "func_call": C["gray5"],
        "func_def": S["keyword"],
        "builtin": C["gray4"],
        "func_param": C["gray6"],
        "special": C["lack"],
        "type": C["gray5"],
        "type_def": C["gray5"],
        "type_primitive": C["gray5"],
        "keyword": C["gray5"],
        "keyword_return": S["exception"],
        "keyword_exception": S["exception"],
        "string": "#aa6666",
        "string_escape": C["blue"],
        "punctuation": C["gray6"],
        "comment": S["comment"],
    },
}

# --------------------------------------------------------------------------
# color helpers
# --------------------------------------------------------------------------


def rgb(hex_color):
    h = hex_color.lstrip("#")
    return tuple(int(h[i:i + 2], 16) for i in (0, 2, 4))


def to_hex(r, g, b):
    return "#%02x%02x%02x" % (round(r), round(g), round(b))


def mix(a, b, t):
    """Blend hex color a toward b by t (0 = a, 1 = b)."""
    ra, rb = rgb(a), rgb(b)
    return to_hex(*(x + (y - x) * t for x, y in zip(ra, rb)))


def rgba(hex_color, alpha=0xFF):
    """CT_RAW entry: bytes R, G, B, A."""
    return (CT_RAW, bytes(rgb(hex_color)) + bytes([alpha]))


# lightness ramp: VS 2026 Dark gray value -> lackluster gray value
GRAY_RAMP = [
    (0x00, 0x00),
    (0x0a, 0x08),  # base alt          -> gray1
    (0x1e, 0x10),  # editor background -> main_background
    (0x28, 0x19),  # headers / tabs    -> gray2
    (0x2e, 0x1a),  # popups            -> popup_background
    (0x3e, 0x2a),  # raised controls   -> gray3
    (0x55, 0x44),  # strokes           -> gray4
    (0x80, 0x55),  # subtle text       -> gray5
    (0x9b, 0x7a),  # secondary text    -> gray6
    (0xb4, 0xaa),  # muted text        -> gray7
    (0xdc, 0xcc),  # text              -> gray8
    (0xff, 0xdd),  # bright text       -> gray9
]


def ramp(v):
    for (x0, y0), (x1, y1) in zip(GRAY_RAMP, GRAY_RAMP[1:]):
        if v <= x1:
            return y0 + (y1 - y0) * (v - x0) / (x1 - x0)
    return GRAY_RAMP[-1][1]


def accent_for_hue(hue_deg, lightness):
    if hue_deg < 15 or hue_deg >= 345:
        # lackluster has no pink: light reds read as warnings (orange)
        return C["orange"] if lightness > 0.6 else C["red"]
    if hue_deg < 45:
        return C["orange"]
    if hue_deg < 75:
        return C["yellow"]
    if hue_deg < 165:
        return C["green"]
    return C["lack"]  # cyan, blue, lavender, purple, magenta


def remap_raw(data):
    r, g, b, a = data
    if a == 0:
        return data
    h, l, s = colorsys.rgb_to_hls(r / 255, g / 255, b / 255)
    if s < 0.18 or l < 0.06 or l > 0.97:
        v = ramp(max(r, g, b) * 0.5 + min(r, g, b) * 0.5)
        return bytes([round(v)] * 3 + [a])
    th, tl, ts = colorsys.rgb_to_hls(*(x / 255 for x in rgb(accent_for_hue(h * 360, l))))
    # keep the original lightness (dark tinted backgrounds stay dark) but pull
    # it toward the accent so foregrounds land on the lackluster swatch
    nl = l * 0.5 + tl * 0.5 if l > 0.35 else l * 0.8
    nr, ng, nb = colorsys.hls_to_rgb(th, nl, min(ts, s))
    return bytes([round(nr * 255), round(ng * 255), round(nb * 255), a])


def remap_entry(entry):
    ctype, data = entry
    if ctype == CT_RAW:
        return (ctype, remap_raw(data))
    return entry


# --------------------------------------------------------------------------
# pkgdef read / write (VS color theme binary format, version 11)
# --------------------------------------------------------------------------

SECTION = re.compile(r"^\[\$RootKey\$\\Themes\\(\{[^}]+\})\\([^\]]+)\]")


def parse_blob(blob):
    total, version, ncat = struct.unpack_from("<iii", blob, 0)
    assert version == 11 and total == len(blob), (version, total, len(blob))
    off = 12
    cats = []
    for _ in range(ncat):
        guid = uuid.UUID(bytes_le=blob[off:off + 16]); off += 16
        (count,) = struct.unpack_from("<i", blob, off); off += 4
        colors = {}
        for _ in range(count):
            (n,) = struct.unpack_from("<i", blob, off); off += 4
            name = blob[off:off + n].decode("utf-8"); off += n
            pair = []
            for _ in range(2):
                ctype = blob[off]; off += 1
                if ctype in COLOR_TYPES_WITH_DATA:
                    pair.append((ctype, blob[off:off + 4])); off += 4
                else:
                    pair.append((CT_INVALID, None))
            colors[name] = pair
        cats.append((guid, colors))
    assert off == total
    return cats


def read_theme(paths, theme_id):
    """-> {category_name: (guid, {token: [bg, fg]})}"""
    result = {}
    for path in paths:
        section = None
        for line in pathlib.Path(path).read_text(encoding="utf-8-sig").splitlines():
            m = SECTION.match(line)
            if m:
                section = m.groups()
                continue
            if section and section[0].lower() == theme_id and line.startswith('"Data"=hex:'):
                blob = bytes.fromhex(line[len('"Data"=hex:'):].replace(",", ""))
                for guid, colors in parse_blob(blob):
                    _, existing = result.setdefault(section[1], (guid, {}))
                    existing.update(colors)
    return result


def build_blob(guid, colors):
    body = struct.pack("<i", 1) + guid.bytes_le + struct.pack("<i", len(colors))
    for name, pair in colors.items():
        raw = name.encode("utf-8")
        body += struct.pack("<i", len(raw)) + raw
        for ctype, data in pair:
            body += bytes([ctype]) + (data if ctype in COLOR_TYPES_WITH_DATA else b"")
    return struct.pack("<ii", 8 + len(body), 11) + body


def write_pkgdef(path, theme_id, name, categories):
    lines = [
        f"[$RootKey$\\Themes\\{theme_id}]",
        f'@="{name}"',
        f'"Name"="{name}"',
        f'"FallbackId"="{DARK_THEME_ID}"',
        "",
    ]
    for cat_name, (guid, colors) in sorted(categories.items()):
        if not colors:
            continue
        lines.append(f"[$RootKey$\\Themes\\{theme_id}\\{cat_name}]")
        lines.append('"Data"=hex:' + ",".join("%02x" % b for b in build_blob(guid, colors)))
        lines.append("")
    path.write_text("\n".join(lines), encoding="utf-8")


# --------------------------------------------------------------------------
# explicit overrides (the nvim highlight groups, translated)
# --------------------------------------------------------------------------

BG, FG = 0, 1


def overrides(syn):
    ui_fg = C["gray8"]
    ui_bg = S["main_background"]
    lack_dim = mix(C["lack"], ui_bg, 0.55)
    o = {}

    def put(cat, token, bg=None, fg=None, bg_alpha=0xFF, fg_alpha=0xFF):
        o.setdefault(cat, {})[token] = (
            rgba(bg, bg_alpha) if bg else None,
            rgba(fg, fg_alpha) if fg else None,
        )

    # ---- VS 2026 Fluent shell -------------------------------------------
    shell = {
        "AccentFillDefault": (C["gray8"], 0xFF),
        "AccentFillSecondary": (C["gray8"], 0xE5),
        "AccentFillTertiary": (C["gray8"], 0xCC),
        "AccentFillAlt": (C["gray9"], 0xFF),
        "AccentFillSenary": (C["gray8"], 0x1F),
        "AccentFillSelectedTextBackground": (C["gray4"], 0xFF),
        "AccentFillSelectedTextBackgroundSubtle": (C["gray4"], 0x66),
        "AccentTextFillPrimary": (C["gray9"], 0xFF),
        "AccentTextFillSecondary": (C["gray8"], 0xFF),
        "AccentTextFillTertiary": (C["gray7"], 0xFF),
        "SolidBackgroundFillBaseAlt": (C["gray1"], 0xFF),
        "SolidBackgroundFillSecondary": (S["main_background"], 0xFF),
        "SolidBackgroundFillBase": ("#151515", 0xFF),
        "SolidBackgroundFillTertiary": (C["gray2"], 0xFF),
        "SolidBackgroundFillQuaternary": (S["whitespace"], 0xFF),
        "SolidBackgroundFillQuinary": (S["statusline"], 0xFF),
        "SolidBackgroundFillSenary": (C["gray3"], 0xFF),
        "SurfaceBackgroundFillDefault": (S["popup_background"], 0xFF),
        "SurfaceStrokeDefault": (C["gray4"], 0x66),
        "CardStrokeDefaultSolid": (C["gray2"], 0xFF),
        "ControlSolidFillDefault": (C["gray4"], 0xFF),
        "ControlFillActiveInput": (S["main_background"], 0xB2),
        "TextFillPrimary": (C["gray8"], 0xFF),
        "TextFillSecondary": (C["gray7"], 0xFF),
        "TextFillTertiary": (C["gray6"], 0xFF),
        "TextFillDisabled": (C["gray5"], 0xFF),
        "TextOnAccentFillPrimary": (C["gray1"], 0xFF),
        "TextOnAccentFillSecondary": (C["gray1"], 0x80),
        "TextOnAccentFillSelectedText": (C["gray9"], 0xFF),
        "HyperlinkFillPrimary": (C["lack"], 0xFF),
        "HyperlinkFillSecondary": (C["lack"], 0xFF),
        "HyperlinkFillTertiary": (C["lack"], 0xE6),
        "SystemFillAttention": (C["lack"], 0xFF),
        "SystemFillCaution": (C["orange"], 0xFF),
        "SystemFillCautionBackground": (mix(C["orange"], ui_bg, 0.85), 0xFF),
        "SystemFillCritical": (C["red"], 0xFF),
        "SystemFillCriticalBackground": (mix(C["red"], ui_bg, 0.8), 0xFF),
        "SystemFillSuccess": (C["green"], 0xFF),
        "SystemFillSuccessBackground": (mix(C["green"], ui_bg, 0.8), 0xFF),
        "SystemFillSolidNeutral": (C["gray6"], 0xFF),
        "SystemFillSolidNeutralBackground": (S["statusline"], 0xFF),
        "SystemFillSolidAttentionBackground": (S["statusline"], 0xFF),
    }
    for token, (color, alpha) in shell.items():
        put("Shell", token, bg=color, bg_alpha=alpha)

    internal = {
        "EnvironmentBackground": C["gray1"],
        "EnvironmentBody": C["gray1"],
        "EnvironmentBorder": C["gray4"],
        "EnvironmentBorderInactive": C["gray3"],
        "EnvironmentHeader": C["gray2"],
        "EnvironmentHeaderInactive": C["gray2"],
        "EnvironmentTab": C["gray2"],
        "EnvironmentTabInactive": C["gray2"],
        "EnvironmentLogo": C["lack"],
        "EnvironmentBodyText": C["gray8"],
        "CaptionControlCloseFillPrimary": C["red"],
        "StatusBarBackgroundFillRest": S["statusline"],
        "StatusBarTextFillRest": C["gray7"],
        "StatusBarBackgroundFillBuilding": C["gray3"],
        "StatusBarTextFillBuilding": C["gray8"],
        "StatusBarBackgroundFillDebugging": C["lack"],
        "StatusBarTextFillDebugging": C["gray1"],
        "StatusBarBackgroundFillSolutionLoading": C["gray2"],
        "StatusBarTextFillSolutionLoading": C["gray7"],
    }
    for token, color in internal.items():
        put("ShellInternal", token, bg=color)
    put("ShellInternal", "EnvironmentIndicator", bg=C["lack"], bg_alpha=0x60)

    # ---- editor popups (Quick Info, completion) --------------------------
    put("EditorOverride", "PopupBackground", bg=S["popup_background"])
    put("EditorOverride", "PopupBorder", bg=C["gray4"])
    put("EditorOverride", "PopupText", bg=C["gray8"])
    put("EditorOverride", "PopupSubtleText", bg=C["gray6"])
    put("EditorOverride", "PopupHyperlink", bg=C["lack"])
    put("EditorOverride", "PopupSelectedBackground", bg=C["gray3"])
    put("EditorOverride", "PopupSelectedText", bg=C["gray9"])

    # ---- editor chrome ----------------------------------------------------
    TM, MEF, LS, MK = (
        "Text Editor Text Manager Items",
        "Text Editor MEF Items",
        "Text Editor Language Service Items",
        "Text Editor Text Marker Items",
    )
    put(TM, "Plain Text", bg=ui_bg, fg=ui_fg)                       # Normal
    for cat in (TM, MEF):
        put(cat, "Selected Text", bg=C["gray4"])                   # Visual
        put(cat, "Inactive Selected Text", bg=C["gray3"])
        put(cat, "outlining.chevron.expanded", bg=ui_bg, fg=C["gray4"])   # FoldColumn
        put(cat, "outlining.chevron.collapsed", bg=ui_bg, fg=C["gray4"])
    put(TM, "Indicator Margin", bg=ui_bg)                           # SignColumn
    put(MEF, "Line Number", fg=C["gray4"])                          # LineNr
    put(MEF, "Selected Line Number", fg=C["gray7"])                 # CursorLineNr
    put(MEF, "CurrentLineActiveFormat", bg=C["gray2"], fg=C["gray2"])  # CursorLine
    put(MEF, "CurrentLineInactiveFormat", bg="#151515", fg="#151515")
    put(MEF, "Visible Whitespace", fg=S["whitespace"])              # Whitespace
    put(TM, "Visible Whitespace", fg=S["whitespace"])
    put(MEF, "Word Wrap Glyph", fg=C["gray5"])                      # NonText
    put(MEF, "Suggestion Margin", bg=ui_bg)
    put(MEF, "Block Structure Adornments", bg=C["gray3"])
    put(MEF, "outlining.verticalrule", fg=C["gray3"])
    put(MEF, "outlining.collapsehintadornment", bg=C["gray2"], fg=C["gray7"])  # Folded
    put(MEF, "Matched Selected Text", bg=C["gray3"])
    put(MEF, "MarkerFormatDefinition/HighlightedReference", bg=C["gray3"], fg=C["gray3"])
    put(MEF, "MarkerFormatDefinition/HighlightedWrittenReference", bg=C["gray3"], fg=C["gray3"])
    put(MEF, "MarkerFormatDefinition/HighlightedDefinition", bg=C["gray3"], fg=C["gray3"])
    put(MEF, "MarkerFormatDefinition/FindHighlight", bg=C["lack"], fg=C["black"])  # Search
    put(MEF, "MarkerFormatDefinition/ScopeHighlight", bg=C["gray1"])  # ColorColumn
    put(MEF, "MarkerFormatDefinition/SelectedTextInScrollBar", bg=C["gray7"])
    put(MEF, "brace matching", bg=lack_dim)                         # MatchParen
    put(MK, "Brace Matching (Rectangle)", bg=lack_dim)
    put(MEF, "OverviewMarginBackground", bg=ui_bg)                  # scrollbar
    put(MEF, "OverviewMarginVisible", bg=C["gray3"], fg=C["gray3"])
    put(MEF, "OverviewMarginCaret", fg=C["gray6"])
    put(MEF, "OverviewMarginCollapsedRegion", bg=C["gray4"])
    put(MEF, "Peek Background", bg=S["popup_background"])          # NormalFloat
    put(MEF, "Peek Background Unfocused", bg=S["menu_background"])
    put(MEF, "Peek Focused Border", fg=C["gray4"])                  # FloatBorder
    put(MEF, "Peek Label Text", fg=C["gray5"])                      # FloatTitle
    put(MEF, "Peek Highlighted Text", bg=C["gray3"])
    put(MEF, "Peek Highlighted Text Unfocused", bg=C["gray3"])
    put(MEF, "StickyScroll Background", bg=C["gray2"])
    put(MK, "Definition Window Background", bg=ui_bg)
    put(MK, "Refactoring Background", bg=ui_bg)
    put(MK, "Refactoring Current Field", bg=C["gray3"])
    put(MK, "Refactoring Dependent Field", fg=C["gray6"])
    put(MK, "Code Snippet Field", bg=C["gray3"])
    put(MK, "Code Snippet Field (Selected)", bg=C["gray4"])
    put(MK, "Code Snippet Dependent Field", fg=C["lack"])
    put(MK, "Current List Location", bg=C["gray3"], fg=C["gray8"])  # QuickFixLine
    put(MK, "Read-Only Region", bg=C["gray2"])
    put(MK, "Bookmark", bg=C["lack"])
    put(MK, "Definition Window Current Match", fg=C["gray9"])

    # ---- diagnostics (DiagnosticUnderline*) -------------------------------
    for cat in (MEF, MK):
        put(cat, "syntax error", fg=C["red"])
        put(cat, "compiler error", fg=C["red"])
        put(cat, "other error", fg=C["red"])
        put(cat, "compiler warning", fg=C["orange"])
        put(cat, "information", fg=C["gray6"])
        put(cat, "hinted suggestion", fg=C["gray6"])
        put(cat, "Track Changes before save", bg=C["orange"])      # DiffDelete/unsaved
        put(cat, "Track Changes after save", bg=C["green"])        # DiffAdd
    put(MEF, "Track reverted changes", bg=C["gray6"])              # DiffChange
    put(MK, "Error Message", fg=C["red"])
    put(LS, "Error", fg=C["red"])
    put(MEF, "Stale Code", fg=C["gray4"])                          # DiagnosticUnnecessary

    # ---- diff (Added / Removed / Changed) ---------------------------------
    put(MEF, "deltadiff.add.line", bg=mix(C["green"], ui_bg, 0.82))
    put(MEF, "deltadiff.remove.line", bg=mix(C["orange"], ui_bg, 0.86))
    put(MEF, "deltadiff.add.word", bg=mix(C["green"], ui_bg, 0.62), fg=C["green"])
    put(MEF, "deltadiff.remove.word", bg=mix(C["orange"], ui_bg, 0.72), fg=C["orange"])
    put(MEF, "deltadiff.overview.color", bg=mix(C["green"], ui_bg, 0.5), fg=mix(C["orange"], ui_bg, 0.5))

    # ---- debugger ---------------------------------------------------------
    put(MEF, "Current Statement", bg=C["yellow"], fg=C["black"])
    put(MEF, "Current Statement (new context)", bg=C["yellow"], fg=C["black"])
    put(MEF, "Expression Hover Highlight", bg=C["yellow"], fg=C["black"])
    put(MEF, "Call Return", bg=C["lack"], fg=C["black"])

    # ---- rainbow brackets (plugin_rainbow) --------------------------------
    put(MEF, "brace pair level one", fg="#999999")
    put(MEF, "brace pair level two", fg="#BBBBBB")
    put(MEF, "brace pair level three", fg="#666666")
    put(MEF, "mismatched brace", fg=C["red"])

    # ---- syntax ------------------------------------------------------------
    role_tokens = {
        "var": [
            (LS, "Identifier"), (MEF, "Identifier"), (MEF, "local name"),
            (MEF, "cppLocalVariable"), (MEF, "cppGlobalVariable"),
            (MEF, "VBScript Identifier"), (MEF, "XmlTextClassificationFormat"),
            (LS, "XML Text"), (LS, "XAML Text"), (LS, "Text"),
            (MEF, "CSS Property Name"), (MEF, "CSS Selector"),
        ],
        "var_member": [
            (MEF, "field name"), (MEF, "property name"), (MEF, "event name"),
            (MEF, "cppMemberField"), (MEF, "cppStaticMemberField"),
            (MEF, "cppProperty"), (MEF, "cppEvent"),
            (LS, "XAML Markup Extension Parameter Name"),
        ],
        "const": [
            (LS, "Number"), (MEF, "Number"), (MEF, "number"), (MEF, "Literal"),
            (MEF, "enum member name"), (MEF, "constant name"),
            (MEF, "cppEnumerator"), (MEF, "VBScript Number"),
            (MEF, "CSS Property Value"),
        ],
        "func_def": [
            (MEF, "Method"), (MEF, "method name"), (MEF, "extension method name"),
            (MEF, "cppFunction"), (MEF, "cppMemberFunction"),
            (MEF, "cppStaticMemberFunction"), (MEF, "cppFunctionTemplate"),
            (LS, "SQL Stored Procedure"),
        ],
        "func_param": [(MEF, "parameter name"), (MEF, "cppParameter")],
        "type": [
            (LS, "User Types"), (LS, "User Types(Value types)"), (LS, "User Types(Interfaces)"),
            (LS, "User Types(Delegates)"), (LS, "User Types(Enums)"),
            (LS, "User Types(Type parameters)"), (MEF, "Type"),
            (MEF, "class name"), (MEF, "record class name"), (MEF, "struct name"),
            (MEF, "record struct name"), (MEF, "interface name"), (MEF, "enum name"),
            (MEF, "delegate name"), (MEF, "module name"), (MEF, "type parameter name"),
            (MEF, "namespace name"), (MEF, "VBUserTypeClassificationFormat"),
            (MEF, "cppType"), (MEF, "cppRefType"), (MEF, "cppValueType"),
            (MEF, "cppGenericType"), (MEF, "cppNamespace"),
            (LS, "XAML Markup Extension Class"), (LS, "SQL System Table"),
        ],
        "builtin": [(LS, "SQL System Function")],
        "keyword": [
            (LS, "Keyword"), (MEF, "Keyword"), (MEF, "C/C++ User Keywords"),
            (LS, "Preprocessor Keyword"), (MEF, "Preprocessor Keyword"),
            (MEF, "cppMacro"), (LS, "XML Keyword"), (LS, "XAML Keyword"),
            (LS, "XSLT Keyword"), (MEF, "CSS Keyword"), (MEF, "VBScript Keyword"),
            (MEF, "VBScript Function Block Start"),
            (LS, "XML Processing Instruction"), (LS, "XAML Processing Instruction"),
            (MEF, "XmlProcessingInstructionClassificationFormat"),
        ],
        "keyword_return": [(MEF, "keyword - control")],
        "string": [
            (LS, "String"), (MEF, "String"), (LS, "String(C# @ Verbatim)"),
            (MEF, "string - verbatim"), (MEF, "CSS String Value"),
            (MEF, "VBScript String"), (LS, "SQL String"),
            (LS, "XML Attribute Value"), (LS, "XAML Attribute Value"),
            (MEF, "Markup Attribute Value"), (MEF, "HTML Attribute Value"),
            (MEF, "XmlAttributeValueClassificationFormat"),
            (LS, "XAML Markup Extension Parameter Value"),
            (LS, "XML CData Section"), (LS, "XAML CData Section"),
            (MEF, "XmlCDataSectionClassificationFormat"),
        ],
        "string_escape": [
            (MEF, "string - escape character"), (MEF, "RegularExpressionClassificationFormat"),
            (MEF, "HTML Entity"),
            (MEF, "regex - text"), (MEF, "regex - character class"), (MEF, "regex - anchor"),
            (MEF, "regex - quantifier"), (MEF, "regex - grouping"),
            (MEF, "regex - alternation"), (MEF, "regex - self escaped character"),
            (MEF, "regex - other escape"),
        ],
        "punctuation": [
            (LS, "Operator"), (MEF, "Operator"), (MEF, "operator - overloaded"),
            (MEF, "punctuation"), (MEF, "HTML Operator"), (MEF, "VBScript Operator"),
            (LS, "SQL Operator"), (MEF, "cppOperator"), (MEF, "cppMemberOperator"),
        ],
        "tag": [
            (LS, "XML Name"), (LS, "XAML Name"), (MEF, "Markup Node"),
            (MEF, "HTML Element Name"), (MEF, "XmlNameClassificationFormat"),
            (LS, "XML Delimiter"), (LS, "XAML Delimiter"), (MEF, "HTML Tag Delimiter"),
            (MEF, "XmlDelimiterClassificationFormat"),
            (LS, "XML Attribute Quotes"), (LS, "XAML Attribute Quotes"),
            (MEF, "XmlAttributeQuotesClassificationFormat"),
            (MEF, "label name"), (MEF, "cppLabel"),
        ],
        "comment": [
            (LS, "Comment"), (MEF, "Comment"), (LS, "XML Comment"), (LS, "XAML Comment"),
            (MEF, "HTML Comment"), (MEF, "CSS Comment"), (MEF, "VBScript Comment"),
            (MEF, "XmlCommentClassificationFormat"), (MEF, "XmlDocCommentClassificationFormat"),
            (MEF, "XmlDocTagClassificationFormat"), (MEF, "XML Doc Comment"), (MEF, "XML Doc Tag"),
            (MEF, "xml doc comment - text"), (MEF, "xml doc comment - delimiter"),
            (MEF, "xml doc comment - name"), (MEF, "xml doc comment - attribute quotes"),
            (MEF, "xml doc comment - cdata section"), (MEF, "xml doc comment - entity reference"),
            (MEF, "xml doc comment - processing instruction"),
            (LS, "Excluded Code"), (MEF, "Excluded Code"),
            (MEF, "VBExcludedCodeClassificationFormat"),
        ],
    }
    for role, tokens in role_tokens.items():
        for cat, token in tokens:
            put(cat, token, fg=syn[role])

    # @tag.attribute
    for cat, token in [
        (LS, "XML Attribute"), (LS, "XAML Attribute"), (MEF, "Markup Attribute"),
        (MEF, "HTML Attribute Name"), (MEF, "XmlAttributeNameClassificationFormat"),
        (LS, "XML Doc Attribute"), (MEF, "XmlDocAttributeClassificationFormat"),
        (MEF, "xml doc comment - attribute name"), (MEF, "xml doc comment - attribute value"),
    ]:
        put(cat, token, fg=C["gray4"])

    put(MEF, "preprocessor text", fg=C["gray6"])
    put(MEF, "urlformat", fg=C["gray6"])                           # @markup.link
    put(MEF, "NavigableSymbolFormat", fg=syn["special"])
    put(MEF, "HTML Server-Side Script", bg=C["gray2"], fg=ui_fg)
    put(MEF, "Razor Code", bg=C["gray2"])
    put(LS, "SQLCMD Command", bg=C["gray3"], fg=ui_fg)
    return o


# --------------------------------------------------------------------------
# main
# --------------------------------------------------------------------------


def find_vs():
    vswhere = pathlib.Path(r"C:\Program Files (x86)\Microsoft Visual Studio\Installer\vswhere.exe")
    out = subprocess.run(
        [str(vswhere), "-prerelease", "-version", "[18.0,19.0)", "-format", "json"],
        capture_output=True, text=True, check=True,
    ).stdout
    installs = json.loads(out)
    if not installs:
        raise SystemExit("Visual Studio 2026 not found; pass --vs <installation path>")
    return pathlib.Path(installs[0]["installationPath"])


def main():
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("--vs", type=pathlib.Path, help="Visual Studio 2026 installation path")
    args = ap.parse_args()

    platform = (args.vs or find_vs()) / "Common7" / "IDE" / "CommonExtensions" / "Platform"
    base = read_theme([platform / f for f in VS_THEME_FILES], DARK_THEME_ID)
    if not base:
        raise SystemExit(f"no Dark theme colors found in {platform}")

    OUT_DIR.mkdir(parents=True, exist_ok=True)
    for name, syn in VARIANTS.items():
        theme_id = "{%s}" % uuid.uuid5(uuid.NAMESPACE_URL, "lackluster-vs/" + name)
        categories = {
            cat: (guid, {tok: [remap_entry(e) for e in pair] for tok, pair in colors.items()})
            for cat, (guid, colors) in base.items()
        }
        added = 0
        for cat, tokens in overrides(syn).items():
            guid, colors = categories[cat]
            for tok, (bg, fg) in tokens.items():
                if tok not in colors:
                    colors[tok] = [(CT_INVALID, None), (CT_INVALID, None)]
                    added += 1
                if bg:
                    colors[tok][BG] = bg
                if fg:
                    colors[tok][FG] = fg
        out = OUT_DIR / (name.replace(" ", "") + ".pkgdef")
        write_pkgdef(out, theme_id, name, categories)
        total = sum(len(c) for _, c in categories.values())
        print(f"{out.relative_to(HERE)}: {theme_id} {total} tokens ({added} added beyond VS Dark)")


if __name__ == "__main__":
    main()
