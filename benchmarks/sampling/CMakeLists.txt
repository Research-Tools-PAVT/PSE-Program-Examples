cmake_minimum_required(VERSION 3.0 FATAL_ERROR)
project(problems_project)
set (CMAKE_CXX_STANDARD 17)

include_directories(include)
cmake_policy(SET CMP0065 OLD)
cmake_policy(SET CMP0083 OLD)
set(CMAKE_SUPPRESS_REGENERATION 1)

add_definitions(
    -D__STDC_LIMIT_MACROS
    -D__STDC_CONSTANT_MACROS
)

set(CMAKE_CXX_FLAGS "-Wall -g -O3 -march=native -fsanitize=address -fsanitize=leak" CACHE STRING "" FORCE)
add_executable (reservoir reservoir_sample.cpp)
add_executable (freivalds freivalds_int.cpp)
set_property(TARGET $ENV{RUNNER} PROPERTY CXX_STANDARD 17)