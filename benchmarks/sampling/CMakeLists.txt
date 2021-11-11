cmake_minimum_required(VERSION 3.0 FATAL_ERROR)
project(PSE_SAMPLING)
set (CMAKE_CXX_STANDARD 17)

include_directories(include)
include_directories($ENV{HOME}/klee/include)
cmake_policy(SET CMP0083 OLD)

add_definitions(
    -D__STDC_LIMIT_MACROS
    -D__STDC_CONSTANT_MACROS
)

set(CMAKE_CXX_FLAGS "-Wall -g -O3 -march=native" CACHE STRING "" FORCE)

add_executable (reservoir reservoir.cpp)
add_executable (freivalds freivalds_int.cpp)
add_executable (quicksort_N5 quicksort_N5.cpp)
add_executable (quicksort_N4 quicksort_N4.cpp)
add_executable (partition partition.cpp)
add_executable (montyhall montyhall.cpp)
add_executable (flips flips.cpp)