iree_add_all_subdirs()

if(NOT DEFINED SIM_INCLUDE_DIRS)
  set(SIM_INCLUDE_DIRS "${IREE_SOURCE_DIR}/third_party/sim/build/include")
endif()

find_library(libsc 
             NAMES sim_core
             PATHS ${IREE_SOURCE_DIR}/third_party/sim/build/lib)

message("${SIM_INCLUDE_DIRS}")
if(libsc)
    message(STATUS "Found liba: ${libsc}")
else()
    message(FATAL_ERROR "Could not find liba")
endif()

iree_cc_library(
  NAME
    sim
  HDRS
    "api.h"
  SRCS
    "api.h"
    "direct_allocator.h"
    "direct_allocator.cc"
    "direct_command_buffer.h"
    "direct_command_buffer.cc"
    "sim_buffer.h"
    "sim_buffer.cc"
    "sim_device.cc"
    "sim_driver.cc"
    "native_executable.h"
    "native_executable.cc"
    "nop_semaphore.cc"
    "nop_executable_cache.h"
    "nop_executable_cache.cc"
    "pipeline_layout.h"
    "pipeline_layout.cc"
  INCLUDES
    "${SIM_INCLUDE_DIRS}"
  DEPS
    iree::base
    iree::base::core_headers
    iree::base::internal::arena
    iree::base::internal::flatcc::building
    iree::base::internal::flatcc::parsing
    iree::hal::utils::deferred_command_buffer
    iree::hal::utils::file_transfer
    iree::hal
    iree::schemas::sim_executable_def_c_fbs
    ${libsc}
  PUBLIC
)