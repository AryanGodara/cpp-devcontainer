cmake_minimum_required(VERSION 3.20)
project(hello LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 20)          # bump to 23 if you want
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

# Needed by clangd for IntelliSense.
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

add_executable(hello src/main.cpp)
