message(STATUS "UndefinedBehaviorSanitizer enabled")
add_compile_options(
    -g3
    -fsanitize=alignment
    -fsanitize=bool
    -fsanitize=bounds
    -fsanitize=enum
    -fsanitize=float-cast-overflow
    -fsanitize=float-divide-by-zero
    -fsanitize=integer-divide-by-zero
    -fsanitize=nonnull-attribute
    -fsanitize=null
    -fsanitize=object-size
    -fsanitize=return
    -fsanitize=returns-nonnull-attribute
    -fsanitize=shift
    -fsanitize=signed-integer-overflow
    -fsanitize=unreachable
    -fsanitize=vla-bound
    -fno-sanitize-recover=bounds,null
)

add_link_options("-fsanitize=undefined")

# set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -fsanitize=undefined" CACHE INTERNAL "" FORCE)
# set(CMAKE_SHARED_LINKER_FLAGS "${CMAKE_SHARED_LINKER_FLAGS} -fsanitize=undefined" CACHE INTERNAL "" FORCE)
# set(CMAKE_MODULE_LINKER_FLAGS "${CMAKE_MODULE_LINKER_FLAGS} -fsanitize=undefined" CACHE INTERNAL "" FORCE)