message(STATUS "AddressSanitizer enabled")

# environment variables
#  ASAN_OPTIONS=check_initialization_order=1,detect_stack_use_after_return=1
add_compile_options(
    -O1
    -g3

    -fsanitize=address

    -fno-omit-frame-pointer # Leave frame pointers. Allows the fast unwinder to function properly.
    -fno-common # Do not treat global variable in C as common variables (allows ASan to instrument them)
    -fno-optimize-sibling-calls # disable inlining and and tail call elimination for perfect stack traces
)

# set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -fsanitize=address" CACHE INTERNAL "" FORCE)
# set(CMAKE_SHARED_LINKER_FLAGS "${CMAKE_SHARED_LINKER_FLAGS} -fsanitize=address" CACHE INTERNAL "" FORCE)
# set(CMAKE_MODULE_LINKER_FLAGS "${CMAKE_MODULE_LINKER_FLAGS} -fsanitize=address" CACHE INTERNAL "" FORCE)

add_link_options("-fsanitize=address")