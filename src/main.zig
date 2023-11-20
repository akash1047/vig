const std = @import("std");
const glfw = @import("glfw");

pub fn main() !void {
    try glfw.init();
    defer glfw.terminate();

    glfw.hint.resizable(true);
    glfw.hint.clientApi(.NoApi);

    var window = try glfw.createWindow(800, 600, "vig");
    defer window.destroy();

    while (!window.shouldClose()) {
        glfw.pollEvents();
    }
}
