# ---------------------------------------------------------------------------- #
# ---------------------------------------------------------------------------- #
function(
    populate_stm32_variables
        stm32cube_fw_version
        stm32_arm
        stm32_device_line
        stm32cube_fw_subdir
        stm32xxxx_hal_dir
)

    if     (${stm32cube_fw_version} MATCHES "stm32cube-fw-l0-v110x")
        set(stm32_arm                ARM_CM0                 PARENT_SCOPE)
        set(stm32_device_line        STM32L0xx               PARENT_SCOPE)
        set(stm32cube_fw_subdir      STM32Cube_FW_L0_V1.10.0 PARENT_SCOPE)
        set(stm32xxxx_hal_dir        STM32L0xx_HAL_Driver    PARENT_SCOPE)
    elseif (${stm32cube_fw_version} MATCHES "stm32cube-fw-f1-v16x")
        set(stm32_arm                ARM_CM3                 PARENT_SCOPE)
        set(stm32_device_line        STM32F1xx               PARENT_SCOPE)
        set(stm32cube_fw_subdir      STM32Cube_FW_F1_V1.6.0  PARENT_SCOPE)
        set(stm32xxxx_hal_dir        STM32F1xx_HAL_Driver    PARENT_SCOPE)
    else()
        message(FATAL_ERROR "STM32Cube firmware not supported")
    endif()

endfunction(
    populate_stm32_variables
        stm32cube_fw_version
        stm32_arm
        stm32_device_line
        stm32cube_fw_subdir
        stm32xxxx_hal_dir
)
# ---------------------------------------------------------------------------- #

# ---------------------------------------------------------------------------- #
# ---------------------------------------------------------------------------- #
function(
    stm32cube_fw_cmsis_prepare
        stm32cube_fw_version
        stm32cube_fw_SOURCE_DIR
        cmsis_SOURCE_FILES
        cmsis_INCLUDE_FILES
        cmsis_INCLUDE_DIRECTORIES
)

    populate_stm32_variables(
        ${stm32cube_fw_version}
        stm32_arm
        stm32_device_line
        stm32cube_fw_subdir
        stm32xxxx_hal_dir
    )

    file(
        GLOB_RECURSE
            cmsis_SOURCE_FILES_list
        LIST_DIRECTORIES
            false
        ${stm32cube_fw_SOURCE_DIR}/${stm32cube_fw_subdir}/Drivers/CMSIS/*.c
    )

    foreach(cmsis_source_file ${cmsis_SOURCE_FILES_list})
        if (${cmsis_source_file} MATCHES ".*Templates.*")
            list(REMOVE_ITEM cmsis_SOURCE_FILES_list ${cmsis_source_file})
        endif (${cmsis_source_file} MATCHES ".*Templates.*")
        if (${cmsis_source_file} MATCHES ".*Examples.*")
            list(REMOVE_ITEM cmsis_SOURCE_FILES_list ${cmsis_source_file})
        endif (${cmsis_source_file} MATCHES ".*Examples.*")
    endforeach(cmsis_source_file)

    file(
        GLOB
            cmsis_INCLUDE_FILES_list
        LIST_DIRECTORIES
            false
        ${stm32cube_fw_SOURCE_DIR}/${stm32cube_fw_subdir}/Drivers/CMSIS/Include/*
        ${stm32cube_fw_SOURCE_DIR}/${stm32cube_fw_subdir}/Drivers/CMSIS/Device/ST/${stm32_device_line}/Include/*
    )

    set(
        ${cmsis_SOURCE_FILES}
            ${cmsis_SOURCE_FILES_list}
        PARENT_SCOPE
    )

    set(
        ${cmsis_INCLUDE_FILES}
            ${cmsis_INCLUDE_FILES_list}
        PARENT_SCOPE
    )

    set(
        cmsis_INCLUDE_DIRECTORIES
            ${stm32cube_fw_SOURCE_DIR}/${stm32cube_fw_subdir}/Drivers/CMSIS/Include
            ${stm32cube_fw_SOURCE_DIR}/${stm32cube_fw_subdir}/Drivers/CMSIS/Device/ST/${stm32_device_line}/Include
        PARENT_SCOPE
    )

endfunction(
    stm32cube_fw_cmsis_prepare
        stm32cube_fw_version
        stm32cube_fw_SOURCE_DIR
        cmsis_SOURCE_FILES
        cmsis_INCLUDE_FILES
        cmsis_INCLUDE_DIRECTORIES
)
# ---------------------------------------------------------------------------- #

# ---------------------------------------------------------------------------- #
# ---------------------------------------------------------------------------- #
function(
    stm32cube_fw_stm32xxxx_hal_prepare
        stm32cube_fw_version
        stm32cube_fw_SOURCE_DIR
        stm32xxxx_hal_SOURCE_FILES
        stm32xxxx_hal_INCLUDE_FILES
        stm32xxxx_hal_INCLUDE_DIRECTORIES
)

    populate_stm32_variables(
        ${stm32cube_fw_version}
        stm32_arm
        stm32_device_line
        stm32cube_fw_subdir
        stm32xxxx_hal_dir
    )

    file(
        GLOB_RECURSE
            stm32xxxx_hal_SOURCE_FILES_list
        LIST_DIRECTORIES
            false
        ${stm32cube_fw_SOURCE_DIR}/${stm32cube_fw_subdir}/Drivers/${stm32xxxx_hal_dir}/*.c
    )

    foreach(stm32xxxx_hal_source_file ${stm32xxxx_hal_SOURCE_FILES_list})
        if (${stm32xxxx_hal_source_file} MATCHES ".*template.*")
            list(REMOVE_ITEM stm32xxxx_hal_SOURCE_FILES_list ${stm32xxxx_hal_source_file})
        endif (${stm32xxxx_hal_source_file} MATCHES ".*template.*")
    endforeach(stm32xxxx_hal_source_file)

    file(
        GLOB
            stm32xxxx_hal_INCLUDE_FILES_list
        LIST_DIRECTORIES
            false
        ${stm32cube_fw_SOURCE_DIR}/${stm32cube_fw_subdir}/Drivers/${stm32xxxx_hal_dir}/Inc/*
    )

    set(
        ${stm32xxxx_hal_SOURCE_FILES}
            ${stm32xxxx_hal_SOURCE_FILES_list}
        PARENT_SCOPE
    )

    set(
        ${stm32xxxx_hal_INCLUDE_FILES}
            ${stm32xxxx_hal_INCLUDE_FILES_list}
        PARENT_SCOPE
    )

    set(
        ${stm32xxxx_hal_INCLUDE_DIRECTORIES}
            ${stm32cube_fw_SOURCE_DIR}/${stm32cube_fw_subdir}/Drivers/${stm32xxxx_hal_dir}/Inc
        PARENT_SCOPE
    )

endfunction(
    stm32cube_fw_stm32xxxx_hal_prepare
        stm32cube_fw_version
        stm32cube_fw_SOURCE_DIR
        stm32xxxx_hal_SOURCE_FILES
        stm32xxxx_hal_INCLUDE_FILES
        stm32xxxx_hal_INCLUDE_DIRECTORIES
)
# ---------------------------------------------------------------------------- #

# ---------------------------------------------------------------------------- #
# ---------------------------------------------------------------------------- #
function(
    stm32cube_fw_usb_core_and_cdc_prepare
        stm32cube_fw_version
        stm32cube_fw_SOURCE_DIR
        stm32xxxx_usb_core_and_cdc_SOURCE_FILES
        stm32xxxx_usb_core_and_cdc_INCLUDE_FILES
        stm32xxxx_usb_core_and_cdc_INCLUDE_DIRECTORIES
)

    populate_stm32_variables(
        ${stm32cube_fw_version}
        stm32_arm
        stm32_device_line
        stm32cube_fw_subdir
        stm32xxxx_hal_dir
    )

    file(
        GLOB
            stm32xxxx_usb_core_and_cdc_SOURCE_FILES_list
        LIST_DIRECTORIES
            false
        ${stm32cube_fw_SOURCE_DIR}/${stm32cube_fw_subdir}/Middlewares/ST/STM32_USB_Device_Library/Core/Src/*.c
        ${stm32cube_fw_SOURCE_DIR}/${stm32cube_fw_subdir}/Middlewares/ST/STM32_USB_Device_Library/Class/CDC/Src/*.c
    )

    foreach(stm32xxxx_usb_core_and_cdc_source_file ${stm32xxxx_usb_core_and_cdc_SOURCE_FILES_list})
        if (${stm32xxxx_usb_core_and_cdc_source_file} MATCHES ".*template.*")
            list(REMOVE_ITEM stm32xxxx_usb_core_and_cdc_SOURCE_FILES_list ${stm32xxxx_usb_core_and_cdc_source_file})
        endif (${stm32xxxx_usb_core_and_cdc_source_file} MATCHES ".*template.*")
    endforeach(stm32xxxx_usb_core_and_cdc_source_file)

    file(
        GLOB
            stm32xxxx_usb_core_and_cdc_INCLUDE_FILES_list
        LIST_DIRECTORIES
            false
        ${stm32cube_fw_SOURCE_DIR}/${stm32cube_fw_subdir}/Middlewares/ST/STM32_USB_Device_Library/Core/Inc/*
        ${stm32cube_fw_SOURCE_DIR}/${stm32cube_fw_subdir}/Middlewares/ST/STM32_USB_Device_Library/Class/CDC/Inc/*
    )

    foreach(stm32xxxx_usb_core_and_cdc_include_file ${stm32xxxx_usb_core_and_cdc_INCLUDE_FILES_list})
        if (${stm32xxxx_usb_core_and_cdc_include_file} MATCHES ".*template.*")
            list(REMOVE_ITEM stm32xxxx_usb_core_and_cdc_INCLUDE_FILES_list ${stm32xxxx_usb_core_and_cdc_include_file})
        endif (${stm32xxxx_usb_core_and_cdc_include_file} MATCHES ".*template.*")
    endforeach(stm32xxxx_usb_core_and_cdc_include_file)

    set(
        ${stm32xxxx_usb_core_and_cdc_SOURCE_FILES}
            ${stm32xxxx_usb_core_and_cdc_SOURCE_FILES_list}
        PARENT_SCOPE
    )

    set(
        ${stm32xxxx_usb_core_and_cdc_INCLUDE_FILES}
            ${stm32xxxx_usb_core_and_cdc_INCLUDE_FILES_list}
        PARENT_SCOPE
    )

    set(
        ${stm32xxxx_usb_core_and_cdc_INCLUDE_DIRECTORIES}
            ${stm32cube_fw_SOURCE_DIR}/${stm32cube_fw_subdir}/Middlewares/ST/STM32_USB_Device_Library/Core/Inc
            ${stm32cube_fw_SOURCE_DIR}/${stm32cube_fw_subdir}/Middlewares/ST/STM32_USB_Device_Library/Class/CDC/Inc
        PARENT_SCOPE
    )

endfunction(
    stm32cube_fw_usb_core_and_cdc_prepare
        stm32cube_fw_version
        stm32cube_fw_SOURCE_DIR
        stm32xxxx_usb_core_and_cdc_SOURCE_FILES
        stm32xxxx_usb_core_and_cdc_INCLUDE_FILES
        stm32xxxx_usb_core_and_cdc_INCLUDE_DIRECTORIES
)
# ---------------------------------------------------------------------------- #

# ---------------------------------------------------------------------------- #
# ---------------------------------------------------------------------------- #
function(
    stm32cube_fw_freertos_prepare
        stm32cube_fw_version
        stm32cube_fw_SOURCE_DIR
        freertos_SOURCE_FILES
        freertos_INCLUDE_FILES
        freertos_INCLUDE_DIRECTORIES
)

    populate_stm32_variables(
        ${stm32cube_fw_version}
        stm32_arm
        stm32_device_line
        stm32cube_fw_subdir
        stm32xxxx_hal_dir
    )

    string(COMPARE EQUAL ${CMAKE_C_COMPILER_ID} GNU is_gnu_compiler)

    if (is_gnu_compiler)
        file(
            GLOB_RECURSE
                freertos_SOURCE_FILES_list
            LIST_DIRECTORIES
                false
            ${stm32cube_fw_SOURCE_DIR}/${stm32cube_fw_subdir}/Middlewares/Third_Party/FreeRTOS/*.c
        )

        foreach(freertos_source_file ${freertos_SOURCE_FILES_list})
            if (${freertos_source_file} MATCHES ".*portable.*")
                list(REMOVE_ITEM freertos_SOURCE_FILES_list ${freertos_source_file})
            endif (${freertos_source_file} MATCHES ".*portable.*")
        endforeach(freertos_source_file)

        list(APPEND freertos_SOURCE_FILES_list ${stm32cube_fw_SOURCE_DIR}/${stm32cube_fw_subdir}/Middlewares/Third_Party/FreeRTOS/Source/portable/GCC/${stm32_arm}/port.c)

        file(
            GLOB
                freertos_INCLUDE_FILES_list
            LIST_DIRECTORIES
                false
            ${stm32cube_fw_SOURCE_DIR}/${stm32cube_fw_subdir}/Middlewares/Third_Party/FreeRTOS/Source/CMSIS_RTOS/*.h
            ${stm32cube_fw_SOURCE_DIR}/${stm32cube_fw_subdir}/Middlewares/Third_Party/FreeRTOS/Source/include/*
            ${stm32cube_fw_SOURCE_DIR}/${stm32cube_fw_subdir}/Middlewares/Third_Party/FreeRTOS/Source/portable/GCC/${stm32_arm}/*.h
        )

        foreach(freertos_include_file ${freertos_INCLUDE_FILES_list})
            if (${freertos_include_file} MATCHES ".*template.*")
                list(REMOVE_ITEM freertos_INCLUDE_FILES_list ${freertos_include_file})
            endif (${freertos_include_file} MATCHES ".*template.*")
        endforeach(freertos_include_file)

        set(
            ${freertos_SOURCE_FILES}
                ${freertos_SOURCE_FILES_list}
            PARENT_SCOPE
        )

        set(
            ${freertos_INCLUDE_FILES}
                ${freertos_INCLUDE_FILES_list}
            PARENT_SCOPE
        )

        set(
            freertos_INCLUDE_DIRECTORIES
                ${stm32cube_fw_SOURCE_DIR}/${stm32cube_fw_subdir}/Middlewares/Third_Party/FreeRTOS/Source/CMSIS_RTOS
                ${stm32cube_fw_SOURCE_DIR}/${stm32cube_fw_subdir}/Middlewares/Third_Party/FreeRTOS/Source/include
                ${stm32cube_fw_SOURCE_DIR}/${stm32cube_fw_subdir}/Middlewares/Third_Party/FreeRTOS/Source/portable/GCC/${stm32_arm}
            PARENT_SCOPE
        )
    else(is_gnu_compiler)
        message(FATAL_ERROR "Need port of FreeRTOS for your compiler")
    endif(is_gnu_compiler)

endfunction(
    stm32cube_fw_freertos_prepare
        stm32cube_fw_version
        stm32cube_fw_SOURCE_DIR
        freertos_SOURCE_FILES
        freertos_INCLUDE_FILES
        freertos_INCLUDE_DIRECTORIES
)
# ---------------------------------------------------------------------------- #
