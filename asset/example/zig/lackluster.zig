const std = @import("std");
const Allocator = std.mem.Allocator;

const Lackluster = union(enum) {
    RGBA: struct { r: u8, g: u8, b: u8, a: u8 },
    HSLA: struct { h: f32, s: f32, l: f32, a: f32 },

    fn toStr(self: Lackluster, alloc: Allocator) ![]const u8 {
        switch (self) {
            .RGBA => |rgba| {
                const fmt = "#{x}{x}{x}{x}";
                const args = .{ rgba.r, rgba.g, rgba.b, rgba.a };
                return std.fmt.allocPrint(alloc, fmt, args);
            },
            .HSLA => |hsla| {
                const fmt = "hsla({d:.2}, {d:.2}, {d:.2}, {d:.2})";
                const args = .{ hsla.h, hsla.s, hsla.l, hsla.a };
                return std.fmt.allocPrint(alloc, fmt, args);
            },
        }
    }

    // (h) will be 0-360 degrees, (s,l,a) will be between 0-1
    pub fn hslaFromU32(value: u32) Lackluster {
        const raw_h: f32 = @floatFromInt((value >> 24) & 0xff);
        const raw_s: f32 = @floatFromInt((value >> 16) & 0xff);
        const raw_l: f32 = @floatFromInt((value >> 8) & 0xff);
        const raw_a: f32 = @floatFromInt(value & 0xff);

        return Lackluster{ .HSLA = .{
            .h = (raw_h / 255.0) * 360.0,
            .s = raw_s / 255.0,
            .l = raw_l / 255.0,
            .a = raw_a / 255.0,
        } };
    }

    fn rgbaFromU32(value: u32) Lackluster {
        return Lackluster{ .RGBA = .{
            .r = @truncate(value >> 24),
            .g = @truncate(value >> 16),
            .b = @truncate(value >> 8),
            .a = @truncate(value),
        } };
    }
};

test "Color" {
    const rgba = Lackluster.rgbaFromU32(0xaabbccff);
    const rgbaStr = try rgba.toStr(std.testing.allocator);
    defer std.testing.allocator.free(rgbaStr);
    try std.testing.expect(std.mem.eql(u8, "#aabbccff", rgbaStr));

    const hsla = Lackluster.hslaFromU32(0xaabbccff);
    const hslaStr = try hsla.toStr(std.testing.allocator);
    defer std.testing.allocator.free(hslaStr);
    try std.testing.expect(std.mem.eql(u8, "hsla(240.00, 0.73, 0.80, 1.00)", hslaStr));
}
