const std = @import("std");
const util = @import("./lib/util.zig");
const Color = @import("./lib/color.zig");

pub fn main() void {
    util.initGlobalArena();
    defer util.deinitGlobalArena();

    for (Color.pallet_list) |color| {
        util.log(util.strfmt("color_{s}=\"#{s}\"", .{ color.name, color.hexcode }));
    }
}
