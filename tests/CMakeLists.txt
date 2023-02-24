cmake_minimum_required(VERSION 3.10)

set(TESTS_SRCS
    test_true.cpp
)

# https://blog.csdn.net/10km/article/details/50508184
add_custom_target(check)
string(REPLACE ".cpp" "" tests "${TESTS_SRCS}")
foreach(test_name ${tests})
    add_executable(${test_name} EXCLUDE_FROM_ALL ${test_name}.cpp)
    target_link_libraries(${test_name} PRIVATE doctest::doctest)
    add_dependencies(check ${test_name})

    # automatic discovery of unit tests
    doctest_discover_tests(${test_name})
endforeach()
