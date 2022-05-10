project(CppUT_lib)

set(HEADER_FILES
        Store.h
        )

set(SOURCE_FILES
        Store.cpp
        )

add_library(CppUT_lib STATIC ${SOURCE_FILES} ${HEADER_FILES})