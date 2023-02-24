############################################################################
# https://devblogs.microsoft.com/cppblog/clear-functional-c-documentation-with-sphinx-breathe-doxygen-cmake/
############################################################################

# Doxygen

option(BUILD_DOCS "Build doxygen documentation" OFF)

if (BUILD_DOCS)
	find_package(Doxygen)
	if (DOXYGEN_FOUND)
	    # set input and output files
	    set(DOXYGEN_IN ${CMAKE_SOURCE_DIR}/Documentation/Doxyfile.in)
	    set(DOXYGEN_OUT ${CMAKE_CURRENT_BINARY_DIR}/Doxyfile)
        set(DOXYGEN_OUTPUT_DIR ${CMAKE_CURRENT_BINARY_DIR}/Documentation/doxygen)
        set(DOXYGEN_INDEX_FILE ${DOXYGEN_OUTPUT_DIR}/xml/index.xml)
        file(MAKE_DIRECTORY ${DOXYGEN_OUTPUT_DIR}) #Doxygen won't create this for us
        # Find all the public headers
        file(GLOB_RECURSE DOXYGEN_ALL_HEADERS ${CMAKE_SOURCE_DIR}/src/*.h)
        message(STATUS "DOXYGEN_ALL_HEADERS ${DOXYGEN_ALL_HEADERS}")


	    # request to configure the file
	    configure_file(${DOXYGEN_IN} ${DOXYGEN_OUT} @ONLY)

        # Only regenerate Doxygen when the Doxyfile or public headers change
        add_custom_command(OUTPUT ${DOXYGEN_INDEX_FILE}
                            DEPENDS ${DOXYGEN_ALL_HEADERS}
                            COMMAND ${DOXYGEN_EXECUTABLE} ${DOXYFILE_OUT}
                            WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
                            MAIN_DEPENDENCY ${DOXYFILE_OUT} ${DOXYFILE_IN}
                            COMMENT "Generating docs")
        add_custom_target(Doxygen ALL DEPENDS ${DOXYGEN_INDEX_FILE})

        #Sphinx
        find_package(Sphinx REQUIRED COMPONENTS breathe sphinx-rtd-theme)
        if (Sphinx_FOUND)
            set(SPHINX_SOURCE ${CMAKE_CURRENT_SOURCE_DIR}/Documentation)
            set(SPHINX_BUILD ${CMAKE_CURRENT_BINARY_DIR}/Documentation/sphinx)
            set(SPHINX_INDEX_FILE ${SPHINX_BUILD}/index.html)
            message(STATUS "Sphinx_BUILD_EXECUTABLE ${Sphinx_BUILD_EXECUTABLE}")


            # Only regenerate Sphinx when:
            # - Doxygen has rerun
            # - Our doc files have been updated
            # - The Sphinx config has been updated
            add_custom_command(OUTPUT ${SPHINX_INDEX_FILE}
                                COMMAND
                                    ${Sphinx_BUILD_EXECUTABLE} -b html
                                # Tell Breathe where to find the Doxygen output
                                -Dbreathe_projects.CPT=${DOXYGEN_OUTPUT_DIR}/xml
                                ${SPHINX_SOURCE} ${SPHINX_BUILD}
                                WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
                                DEPENDS
                                    # Other docs files you want to track should go here (or in some variable)
                                    ${SPHINX_SOURCE}/index.rst
                                    ${DOXYGEN_INDEX_FILE}
                                MAIN_DEPENDENCY ${SPHINX_SOURCE}/conf.py
                                COMMENT "Generating documentation with Sphinx")

            # Nice named target so we can run the job easily
            add_custom_target(Sphinx ALL DEPENDS ${SPHINX_INDEX_FILE})
        else()
            message("Sphinx needs to be installed to generate documentation")
        endif()
	else()
		message("Doxygen needs to be installed to generate documentation")
	endif()
endif()

