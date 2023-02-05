#include "imgui.h"
#include "imgui_impl_glfw.h"
#include "imgui_impl_opengl3.h"
#include <stdio.h>
#define GL_SILENCE_DEPRECATION

#include <GLFW/glfw3.h> // Will drag system OpenGL headers

static void glfw_error_callback(int error, const char* description)
{
    fprintf(stderr, "GLFW Error %d: %s\n", error, description);
}

class OGL3_DRIVER {
    public:
        OGL3_DRIVER();
        ~OGL3_DRIVER() {};

        bool init_driver();
        void loop();
        bool clean_driver();

    private:
        GLFWwindow* _window;

        // State
        bool show_demo_window;
        bool show_another_window;
        ImVec4 clear_color;
};