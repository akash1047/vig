const std = @import("std");
const glfw = @import("glfw.zig");

pub fn main() !void {
    try glfw.init();
    defer glfw.terminate();

    glfw.hint.NoApi();
    glfw.hint.Resizable(true);

    var window = try glfw.createWindow(800, 600, "vulkan");
    defer window.destroy();

    while (!window.shouldClose()) {
        glfw.pollEvents();
    }
}
