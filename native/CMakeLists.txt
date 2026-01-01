cmake_minimum_required(VERSION 3.10)
project(judger C)

# Generate shared library for FFI
add_library(judger SHARED
    judger.c
)

# Make sure the header was found
target_include_directories(judger PUBLIC
    ${CMAKE_CURRENT_SOURCE_DIR}
)

# Set standard of C
set_property(TARGET judger PROPERTY C_STANDARD 11)

# Fow windows remove the lib prefix
if (WIN32)
    set_target_properties(judger PROPERTIES PREFIX "")
endif()
