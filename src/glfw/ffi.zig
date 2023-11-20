pub const GlfwMonitor = opaque {};

pub extern "C" fn glfwInit() c_int;
pub extern "C" fn glfwTerminate() void;
pub extern "C" fn glfwPollEvents() void;

pub extern "C" fn glfwDefaultWindowHint() void;
pub extern "C" fn glfwWindowHint(hint: c_int, value: c_int) void;

pub extern "C" fn glfwCreateWindow(width: c_int, height: c_int, title: [*c]const u8, monitor: ?*GlfwMonitor, share: ?*GlfwMonitor) ?*GlfwMonitor;
pub extern "C" fn glfwDestroyWindow(win_ptr: *GlfwMonitor) void;
pub extern "C" fn glfwWindowShouldClose(win_ptr: *GlfwMonitor) c_int;
