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

    // source files
    setItem("sc", Color.Gray8);

    // build files (like Makefile)
    setItem("bu", Color.Gray8);

    // compiled/build artifact (like .o files)
    setItem("cm", Color.Gray6);

    // temp
    setItem("tm", Color.Gray6);

    // compressed file
    setItem("co", Color.Gray6);

    // doc
    setItem("do", Color.Gray6);

    // crypto
    setItem("cr", Color.Orange);

    // image
    setItem("im", Color.Gray6);

    // audio
    setItem("lo", Color.Gray6);
    setItem("mu", Color.Gray6);

    // video
    setItem("vi", Color.Gray6);

    // mount point
    setItem("mp", Color.Gray6);

    // first char is a colon and should not be printed
    util.logfmt("export EZA_COLORS='{s}'", .{exa_colors.getString()[1..]});
}
