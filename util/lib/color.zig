const std = @import("std");
const strfmt = @import("./util.zig").strfmt;
const TERM_RESET = @import("./util.zig").TERM_RESET;

const Color = @This();
name: []const u8,
hexcode: []const u8,
r: u8,
g: u8,
b: u8,

pub const Lack = Color.init("lack", "708090");
pub const Luster = Color.init("luster", "deeeed");
pub const Orange = Color.init("orange", "ffaa88");
pub const Green = Color.init("green", "789978");
pub const Blue = Color.init("blue", "7788AA");
pub const Red = Color.init("red", "D70000");
pub const Black = Color.init("black", "000000");
pub const Gray1 = Color.init("gray1", "080808");
pub const Gray2 = Color.init("gray2", "191919");
pub const Gray3 = Color.init("gray3", "2a2a2a");
pub const Gray4 = Color.init("gray4", "444444");
pub const Gray5 = Color.init("gray5", "555555");
pub const Gray6 = Color.init("gray6", "7a7a7a");
pub const Gray7 = Color.init("gray7", "aaaaaa");
pub const Gray8 = Color.init("gray8", "cccccc");
pub const Gray9 = Color.init("gray9", "DDDDDD");
pub const pallet_list = [_]Color{
    Color.Lack,
    Color.Luster,
    Color.Orange,
    Color.Green,
    Color.Blue,
    Color.Red,
    Color.Black,
    Color.Gray1,
    Color.Gray2,
    Color.Gray3,
    Color.Gray4,
    Color.Gray5,
    Color.Gray6,
    Color.Gray7,
    Color.Gray8,
    Color.Gray9,
};

pub fn init(name: []const u8, comptime hexcode: []const u8) Color {
    if (hexcode.len != 6) {
        @compileError("color hexcode unparsable: length invalid (" ++ hexcode ++ ")");
    }

    const r: u8 = comptime std.fmt.parseInt(u8, hexcode[0..2], 16) catch {
        @compileError("color hexcode unparsable: faled to parse r (" ++ hexcode ++ ")");
    };
    const g: u8 = comptime std.fmt.parseInt(u8, hexcode[2..4], 16) catch {
        @compileError("color hexcode unparsable: failed to parse g (" ++ hexcode ++ ")");
    };
    const b: u8 = comptime std.fmt.parseInt(u8, hexcode[4..6], 16) catch {
        @compileError("color hexcode unparsable: failed to parse b (" ++ hexcode ++ ")");
    };

    return Color{
        .r = r,
        .g = g,
        .b = b,
        .name = name,
        .hexcode = hexcode,
    };
}

pub fn toTermcolor(self: Color) []u8 {
    return strfmt("\x1b[38;2;{d};{d};{d}m", .{ self.r, self.g, self.b });
}

pub fn toTermcolorEscape(self: Color) []u8 {
    return strfmt("\\x1b[38;2;{d};{d};{d}m", .{ self.r, self.g, self.b });
}

pub fn toStringRGB(self: Color) []u8 {
    return strfmt("rgb({d}, {d}, {d})", .{ self.r, self.g, self.b });
}

pub fn toStringHexcode(self: Color) []u8 {
    return strfmt("#{s}", .{self.hexcode});
}

pub fn toStringExa(self: Color) []u8 {
    return strfmt("38;2;{d};{d};{d}", .{ self.r, self.g, self.b });
}

pub fn describe(self: Color) []u8 {
    return strfmt("{s}name{s} {s: <6} {s} {s: <18} {s}", .{ self.toTermcolor(), TERM_RESET, self.name, self.toStringHexcode(), self.toStringRGB(), self.toTermcolorEscape() });
}
