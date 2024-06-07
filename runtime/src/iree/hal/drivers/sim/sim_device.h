// Copyright 2023 The IREE Authors
//
// Licensed under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception

#ifndef IREE_AMD_AIE_DRIVER_SIM_SIM_DEVICE_H_
#define IREE_AMD_AIE_DRIVER_SIM_SIM_DEVICE_H_

#include "iree/hal/drivers/sim/api.h"
#include "iree/base/api.h"
#include "iree/hal/api.h"
#include "sim/sim_device.h"

// #ifdef __cplusplus
// extern "C" {
// #endif  // __cplusplus

// Creates a SIM device by wrapping |device| from the given |driver| with the
// specific |params|.
//
// |out_device| must be released by the caller (see iree_hal_device_release).
iree_status_t iree_hal_sim_device_create(
    iree_string_view_t identifier, const iree_hal_sim_device_params_t* params,
    sim::device device, iree_allocator_t host_allocator,
    iree_hal_device_t** out_device);

// Returns the parameters used for creating the device.
const iree_hal_sim_device_params_t* iree_hal_sim_device_params(
    const iree_hal_device_t* device);

// #ifdef __cplusplus
// }  // extern "C"
// #endif  // __cplusplus

#endif  // IREE_AMD_AIE_DRIVER_SIM_SIM_DEVICE_H_
