cmake_minimum_required(VERSION 3.5)

project(cpp_lite
        VERSION 0.0.1
        LANGUAGES CXX)
set(TARGET_NAME ${PROJECT_NAME})

set(PROJ_SOURCE_DIR ${PROJECT_SOURCE_DIR})
set(PROJ_BINARY_DIR "${CMAKE_CURRENT_BINARY_DIR}")
set(CMAKE_MODULE_PATH ${PROJECT_SOURCE_DIR}/cmake)
include(common)

# Options.
    # send option definitions to cmake cache
    #Build tests by default. We want run tests whether we are developing or building a release. I mean... why wouldn't you? :)
    option(BUILD_TESTS "Build all tests." ON)

message(STATUS "CMAKE_BUILD_TYPE: ${CMAKE_BUILD_TYPE}")

# get git version
add_custom_target(  git_version_tgt ALL
                    COMMAND ${CMAKE_COMMAND} -P ${CMAKE_CURRENT_SOURCE_DIR}/cmake/version/git_version.cmake
                    COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/git_version.h ${CMAKE_CURRENT_BINARY_DIR}
                    COMMAND ${CMAKE_COMMAND} -E remove ${CMAKE_CURRENT_SOURCE_DIR}/git_version.h
                    WORKING_DIRECTORY ${PROJECT_SOURCE_DIR}
                    DEPENDS ${CMAKE_CURRENT_SOURCE_DIR}/cmake/version/git_version.cmake
                            ${CMAKE_CURRENT_SOURCE_DIR}/cmake/version/git_version.h.in)


message(STATUS "target: ${TARGET_NAME}")
message(STATUS "build type: ${CMAKE_BUILD_TYPE}")

add_subdirectory(src/lib/version)
add_subdirectory(src/modules/logger)
add_subdirectory(src/examples)

# test
    if (${BUILD_TESTS})
        enable_testing()
        include(cmake/doctest.cmake)
        add_subdirectory("thirdparty/doctest")
        add_subdirectory(tests)
    endif()
