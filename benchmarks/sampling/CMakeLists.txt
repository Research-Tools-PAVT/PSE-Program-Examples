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

set(CMAKE_CXX_FLAGS "-Wall -Wshadow -Wundef -g3 -O3 -fsanitize=undefined -fsanitize=shift -fsanitize=integer-divide-by-zero -fsanitize=vla-bound -fsanitize=signed-integer-overflow -fsanitize=bounds -march=native -fsanitize=address -fsanitize=leak" CACHE STRING "" FORCE)

add_executable (bloomfilter bloomfilter.cpp)
add_executable (freivalds_int freivalds_int.cpp)
add_executable (monotone_binary_int monotone_binary_int.cpp)
add_executable (montyhall montyhall.cpp)
add_executable (quicksort_N4 quicksort_N4.cpp)
add_executable (quicksort_N5 quicksort_N5.cpp)
add_executable (randomized_response randomized_response.cpp)
add_executable (reservoir_v1 reservoir_v1.cpp)
add_executable (reservoir_v2 reservoir_v2.cpp)
add_executable (freivalds_multiple_int freivalds_multiple_int.cpp)
add_executable (flips extras/flips.cpp)