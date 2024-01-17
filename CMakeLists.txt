cmake_minimum_required(VERSION 3.15)

# Build output
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/bin/$<CONFIG>)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/bin/$<CONFIG>)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/bin/$<CONFIG>)

# CMake options
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED)

project(engine CXX)

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
    src/main.cpp
)

if(OpenGL_FOUND AND glfw3_FOUND)
    add_compile_definitions(_DRIVER_OGL3)

    list(APPEND ENGINE_SRC
        src/driver/driver_ogl3.h
        src/driver/driver_ogl3.cpp
    )
endif()

if(WIN32)
    list(APPEND ENGINE_SRC_
        src/driver/driver_dx12.h
        src/driver/driver_dx12.cpp
    )
    list(APPEND LIBS_DEPS_
        d3d12.lib
        d3dcompiler.lib
        dxgi.lib
    )
endif()

add_executable(${PROJECT_NAME} ${ENGINE_SRC})
target_link_libraries(${PROJECT_NAME} PRIVATE imgui ${LIBS_DEPS})
target_include_directories(${PROJECT_NAME} PRIVATE ${CMAKE_CURRENT_SOURCE_DIR}/src ${CMAKE_CURRENT_SOURCE_DIR}/src/driver)