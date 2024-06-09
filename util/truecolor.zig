const std = @import("std");
const TERM_RESET = "\x1b[0m";

// this is just a build script, so i decided to have a global arena allocator
var arena: std.mem.Allocator = undefined;

pub fn log(comptime fmt: []const u8, args: anytype) void {
    std.debug.print(fmt ++ "\n", args);
}

pub fn logColor(comptime fmt: []const u8, args: anytype, color: Color) void {
    const color_code = color.toTermcolor() catch unreachable;
    std.debug.print("{s}", .{color_code});
    std.debug.print(fmt ++ "\n", args);
    std.debug.print("{s}", .{TERM_RESET});
}

const Color = struct {
    r: u8,
    g: u8,
    b: u8,
    pub fn fromHexcode(comptime hexcode: []const u8) !Color {
        if (hexcode.len != 6) {
            @compileError("color hexcode string must be 6 chars long");
        }
        const r: u8 = try std.fmt.parseInt(u8, hexcode[0..2], 16);
        const g: u8 = try std.fmt.parseInt(u8, hexcode[2..4], 16);
        const b: u8 = try std.fmt.parseInt(u8, hexcode[4..6], 16);

        return Color{
            .r = r,
            .g = g,
            .b = b,
        };
    }

    pub fn toStringRGB(self: Color) ![]u8 {
        return try std.fmt.allocPrint(arena, "rgb({d}, {d}, {d})", .{ self.r, self.g, self.b });
    }

    pub fn toTermcolor(self: Color) ![]u8 {
        return try std.fmt.allocPrint(arena, "\x1b[38;2;{d};{d};{d}m", .{ self.r, self.g, self.b });
    }
};

pub fn main() !void {
    var _gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = _gpa.deinit();
    var _arena = std.heap.ArenaAllocator.init(_gpa.allocator());
    defer _arena.deinit();
    arena = _arena.allocator();

    const blue = try Color.fromHexcode("99aaff");
    logColor("{s}", .{try blue.toStringRGB()}, blue);
    log("cool huh", .{});
}
