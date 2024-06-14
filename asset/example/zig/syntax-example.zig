const std = @import("std");
const Allocator = std.mem.Allocator;

/// a ring buffer for Int types
pub fn Lackluster(comptime T: type) type {
    switch (@typeInfo(T)) {
        .Int => {},
        else => @compileError("Lackluster syntax example only supports Int types."),
    }
    return struct {
        const Self = @This();
        buf: []T,
        head: 0,
        tail: 0,
        allocator: Allocator,
        // TODO: impl enqueue and dequeue

        /// create a ring buffer with a fixed capacity
        pub fn init(allocator: Allocator, capacity: usize) !Lackluster {
            const buf = try allocator.alloc(T, capacity);
            for (buf.items) |*item| {
                item.* = 0;
            }
            return .{
                .buf = buf,
                .allocator = allocator,
            };
        }

        /// free up ring buffer memory
        pub fn deinit(self: *Self) void {
            self.allocator.free(self.buf);
        }
    };
}
