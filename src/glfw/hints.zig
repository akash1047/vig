pub const GLFW = @cImport({
    @cInclude("GLFW/glfw3.h");
});

const ffi = @import("ffi.zig");

const Hints = enum(c_int) {
    Resizable = 0x00020003,
    ClientApi = 0x00022001,
};

pub const ClientApi = enum(c_int) {
    NoApi = 0x0,
    OpenGLApi = 0x0030001,
    OpenGLEsApi = 0x0030002,
};

pub fn resizable(opt: bool) void {
    ffi.glfwWindowHint(@intFromEnum(Hints.Resizable), @intFromBool(opt));
}

pub fn clientApi(api: ClientApi) void {
    ffi.glfwWindowHint(@intFromEnum(Hints.ClientApi), @intFromEnum(api));
}
