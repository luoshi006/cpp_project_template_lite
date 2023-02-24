set(CMAKE_SYSTEM_NAME         Linux)
set(CMAKE_SYSTEM_PROCESSOR    arm)

# search for programs in the build host directories
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
# for libraries and headers in the target directories
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)

set(CMAKE_C_COMPILER    arm-linux-gnueabihf-gcc)
set(CMAKE_CXX_COMPILER  arm-linux-gnueabihf-g++)

# add_definitions(-march=armv7)
# add_definitions(-mfloat-abi=hard)
# add_definitions(-mfpu=neon)