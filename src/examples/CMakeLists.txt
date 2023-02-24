add_executable(hello_version ${CMAKE_CURRENT_SOURCE_DIR}/hello_version.cpp)
target_link_libraries(hello_version
                        PRIVATE
                            lib_version
                            lib_log)
target_compile_options(hello_version PRIVATE "-Wall")
set_target_properties(hello_version PROPERTIES
                        CXX_STANDARD            11
                        CXX_STANDARD_REQUIRED   YES
                        CXX_EXTENSIONS          NO
                        POSITION_INDEPENDENT_CODE ON)

