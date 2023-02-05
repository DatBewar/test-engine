project(imgui)

set(IMGUI_HEADERS
    ${IMGUI_DIR}/imgui.h
    ${IMGUI_DIR}/imconfig.h
    ${IMGUI_DIR}/imstb_rectpack.h
    ${IMGUI_DIR}/imstb_textedit.h
    ${IMGUI_DIR}/imstb_truetype.h
    ${IMGUI_DIR}/imgui_internal.h
)

set(IMGUI_SRC
    ${IMGUI_DIR}/imgui.cpp
    ${IMGUI_DIR}/imgui_demo.cpp
    ${IMGUI_DIR}/imgui_draw.cpp
    ${IMGUI_DIR}/imgui_tables.cpp
    ${IMGUI_DIR}/imgui_widgets.cpp
)

set(BACKEND_DIR ${IMGUI_DIR}/backends)

# Backend WIN32 DX9 DX11 DX12
if(WIN32)
    list(APPEND IMGUI_IMPL_HEADERS
        ${BACKEND_DIR}/imgui_impl_win32.h
        ${BACKEND_DIR}/imgui_impl_dx9.h
        ${BACKEND_DIR}/imgui_impl_dx11.h
        ${BACKEND_DIR}/imgui_impl_dx12.h
    )

    list(APPEND IMGUI_IMPL_SRC
        ${BACKEND_DIR}/imgui_impl_win32.cpp
        ${BACKEND_DIR}/imgui_impl_dx9.cpp
        ${BACKEND_DIR}/imgui_impl_dx11.cpp
        ${BACKEND_DIR}/imgui_impl_dx12.cpp
    )
elseif(APPLE)
    list(APPEND IMGUI_IMPL_HEADERS
        ${BACKEND_DIR}/imgui_impl_osx.h
        ${BACKEND_DIR}/imgui_impl_metal.h
    )

    list(APPEND IMGUI_IMPL_SRC
        ${BACKEND_DIR}/imgui_impl_osx.mm
        ${BACKEND_DIR}/imgui_impl_metal.mm
    )
endif()

# Backend OPENGL
if(OpenGL_FOUND)
    list(APPEND IMGUI_DEPS OpenGL::GL)

    list(APPEND IMGUI_IMPL_HEADERS
        ${BACKEND_DIR}/imgui_impl_opengl2.h
        ${BACKEND_DIR}/imgui_impl_opengl3.h
        ${BACKEND_DIR}/imgui_impl_opengl3_loader.h
    )

    list(APPEND IMGUI_IMPL_SRC
        ${BACKEND_DIR}/imgui_impl_opengl2.cpp
        ${BACKEND_DIR}/imgui_impl_opengl3.cpp
    )

    list(APPEND DEPS_INCLUDE_DIR
        ${OPENGL_INCLUDE_DIR}
    )
endif()

# Backend GLFW3
if(glfw3_FOUND)
    list(APPEND IMGUI_DEPS ${glfw3_LIBRARY})

    list(APPEND IMGUI_IMPL_HEADERS
        ${BACKEND_DIR}/imgui_impl_glfw.h
    )

    list(APPEND IMGUI_IMPL_SRC
        ${BACKEND_DIR}/imgui_impl_glfw.cpp
    )

    list(APPEND DEPS_INCLUDE_DIR
        ${glfw3_INCLUDE_DIR}
    )
endif()

# IMGUI Lib
add_library(${PROJECT_NAME} STATIC ${IMGUI_SRC} ${IMGUI_HEADERS} ${IMGUI_IMPL_SRC} ${IMGUI_IMPL_HEADERS})

target_link_libraries(${PROJECT_NAME}
    PUBLIC
        ${IMGUI_DEPS}
)

target_include_directories(${PROJECT_NAME}
    PUBLIC
        ${IMGUI_DIR}
        ${BACKEND_DIR}
        ${DEPS_INCLUDE_DIR}
)