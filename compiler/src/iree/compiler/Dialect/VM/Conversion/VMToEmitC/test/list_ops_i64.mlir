// RUN: iree-opt --split-input-file --pass-pipeline="builtin.module(vm.module(iree-vm-ordinal-allocation),vm.module(iree-convert-vm-to-emitc))" %s | FileCheck %s

vm.module @my_module {
  // CHECK-LABEL: emitc.func private @my_module_list_get_i64
  vm.func @list_get_i64(%arg0: !vm.list<i64>, %arg1: i32) -> i64 {
    // CHECK-NEXT: %0 = "emitc.variable"() <{value = #emitc.opaque<"">}> : () -> !emitc.lvalue<!emitc.opaque<"iree_vm_value_t">>
    // CHECK-NEXT: %1 = apply "&"(%0) : (!emitc.lvalue<!emitc.opaque<"iree_vm_value_t">>) -> !emitc.ptr<!emitc.opaque<"iree_vm_value_t">>
    // CHECK-NEXT: %2 = apply "*"(%arg3) : (!emitc.ptr<!emitc.opaque<"iree_vm_ref_t">>) -> !emitc.opaque<"iree_vm_ref_t">
    // CHECK-NEXT: %3 = call_opaque "iree_vm_list_deref"(%2) : (!emitc.opaque<"iree_vm_ref_t">) -> !emitc.ptr<!emitc.opaque<"iree_vm_list_t">>
    // CHECK: %{{.+}} = call_opaque "iree_vm_list_get_value_as"(%3, %arg4, %1) {args = [0 : index, 1 : index, #emitc.opaque<"IREE_VM_VALUE_TYPE_I64">, 2 : index]} : (!emitc.ptr<!emitc.opaque<"iree_vm_list_t">>, i32, !emitc.ptr<!emitc.opaque<"iree_vm_value_t">>) -> !emitc.opaque<"iree_status_t">
    %0 = vm.list.get.i64 %arg0, %arg1 : (!vm.list<i64>, i32) -> i64
    vm.return %0 : i64
  }
}

// -----

vm.module @my_module {
  // CHECK-LABEL: emitc.func private @my_module_list_set_i64
  vm.func @list_set_i64(%arg0: !vm.list<i64>, %arg1: i32, %arg2: i64) {
    // CHECK-NEXT: %0 = call_opaque "iree_vm_value_make_i64"(%arg5) : (i64) -> !emitc.opaque<"iree_vm_value_t">
    // CHECK-NEXT: %1 = "emitc.variable"() <{value = #emitc.opaque<"">}> : () -> !emitc.lvalue<!emitc.opaque<"iree_vm_value_t">>
    // CHECK-NEXT: assign %0 : !emitc.opaque<"iree_vm_value_t"> to %1 : <!emitc.opaque<"iree_vm_value_t">>
    // CHECK-NEXT: %2 = apply "&"(%1) : (!emitc.lvalue<!emitc.opaque<"iree_vm_value_t">>) -> !emitc.ptr<!emitc.opaque<"iree_vm_value_t">>
    // CHECK-NEXT: %3 = apply "*"(%arg3) : (!emitc.ptr<!emitc.opaque<"iree_vm_ref_t">>) -> !emitc.opaque<"iree_vm_ref_t">
    // CHECK-NEXT: %4 = call_opaque "iree_vm_list_deref"(%3) : (!emitc.opaque<"iree_vm_ref_t">) -> !emitc.ptr<!emitc.opaque<"iree_vm_list_t">>
    // CHECK: %{{.+}} = call_opaque "iree_vm_list_set_value"(%4, %arg4, %2) : (!emitc.ptr<!emitc.opaque<"iree_vm_list_t">>, i32, !emitc.ptr<!emitc.opaque<"iree_vm_value_t">>) -> !emitc.opaque<"iree_status_t">
    vm.list.set.i64 %arg0, %arg1, %arg2 : (!vm.list<i64>, i32, i64)
    vm.return
  }
}
