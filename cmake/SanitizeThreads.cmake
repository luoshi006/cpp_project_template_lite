
message(STATUS "ThreadSanitizer enabled")

add_compile_options(
    -g3
    -fsanitize=thread
)

# set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -fsanitize=thread" CACHE INTERNAL "" FORCE)
# set(CMAKE_SHARED_LINKER_FLAGS "${CMAKE_SHARED_LINKER_FLAGS} -fsanitize=thread" CACHE INTERNAL "" FORCE)
# set(CMAKE_MODULE_LINKER_FLAGS "${CMAKE_MODULE_LINKER_FLAGS} -fsanitize=thread" CACHE INTERNAL "" FORCE)

add_link_options("-fsanitize=thread")