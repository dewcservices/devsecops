cmake_minimum_required(VERSION 3.10.0)
project(cpp-template VERSION 0.1.0 LANGUAGES C CXX)

add_executable(cpp-template main.cpp)

include(CTest)
enable_testing()

set_property(TARGET cpp-template PROPERTY CXX_STANDARD 23)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)