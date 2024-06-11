const std = @import("std");

var stdout_mutex = std.Thread.Mutex{};
var _gpa: std.heap.GeneralPurposeAllocator(.{}) = undefined;
var _arena: std.heap.ArenaAllocator = undefined;

pub var arena: std.mem.Allocator = undefined;
pub const TERM_RESET = "\x1b[0m";

pub fn strfmt(comptime fmt: []const u8, args: anytype) []u8 {
    return std.fmt.allocPrint(arena, fmt, args) catch @panic("fmtstr failed: " ++ fmt);
}

pub fn logfmt(comptime fmt: []const u8, args: anytype) void {
    stdout_mutex.lock();
    defer stdout_mutex.unlock();
    const stdout = std.io.getStdOut().writer();
    nosuspend stdout.print(fmt ++ "\n", args) catch return;
}

pub fn log(msg: []const u8) void {
    return logfmt("{s}", .{msg});
}

pub fn initGlobalArena() void {
    _gpa = std.heap.GeneralPurposeAllocator(.{}){};
    _arena = std.heap.ArenaAllocator.init(_gpa.allocator());
    arena = _arena.allocator();
}

pub fn deinitGlobalArena() void {
    _arena.deinit();
    _ = _gpa.deinit();
}

pub const StringBuilder = struct {
    store: std.ArrayList(u8),

    pub fn init() StringBuilder {
        return .{
            .store = std.ArrayList(u8).init(arena),
        };
    }

    pub fn deinit(self: *StringBuilder) void {
        self.store.deinit();
    }

    pub fn write(self: *StringBuilder, text: []const u8) void {
        self.store.appendSlice(text) catch @panic("failed to write to StringBuilder");
    }

    pub fn getString(self: *StringBuilder) []u8 {
        return self.store.items;
    }
};
