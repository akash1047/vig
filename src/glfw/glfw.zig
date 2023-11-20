pub const GlfwError = @import("error.zig").GlfwError;
pub const ffi = @import("ffi.zig");

pub fn Glfwinit() GlfwError!void {
    if (ffi.glfwInit() != 1) return GlfwError.PlatformError;
}

pub fn terminate() void {
    ffi.glfwTerminate();
}

pub fn pollEvents() void {
    ffi.glfwPollEvents();
}

pub const hint = @import("hints.zig");

pub const Window = struct {
    pub const WindowPtr = *ffi.GlfwMonitor;
    ptr: WindowPtr,

    pub fn destroy(self: *Window) void {
        ffi.glfwDestroyWindow(self.ptr);
    }

    pub fn shouldClose(self: *const Window) bool {
        return ffi.glfwWindowShouldClose(self.ptr) == 1;
    }
};

pub fn createWindow(width: u16, height: u16, title: []const u8) GlfwError!Window {
    if (ffi.glfwCreateWindow(width, height, @ptrCast(title), null, null)) |ptr| {
        return .{ .ptr = ptr };
    }

    return GlfwError.GlfwWindowCreationFailed;
}
