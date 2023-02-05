# Find glfw3
# This module defines the following variables:
#
# glfw3_LIBRARY the name of the library;
# glfw3_INCLUDE_DIR where to find glfw include files.
# glfw3_FOUND true if both the glfw3_LIBRARY and glfw3_INCLUDE_DIR have been found.
#
# Cmake file from: https://github.com/daw42/glslcookbook

set(_glfw3_HEADER_SEARCH_DIRS
    "/usr/include"
    "/usr/local/include"
    "${CMAKE_SOURCE_DIR}/external/glfw/include"
)
set(_glfw3_LIB_SEARCH_DIRS
    "/usr/lib"
    "/usr/local/lib"
)

if(WIN32)
    if(CMAKE_CXX_COMPILER_ID STREQUAL "Clang")
        list(APPEND _glfw3_LIB_SEARCH_DIRS
            "${CMAKE_SOURCE_DIR}/external/glfw/lib-clang"
        )
    elseif(NOT MSVC)
        list(APPEND _glfw3_LIB_SEARCH_DIRS
            "${CMAKE_SOURCE_DIR}/external/glfw/lib-mingw-w64"
        )
    elseif(MSVC_TOOLSET_VERSION EQUAL 141)
        list(APPEND _glfw3_LIB_SEARCH_DIRS
            "${CMAKE_SOURCE_DIR}/external/glfw/lib-vc2017"
        )
    elseif(MSVC_TOOLSET_VERSION EQUAL 142)
        list(APPEND _glfw3_LIB_SEARCH_DIRS
            "${CMAKE_SOURCE_DIR}/external/glfw/lib-vc2019"
        )
    elseif(MSVC_TOOLSET_VERSION EQUAL 143)
        list(APPEND _glfw3_LIB_SEARCH_DIRS
            "${CMAKE_SOURCE_DIR}/external/glfw/lib-vc2022"
        )
    endif()
endif()

# Check environment for root search directory
if($ENV{GLFW3_ROOT})
    if(NOT GLFW3_ROOT)
        set(GLFW3_ROOT $ENV{GLFW3_ROOT})
    endif()
endif()

# Put user specified location at beginning of search
if(GLFW3_ROOT)
    list(APPEND _glfw3_HEADER_SEARCH_DIRS "${GLFW3_ROOT}/include")
    list(APPEND _glfw3_LIB_SEARCH_DIRS "${GLFW3_ROOT}/lib")
endif()

# Search for the header
find_path(glfw3_INCLUDE_DIR "GLFW/glfw3.h"
    PATHS ${_glfw3_HEADER_SEARCH_DIRS}
)

# Search for the library
find_library(glfw3_LIBRARY
    NAMES glfw3 glfw
    PATHS ${_glfw3_LIB_SEARCH_DIRS}
)

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(glfw3 DEFAULT_MSG glfw3_LIBRARY glfw3_INCLUDE_DIR)