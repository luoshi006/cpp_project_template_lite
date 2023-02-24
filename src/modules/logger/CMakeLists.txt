
add_subdirectory(${PROJ_SOURCE_DIR}/thirdparty/spdlog ${PROJ_BINARY_DIR}/thirdparty/spdlog)

add_library(lib_log log.cpp)

# CMP0076
target_sources(lib_log
                PUBLIC  ${CMAKE_CURRENT_SOURCE_DIR}/log.h
                PRIVATE ${CMAKE_CURRENT_SOURCE_DIR}/log.cpp)
target_include_directories(lib_log PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})
target_link_libraries(lib_log PUBLIC spdlog::spdlog)
