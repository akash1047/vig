pub const GLFW = @cImport({
    @cInclude("GLFW/glfw3.h");
});

pub const GlfwError = error{
    GlfwPlatformError,
    GlfwWindowCreationFailed,
};

pub fn init() GlfwError!void {
    if (GLFW.glfwInit() != GLFW.GLFW_TRUE)
        return GlfwError.GlfwPlatformError;
}

pub fn terminate() void {
    GLFW.glfwTerminate();
}

pub fn pollEvents() void {
    GLFW.glfwPollEvents();
}

pub const hint = struct {
    pub const OptHintFn = fn (bool) void;

    fn Optionals(comptime glfw_hint: c_int) OptHintFn {
        const closure = struct {
            pub fn yield(opt: bool) void {
                GLFW.glfwWindowHint(glfw_hint, if (opt) GLFW.GLFW_TRUE else GLFW.GLFW_FALSE);
            }
        };

        return closure.yield;
    }

    pub const Resizable = Optionals(GLFW.GLFW_RESIZABLE);
    pub const Visiable = Optionals(GLFW.GLFW_VISIBLE);

    pub const NoParamHintFn = fn () void;

    fn NoParamHints(comptime glfw_hint: c_int, comptime value: c_int) NoParamHintFn {
        const closure = struct {
            pub fn yield() void {
                GLFW.glfwWindowHint(glfw_hint, value);
            }
        };

        return closure.yield;
    }

    pub const NoApi = NoParamHints(GLFW.GLFW_CLIENT_API, GLFW.GLFW_NO_API);
};

pub const Window = struct {
    pub const WindowPtr = *GLFW.GLFWwindow;
    ptr: WindowPtr,

    pub fn destroy(self: *Window) void {
        GLFW.glfwDestroyWindow(self.ptr);
    }

    pub fn shouldClose(self: *const Window) bool {
        return GLFW.glfwWindowShouldClose(self.ptr) == GLFW.GLFW_TRUE;
    }
};

pub fn createWindow(width: u16, height: u16, title: []const u8) GlfwError!Window {
    if (GLFW.glfwCreateWindow(width, height, @ptrCast(title), null, null)) |ptr| {
        return .{ .ptr = ptr };
    }

    return GlfwError.GlfwWindowCreationFailed;
}
