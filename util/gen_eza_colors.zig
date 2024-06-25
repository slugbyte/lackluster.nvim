const util = @import("./lib/util.zig");
const Color = @import("./lib/color.zig");
const log = util.log;
const strfmt = util.strfmt;

const DEBUG = false;
var exa_colors: util.StringBuilder = undefined;

fn setItem(name: []const u8, color: Color) void {
    if (DEBUG) {
        exa_colors.write(strfmt("\n{s}={s}", .{ name, color.name }));
    } else {
        exa_colors.write(strfmt(":{s}={s}", .{ name, color.toStringExa() }));
    }
}

fn setGroup(color: Color, group: []const []const u8) void {
    for (group) |name| {
        setItem(name, color);
    }
}

fn setGlobGroup(color: Color, group: []const []const u8) void {
    for (group) |file_extension| {
        const name = strfmt("*.{s}", .{file_extension});
        setItem(name, color);
    }
}

pub fn main() !void {
    util.initGlobalArena();
    defer util.deinitGlobalArena();

    exa_colors = util.StringBuilder.init();
    defer exa_colors.deinit();

    // order matters for exa_colors
    // git
    setItem("ex", Color.Green); // executable
    setItem("fi", Color.Gray8); // file
    setItem("di", Color.Gray5); // dir
    setGroup(Color.Red, &.{
        "b0", // broken link path
        "or", // broken symlink
    }); // link broken
    setGroup(Color.Lack, &.{
        "ln", // link
        "lp", // link path
        "lc", // link count
        "lm", // multi link
    });

    setGroup(Color.Blue, &.{
        "bd", // block device
        "cd", // char device
        "pi", // pipe
        "so", // socket
    });

    // permissions
    setGroup(Color.Gray6, &.{
        "ur", // user read
        "uw", // user write
        "ux", // user execute (files)
        "ue", // user execute (file types)
        "gr", // group read
        "gw", // group write
        "gx", // group execute
        "tr", // other read
        "tw", // other write
        "tx", // other execute
        "su", // higher bits files
        "sf", // higher bits non-file
        "xa", // extended attribute
    });

    // metadata
    setItem("hd", Color.Gray4); // headers
    setGroup(Color.Gray6, &.{
        "bl", // number of blocks
        "cc", // control char
        "da", // date
        "in", // inode
        "xx", // punctutation
    });

    // git
    setItem("ga", Color.Green);
    setItem("gd", Color.Orange);
    setGroup(Color.Blue, &.{
        "gm", // git modify
        "gv", // get rename
        "gt", // get type change
    });

    // device
    setGroup(Color.Gray6, &.{
        "df", // major device id
        "ds", // minor device id
    });

    // size
    setItem("sb", Color.Gray5); // size unit
    setItem("sn", Color.Gray7); // size number

    // owners
    setGroup(Color.Gray5, &.{
        "uu", // user you
        "un", // user not you
        "gu", // group yous
        "gn", // group not yours
    });

    // normal
    setGroup(Color.Gray8, &.{ "Makefile", "Cargo.toml", "SConstruct", "CMakeLists.txt", "build.gradle", "pom.xml", "Rakefile", "package.json", "Gruntfile.js", "Gruntfile.coffee", "BUILD", "BUILD.bazel", "WORKSPACE", "build.xml", "Podfile", "webpack.config.js", "meson.build", "composer.json", "RoboFile.php", "PKGBUILD", "Justfile", "Procfile", "Dockerfile", "Containerfile", "Vagrantfile", "Brewfile", "Gemfile", "Pipfile", "build.sbt", "mix.exs", "bsconfig.json", "tsconfig.json", "build.zig", "build.zig.zon" });
    setGlobGroup(Color.Gray8, &.{ "md", "txt", "json", "toml", "yaml", "js", "djvu", "doc", "docx", "dvi", "eml", "eps", "fotd", "key", "odp", "odt", "pdf", "ppt", "pptx", "rtf", "xls", "xlsx" });

    // compiled
    setGlobGroup(Color.Gray6, &.{ "class", "elc", "hi", "o", "pyc", "zwc", "ko" });

    // image
    setGlobGroup(Color.Gray6, &.{ "arb", "bmp", "cbr", "cbz", "cr2", "dvi", "eps", "gif", "heif", "ico", "jpeg", "jpg", "nef", "orf", "pbm", "pgm", "png", "pnm", "ppm", "ps", "raw", "stl", "svg", "tif", "tiff", "webp" });

    // video
    setGlobGroup(Color.Gray6, &.{ "avi", "flv", "heic", "m2ts", "m2v", "mkv", "mov", "mp4", "mpeg", "mpg", "ogm", "ogv", "ts", "vob", "webm", "wmv" });

    // audio
    setGlobGroup(Color.Gray6, &.{ "aac", "alac", "ape", "flac", "m4a", "mka", "mp3", "ogg", "opus", "wav", "wma" });

    // archive
    setGlobGroup(Color.Gray6, &.{ "7z", "a", "ar", "bz2", "deb", "dmg", "gz", "iso", "lzma", "par", "rar", "rpm", "tar", "tc", "tgz", "txz", "z", "Z", "zip", "zst" });

    //temp
    setGlobGroup(Color.Gray6, &.{ "bak", "bk", "swn", "swo", "swp", "tmp" });

    // crypto
    setGlobGroup(Color.Orange, &.{ "asc", "enc", "gpg", "p12", "pfx", "pgp", "sig", "signature" });

    // first char is a colon and should not be printed
    util.logfmt("export EZA_COLORS='{s}'", .{exa_colors.getString()[1..]});
}
