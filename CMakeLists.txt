cmake_minimum_required(VERSION 3.15)

# Build output
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/bin/$<CONFIG>)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/bin/$<CONFIG>)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/bin/$<CONFIG>)

# CMake options
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED)

project(test_engine CXX)

# External DIR
set(IMGUI_DIR ${CMAKE_CURRENT_SOURCE_DIR}/external/imgui)

# Find module folder
set(CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/cmake)

# Find 3rd party
find_package(OpenGL)
find_package(glfw3)
#find_package(SDL2)

# Build 3rd party
add_subdirectory(cmake/imgui)

# Project Options
if(WIN32)
    if(CMAKE_CXX_COMPILER_ID STREQUAL "Clang")
        add_compile_definitions(_WIN_CLANG)
    endif()
endif()

# Test Engine
set(ENGINE_SRC
    main.cpp
    raytracing/camera.h
    raytracing/color.h
    raytracing/hittable_list.h
    raytracing/hittable.h
    raytracing/material.h
    raytracing/ray.h
    raytracing/rtweekend.h
    raytracing/sphere.h
    raytracing/vec3.h
)

if(OpenGL_FOUND AND glfw3_FOUND)
    add_compile_definitions(_DRIVER_OGL3)

    list(APPEND ENGINE_SRC
        driver_ogl3.h
        driver_ogl3.cpp
    )
endif()

if(WIN32)
    list(APPEND ENGINE_SRC_
        driver_dx12.h
        driver_dx12.cpp
    )
    list(APPEND LIBS_DEPS_
        d3d12.lib
        d3dcompiler.lib
        dxgi.lib
    )
endif()

add_executable(${PROJECT_NAME} ${ENGINE_SRC})
target_link_libraries(${PROJECT_NAME} PUBLIC imgui ${LIBS_DEPS})
target_include_directories(${PROJECT_NAME} PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}/raytracing)