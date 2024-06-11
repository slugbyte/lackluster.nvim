const std = @import("std");
const util = @import("./lib/util.zig");
const Color = @import("./lib/color.zig");

const log = util.log;
const strfmt = util.strfmt;

pub fn main() !void {
    util.initGlobalArena();
    defer util.deinitGlobalArena();

    const color_list = [_]Color{
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

    log("name reset                     \\x1b[0m");
    for (color_list) |color| {
        log(color.describe());
    }
}
