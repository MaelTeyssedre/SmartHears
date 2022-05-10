cmake_minimum_required(VERSION 3.14)
project(testing_test)

set(CMAKE_CXX_STANDARD 14)

include_directories(CppUT_lib)
add_subdirectory(CppUT_lib)

add_subdirectory(Doctest_tests)
