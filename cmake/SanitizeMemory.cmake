if ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "GNU")
    message(WARNING "MemorySanitizer might not be available with gcc")
else()
    message(STATUS "MemorySanitizer enabled")
endif()

add_compile_options(
    -O1
    -g3

    -fsanitize=memory
    -fsanitize-memory-track-origins

    -fno-omit-frame-pointer # Leave frame pointers. Allows the fast unwinder to function properly.
    -fno-common # Do not treat global variable in C as common variables (allows ASan to instrument them)
    -fno-optimize-sibling-calls # disable inlining and and tail call elimination for perfect stack traces
)

# set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -fsanitize=memory" CACHE INTERNAL "" FORCE)
# set(CMAKE_SHARED_LINKER_FLAGS "${CMAKE_SHARED_LINKER_FLAGS} -fsanitize=memory" CACHE INTERNAL "" FORCE)
# set(CMAKE_MODULE_LINKER_FLAGS "${CMAKE_MODULE_LINKER_FLAGS} -fsanitize=memory" CACHE INTERNAL "" FORCE)

add_link_options("-fsanitize=memory")