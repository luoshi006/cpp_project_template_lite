# refs: https://github.com/MhmRhm/version-from-git
# find_package(Git) -> finds the location of the git executable
# git describe --always --abbrev=8 -> gives the abbreviated hash
# git status --short -> checks for uncommitted  work
# git describe --exact-match --tags -> gives the tag
# git rev-parse --abbrev-ref HEAD -> gives current branch
# git log -n 1 --pretty=%cd --pretty=%cI -> gives the time of the last commit

find_package(Git QUIET)
set(PROJECT_SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR})

if(GIT_FOUND AND EXISTS "${PROJECT_SOURCE_DIR}/.git")
    execute_process(COMMAND ${GIT_EXECUTABLE} log --pretty=format:'%h' -n 1
                    OUTPUT_VARIABLE GIT_REV
                    ERROR_QUIET)
endif()

if ("${GIT_REV}" STREQUAL "")
    set(GIT_COMMIT "N/A")
    set(GIT_DIFF "")
    set(GIT_TAG "N/A")
    set(GIT_BRANCH "N/A")
    set(GIT_DATE "N/A")
else()
    execute_process(COMMAND ${GIT_EXECUTABLE} describe --always --abbrev=8
                    WORKING_DIRECTORY ${PROJECT_SOURCE_DIR}
                    OUTPUT_VARIABLE GIT_COMMIT
                    OUTPUT_STRIP_TRAILING_WHITESPACE
                    ERROR_QUIET)
    execute_process(COMMAND ${GIT_EXECUTABLE} describe --exact-match --tags
                    WORKING_DIRECTORY ${PROJECT_SOURCE_DIR}
                    OUTPUT_VARIABLE GIT_TAG
                    OUTPUT_STRIP_TRAILING_WHITESPACE
                    ERROR_QUIET)
    execute_process(COMMAND ${GIT_EXECUTABLE} rev-parse --abbrev-ref HEAD
                    WORKING_DIRECTORY ${PROJECT_SOURCE_DIR}
                    OUTPUT_VARIABLE GIT_BRANCH
                    OUTPUT_STRIP_TRAILING_WHITESPACE
                    ERROR_QUIET)
    if ("${GIT_BRANCH}" STREQUAL "")
        set(GIT_BRANCH "N/A")
    endif()
    execute_process(COMMAND ${GIT_EXECUTABLE} log -n 1 --pretty=%cd --pretty=%cI
                    WORKING_DIRECTORY ${PROJECT_SOURCE_DIR}
                    OUTPUT_VARIABLE GIT_DATE
                    OUTPUT_STRIP_TRAILING_WHITESPACE)
    if ("${GIT_DATE}" STREQUAL "")
        set(GIT_DATE "N/A")
    endif()
    execute_process(COMMAND bash -c "git diff --quiet --exit-code || echo +"
                    OUTPUT_VARIABLE GIT_DIFF
                    OUTPUT_STRIP_TRAILING_WHITESPACE)
endif()

# date +%Y%m%d_%H_%M_%S
execute_process(COMMAND date +%Y%m%d_%H_%M_%S
                OUTPUT_VARIABLE BUILD_TIME
                OUTPUT_STRIP_TRAILING_WHITESPACE)

# uname --nodename
execute_process(COMMAND whoami
                OUTPUT_VARIABLE BUILD_HOSTNAME
                OUTPUT_STRIP_TRAILING_WHITESPACE)

message(STATUS "GIT_HASH: ${GIT_COMMIT}${GIT_DIFF}")
message(STATUS "GIT_TAG: ${GIT_TAG}")
message(STATUS "GIT_BRANCH: ${GIT_BRANCH}")
message(STATUS "GIT_DATE: ${GIT_DATE}")
message(STATUS "BUILD_TIME: ${BUILD_TIME}")
message(STATUS "BUILD_HOST: ${BUILD_HOSTNAME}")

# replaces matching variabels in gitversion.h.in file and writes it to gitversion.h
configure_file(${CMAKE_CURRENT_SOURCE_DIR}/cmake/version/git_version.h.in ${CMAKE_CURRENT_SOURCE_DIR}/git_version.h)
