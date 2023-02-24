cmake_minimum_required(VERSION 3.5)

project(doctest)

add_library(${PROJECT_NAME} OBJECT test_main.cpp)
add_library(${PROJECT_NAME}::${PROJECT_NAME} ALIAS ${PROJECT_NAME})
target_include_directories(${PROJECT_NAME} INTERFACE
  $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/>
)