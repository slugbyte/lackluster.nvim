const std = @import("std");
const Allocator = std.mem.Allocator;

pub fn NumberBuffer(comptime T: type) type {
    switch (@typeInfo(T)) {
        .Int => {},
        .Float => {},
        else => {
            @compileError("NumberBuffer only suports int and float types!");
        },
    }
    return struct {
        const Self = @This();
        buf: []T,
        allocator: Allocator,

        fn init(allocator: Allocator, size: usize) !Self {
            const buf = try allocator.alloc(T, size);
            return .{
                .buf = buf,
                .allocator = allocator,
            };
        }

        fn deinit(self: *Self) void {
            self.allocator.free(self.buf);
        }
    };
}
