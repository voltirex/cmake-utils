# ---------------------------------------------------------------------------- #
# ---------------------------------------------------------------------------- #
set(TOOLCHAINS_DIR ${CMAKE_SOURCE_DIR}/toolchains)
set(TOOLCHAIN_DIR  ${TOOLCHAINS_DIR}/gcc-arm-none-eabi-7-2017-q4-major-linux/gcc-arm-none-eabi-7-2017-q4-major-linux)
# ---------------------------------------------------------------------------- #

# ---------------------------------------------------------------------------- #
# ---------------------------------------------------------------------------- #
set(CMAKE_SYSTEM_NAME      Generic)
set(CMAKE_SYSTEM_PROCESSOR arm)
set(CMAKE_SYSTEM_VERSION   1)
set(CMAKE_CROSSCOMPILING   1)
# ---------------------------------------------------------------------------- #

# ---------------------------------------------------------------------------- #
# ---------------------------------------------------------------------------- #
set(CMAKE_C_COMPILER   ${TOOLCHAIN_DIR}/bin/arm-none-eabi-gcc)
set(CMAKE_CXX_COMPILER ${TOOLCHAIN_DIR}/bin/arm-none-eabi-g++)

set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)
# ---------------------------------------------------------------------------- #

# ---------------------------------------------------------------------------- #
# ---------------------------------------------------------------------------- #
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)
# ---------------------------------------------------------------------------- #
