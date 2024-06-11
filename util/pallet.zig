const std = @import("std");
const util = @import("./lib/util.zig");
const Color = @import("./lib/color.zig");

const log = util.log;
const strfmt = util.strfmt;

pub fn main() !void {
    util.initGlobalArena();
    defer util.deinitGlobalArena();

    log("name reset                             \\x1b[0m");
    for (Color.pallet_list) |color| {
        log(color.describe());
    }
}
