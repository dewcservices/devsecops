cmake_minimum_required(VERSION 3.13)  
project(example)               

include(CTest)
enable_testing()

add_executable(example main.cpp)
set_property(TARGET example PROPERTY CMAKE_CXX_STANDARD 14 )