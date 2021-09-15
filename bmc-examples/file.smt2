(set-info :smt-lib-version 2.6)
(set-option :print-success true)
(set-option :produce-models true)
(set-option :opt.priority lex)
; Asserts from ESMBC starts
(declare-datatypes ((struct_type_pointer_struct 0)) (((struct_type_pointer_struct (pointer_object (_ BitVec 64)) (pointer_offset (_ BitVec 64))))))
(declare-datatypes ((struct_type_addr_space_type 0)) (((struct_type_addr_space_type (start (_ BitVec 64)) (end (_ BitVec 64))))))
(declare-fun __ESBMC_ptr_obj_start_0 () (_ BitVec 64))
(declare-fun __ESBMC_ptr_obj_end_0 () (_ BitVec 64))
(declare-fun __ESBMC_ptr_obj_start_1 () (_ BitVec 64))
(declare-fun __ESBMC_ptr_obj_end_1 () (_ BitVec 64))
(declare-fun __ESBMC_ptr_addr_range_0 () struct_type_addr_space_type)
(declare-fun __ESBMC_ptr_addr_range_1 () struct_type_addr_space_type)
(declare-fun __ESBMC_addrspace_arr_2
             ()
             (Array (_ BitVec 64) struct_type_addr_space_type))
(declare-fun __ESBMC_addrspace_arr_1
             ()
             (Array (_ BitVec 64) struct_type_addr_space_type))
(declare-fun __ESBMC_addrspace_arr_3
             ()
             (Array (_ BitVec 64) struct_type_addr_space_type))
(declare-fun |0| () struct_type_pointer_struct)
(declare-fun NULL () struct_type_pointer_struct)
(declare-fun INVALID () struct_type_pointer_struct)
(declare-fun |c:@F@main::$tmp::return_value$___VERIFIER_nondet_uint$1?1!0&0#1|
             ()
             (_ BitVec 32))
(declare-fun |nondet$symex::nondet0| () (_ BitVec 32))
(declare-fun |c:code.c@137@F@main@y?1!0&0#1| () (_ BitVec 32))
(declare-fun |c:@F@main::$tmp::return_value$___VERIFIER_nondet_float$2?1!0&0#1|
             ()
             (_ FloatingPoint 8 24))
(declare-fun |nondet$symex::nondet1| () (_ FloatingPoint 8 24))
(declare-fun |c:code.c@173@F@main@prob?1!0&0#1| () (_ FloatingPoint 8 24))
(declare-fun |goto_symex::guard?0!0&0#1| () Bool)
(declare-fun |c:@F@main::$tmp::return_value$_nondet_double$3?1!0&0#1|
             ()
             (_ FloatingPoint 11 53))
(declare-fun |nondet$symex::nondet2| () (_ FloatingPoint 11 53))
(declare-fun |c:code.c@991@F@main@flip?1!0&0#1| () (_ BitVec 32))
(declare-fun |c:code.c@910@F@main@__ptid?1!0&0#2| () (_ BitVec 64))
(declare-fun |c:code.c@806@F@main@product_prob?1!0&0#2|
             ()
             (_ FloatingPoint 8 24))
(declare-fun |c:code.c@838@F@main@expected_value?1!0&0#2| () (_ BitVec 64))
(declare-fun |c:@F@main::$tmp::return_value$_nondet_double$3?2!0&0#1|
             ()
             (_ FloatingPoint 11 53))
(declare-fun |nondet$symex::nondet3| () (_ FloatingPoint 11 53))
(declare-fun |c:code.c@991@F@main@flip?2!0&0#1| () (_ BitVec 32))
(declare-fun |c:code.c@910@F@main@__ptid?1!0&0#3| () (_ BitVec 64))
(declare-fun |c:code.c@806@F@main@product_prob?1!0&0#3|
             ()
             (_ FloatingPoint 8 24))
(declare-fun |c:code.c@838@F@main@expected_value?1!0&0#3| () (_ BitVec 64))
(declare-fun |c:@F@main::$tmp::return_value$_nondet_double$3?3!0&0#1|
             ()
             (_ FloatingPoint 11 53))
(declare-fun |nondet$symex::nondet4| () (_ FloatingPoint 11 53))
(declare-fun |c:code.c@991@F@main@flip?3!0&0#1| () (_ BitVec 32))
(declare-fun |c:code.c@910@F@main@__ptid?1!0&0#4| () (_ BitVec 64))
(declare-fun |c:code.c@806@F@main@product_prob?1!0&0#4|
             ()
             (_ FloatingPoint 8 24))
(declare-fun |c:code.c@838@F@main@expected_value?1!0&0#4| () (_ BitVec 64))
(declare-fun |c:@F@main::$tmp::return_value$_nondet_double$3?4!0&0#1|
             ()
             (_ FloatingPoint 11 53))
(declare-fun |nondet$symex::nondet5| () (_ FloatingPoint 11 53))
(declare-fun |c:code.c@991@F@main@flip?4!0&0#1| () (_ BitVec 32))
(declare-fun |c:code.c@910@F@main@__ptid?1!0&0#5| () (_ BitVec 64))
(declare-fun |c:code.c@806@F@main@product_prob?1!0&0#5|
             ()
             (_ FloatingPoint 8 24))
(declare-fun |c:code.c@838@F@main@expected_value?1!0&0#5| () (_ BitVec 64))
(declare-fun |c:@F@main::$tmp::return_value$_nondet_double$3?5!0&0#1|
             ()
             (_ FloatingPoint 11 53))
(declare-fun |nondet$symex::nondet6| () (_ FloatingPoint 11 53))
(declare-fun |c:code.c@991@F@main@flip?5!0&0#1| () (_ BitVec 32))
(declare-fun |c:code.c@910@F@main@__ptid?1!0&0#6| () (_ BitVec 64))
(declare-fun |c:code.c@806@F@main@product_prob?1!0&0#6|
             ()
             (_ FloatingPoint 8 24))
(declare-fun |c:code.c@838@F@main@expected_value?1!0&0#6| () (_ BitVec 64))
(declare-fun |c:@F@main::$tmp::return_value$_nondet_double$3?6!0&0#1|
             ()
             (_ FloatingPoint 11 53))
(declare-fun |nondet$symex::nondet7| () (_ FloatingPoint 11 53))
(declare-fun |c:code.c@991@F@main@flip?6!0&0#1| () (_ BitVec 32))
(declare-fun |c:code.c@910@F@main@__ptid?1!0&0#7| () (_ BitVec 64))
(declare-fun |c:code.c@806@F@main@product_prob?1!0&0#7|
             ()
             (_ FloatingPoint 8 24))
(declare-fun |c:code.c@838@F@main@expected_value?1!0&0#7| () (_ BitVec 64))
(declare-fun |c:@F@main::$tmp::return_value$_nondet_double$3?7!0&0#1|
             ()
             (_ FloatingPoint 11 53))
(declare-fun |nondet$symex::nondet8| () (_ FloatingPoint 11 53))
(declare-fun |c:code.c@991@F@main@flip?7!0&0#1| () (_ BitVec 32))
(declare-fun |c:code.c@910@F@main@__ptid?1!0&0#8| () (_ BitVec 64))
(declare-fun |c:code.c@806@F@main@product_prob?1!0&0#8|
             ()
             (_ FloatingPoint 8 24))
(declare-fun |c:code.c@838@F@main@expected_value?1!0&0#8| () (_ BitVec 64))
(declare-fun |c:@F@main::$tmp::return_value$_nondet_double$3?8!0&0#1|
             ()
             (_ FloatingPoint 11 53))
(declare-fun |nondet$symex::nondet9| () (_ FloatingPoint 11 53))
(declare-fun |c:code.c@991@F@main@flip?8!0&0#1| () (_ BitVec 32))
(declare-fun |c:code.c@910@F@main@__ptid?1!0&0#9| () (_ BitVec 64))
(declare-fun |c:code.c@806@F@main@product_prob?1!0&0#9|
             ()
             (_ FloatingPoint 8 24))
(declare-fun |c:code.c@838@F@main@expected_value?1!0&0#9| () (_ BitVec 64))
(declare-fun |c:@F@main::$tmp::return_value$_nondet_double$3?9!0&0#1|
             ()
             (_ FloatingPoint 11 53))
(declare-fun |nondet$symex::nondet10| () (_ FloatingPoint 11 53))
(declare-fun |c:code.c@991@F@main@flip?9!0&0#1| () (_ BitVec 32))
(declare-fun |c:code.c@910@F@main@__ptid?1!0&0#10| () (_ BitVec 64))
(declare-fun |c:code.c@806@F@main@product_prob?1!0&0#10|
             ()
             (_ FloatingPoint 8 24))
(declare-fun |c:code.c@838@F@main@expected_value?1!0&0#10| () (_ BitVec 64))
(declare-fun |c:@F@main::$tmp::return_value$_nondet_double$3?10!0&0#1|
             ()
             (_ FloatingPoint 11 53))
(declare-fun |nondet$symex::nondet11| () (_ FloatingPoint 11 53))
(declare-fun |c:code.c@991@F@main@flip?10!0&0#1| () (_ BitVec 32))
(declare-fun |c:code.c@910@F@main@__ptid?1!0&0#11| () (_ BitVec 64))
(declare-fun |c:code.c@806@F@main@product_prob?1!0&0#11|
             ()
             (_ FloatingPoint 8 24))
(declare-fun |c:code.c@838@F@main@expected_value?1!0&0#11| () (_ BitVec 64))
(declare-fun |c:code.c@559@F@main@ptids?1!0&0#1|
             ()
             (Array (_ BitVec 3) (_ BitVec 64)))
(declare-fun |c:code.c@559@F@main@ptids?1!0&0#0|
             ()
             (Array (_ BitVec 3) (_ BitVec 64)))
(declare-fun |c:code.c@512@F@main@sum_prob?1!0&0#2| () (_ FloatingPoint 8 24))
(declare-fun |c:code.c@449@F@main@expected_sum?1!0&0#2| () (_ BitVec 64))
(declare-fun |goto_symex::guard?0!0&0#2| () Bool)
(declare-fun |c:@F@main::$tmp::return_value$_nondet_double$3?11!0&0#1|
             ()
             (_ FloatingPoint 11 53))
(declare-fun |nondet$symex::nondet12| () (_ FloatingPoint 11 53))
(declare-fun |c:code.c@991@F@main@flip?11!0&0#1| () (_ BitVec 32))
(declare-fun |c:code.c@910@F@main@__ptid?2!0&0#2| () (_ BitVec 64))
(declare-fun |c:code.c@806@F@main@product_prob?2!0&0#2|
             ()
             (_ FloatingPoint 8 24))
(declare-fun |c:code.c@838@F@main@expected_value?2!0&0#2| () (_ BitVec 64))
(declare-fun |c:@F@main::$tmp::return_value$_nondet_double$3?12!0&0#1|
             ()
             (_ FloatingPoint 11 53))
(declare-fun |nondet$symex::nondet13| () (_ FloatingPoint 11 53))
(declare-fun |c:code.c@991@F@main@flip?12!0&0#1| () (_ BitVec 32))
(declare-fun |c:code.c@910@F@main@__ptid?2!0&0#3| () (_ BitVec 64))
(declare-fun |c:code.c@806@F@main@product_prob?2!0&0#3|
             ()
             (_ FloatingPoint 8 24))
(declare-fun |c:code.c@838@F@main@expected_value?2!0&0#3| () (_ BitVec 64))
(declare-fun |c:@F@main::$tmp::return_value$_nondet_double$3?13!0&0#1|
             ()
             (_ FloatingPoint 11 53))
(declare-fun |nondet$symex::nondet14| () (_ FloatingPoint 11 53))
(declare-fun |c:code.c@991@F@main@flip?13!0&0#1| () (_ BitVec 32))
(declare-fun |c:code.c@910@F@main@__ptid?2!0&0#4| () (_ BitVec 64))
(declare-fun |c:code.c@806@F@main@product_prob?2!0&0#4|
             ()
             (_ FloatingPoint 8 24))
(declare-fun |c:code.c@838@F@main@expected_value?2!0&0#4| () (_ BitVec 64))
(declare-fun |c:@F@main::$tmp::return_value$_nondet_double$3?14!0&0#1|
             ()
             (_ FloatingPoint 11 53))
(declare-fun |nondet$symex::nondet15| () (_ FloatingPoint 11 53))
(declare-fun |c:code.c@991@F@main@flip?14!0&0#1| () (_ BitVec 32))
(declare-fun |c:code.c@910@F@main@__ptid?2!0&0#5| () (_ BitVec 64))
(declare-fun |c:code.c@806@F@main@product_prob?2!0&0#5|
             ()
             (_ FloatingPoint 8 24))
(declare-fun |c:code.c@838@F@main@expected_value?2!0&0#5| () (_ BitVec 64))
(declare-fun |c:@F@main::$tmp::return_value$_nondet_double$3?15!0&0#1|
             ()
             (_ FloatingPoint 11 53))
(declare-fun |nondet$symex::nondet16| () (_ FloatingPoint 11 53))
(declare-fun |c:code.c@991@F@main@flip?15!0&0#1| () (_ BitVec 32))
(declare-fun |c:code.c@910@F@main@__ptid?2!0&0#6| () (_ BitVec 64))
(declare-fun |c:code.c@806@F@main@product_prob?2!0&0#6|
             ()
             (_ FloatingPoint 8 24))
(declare-fun |c:code.c@838@F@main@expected_value?2!0&0#6| () (_ BitVec 64))
(declare-fun |c:@F@main::$tmp::return_value$_nondet_double$3?16!0&0#1|
             ()
             (_ FloatingPoint 11 53))
(declare-fun |nondet$symex::nondet17| () (_ FloatingPoint 11 53))
(declare-fun |c:code.c@991@F@main@flip?16!0&0#1| () (_ BitVec 32))
(declare-fun |c:code.c@910@F@main@__ptid?2!0&0#7| () (_ BitVec 64))
(declare-fun |c:code.c@806@F@main@product_prob?2!0&0#7|
             ()
             (_ FloatingPoint 8 24))
(declare-fun |c:code.c@838@F@main@expected_value?2!0&0#7| () (_ BitVec 64))
(declare-fun |c:@F@main::$tmp::return_value$_nondet_double$3?17!0&0#1|
             ()
             (_ FloatingPoint 11 53))
(declare-fun |nondet$symex::nondet18| () (_ FloatingPoint 11 53))
(declare-fun |c:code.c@991@F@main@flip?17!0&0#1| () (_ BitVec 32))
(declare-fun |c:code.c@910@F@main@__ptid?2!0&0#8| () (_ BitVec 64))
(declare-fun |c:code.c@806@F@main@product_prob?2!0&0#8|
             ()
             (_ FloatingPoint 8 24))
(declare-fun |c:code.c@838@F@main@expected_value?2!0&0#8| () (_ BitVec 64))
(declare-fun |c:@F@main::$tmp::return_value$_nondet_double$3?18!0&0#1|
             ()
             (_ FloatingPoint 11 53))
(declare-fun |nondet$symex::nondet19| () (_ FloatingPoint 11 53))
(declare-fun |c:code.c@991@F@main@flip?18!0&0#1| () (_ BitVec 32))
(declare-fun |c:code.c@910@F@main@__ptid?2!0&0#9| () (_ BitVec 64))
(declare-fun |c:code.c@806@F@main@product_prob?2!0&0#9|
             ()
             (_ FloatingPoint 8 24))
(declare-fun |c:code.c@838@F@main@expected_value?2!0&0#9| () (_ BitVec 64))
(declare-fun |c:@F@main::$tmp::return_value$_nondet_double$3?19!0&0#1|
             ()
             (_ FloatingPoint 11 53))
(declare-fun |nondet$symex::nondet20| () (_ FloatingPoint 11 53))
(declare-fun |c:code.c@991@F@main@flip?19!0&0#1| () (_ BitVec 32))
(declare-fun |c:code.c@910@F@main@__ptid?2!0&0#10| () (_ BitVec 64))
(declare-fun |c:code.c@806@F@main@product_prob?2!0&0#10|
             ()
             (_ FloatingPoint 8 24))
(declare-fun |c:code.c@838@F@main@expected_value?2!0&0#10| () (_ BitVec 64))
(declare-fun |c:@F@main::$tmp::return_value$_nondet_double$3?20!0&0#1|
             ()
             (_ FloatingPoint 11 53))
(declare-fun |nondet$symex::nondet21| () (_ FloatingPoint 11 53))
(declare-fun |c:code.c@991@F@main@flip?20!0&0#1| () (_ BitVec 32))
(declare-fun |c:code.c@910@F@main@__ptid?2!0&0#11| () (_ BitVec 64))
(declare-fun |c:code.c@806@F@main@product_prob?2!0&0#11|
             ()
             (_ FloatingPoint 8 24))
(declare-fun |c:code.c@838@F@main@expected_value?2!0&0#11| () (_ BitVec 64))
(declare-fun |c:code.c@559@F@main@ptids?1!0&0#2|
             ()
             (Array (_ BitVec 3) (_ BitVec 64)))
(declare-fun |c:code.c@512@F@main@sum_prob?1!0&0#3| () (_ FloatingPoint 8 24))
(declare-fun |c:code.c@449@F@main@expected_sum?1!0&0#3| () (_ BitVec 64))
(declare-fun |goto_symex::guard?0!0&0#3| () Bool)
(declare-fun |c:@F@main::$tmp::return_value$_nondet_double$3?21!0&0#1|
             ()
             (_ FloatingPoint 11 53))
(declare-fun |nondet$symex::nondet22| () (_ FloatingPoint 11 53))
(declare-fun |c:code.c@991@F@main@flip?21!0&0#1| () (_ BitVec 32))
(declare-fun |c:code.c@910@F@main@__ptid?3!0&0#2| () (_ BitVec 64))
(declare-fun |c:code.c@806@F@main@product_prob?3!0&0#2|
             ()
             (_ FloatingPoint 8 24))
(declare-fun |c:code.c@838@F@main@expected_value?3!0&0#2| () (_ BitVec 64))
(declare-fun |c:@F@main::$tmp::return_value$_nondet_double$3?22!0&0#1|
             ()
             (_ FloatingPoint 11 53))
(declare-fun |nondet$symex::nondet23| () (_ FloatingPoint 11 53))
(declare-fun |c:code.c@991@F@main@flip?22!0&0#1| () (_ BitVec 32))
(declare-fun |c:code.c@910@F@main@__ptid?3!0&0#3| () (_ BitVec 64))
(declare-fun |c:code.c@806@F@main@product_prob?3!0&0#3|
             ()
             (_ FloatingPoint 8 24))
(declare-fun |c:code.c@838@F@main@expected_value?3!0&0#3| () (_ BitVec 64))
(declare-fun |c:@F@main::$tmp::return_value$_nondet_double$3?23!0&0#1|
             ()
             (_ FloatingPoint 11 53))
(declare-fun |nondet$symex::nondet24| () (_ FloatingPoint 11 53))
(declare-fun |c:code.c@991@F@main@flip?23!0&0#1| () (_ BitVec 32))
(declare-fun |c:code.c@910@F@main@__ptid?3!0&0#4| () (_ BitVec 64))
(declare-fun |c:code.c@806@F@main@product_prob?3!0&0#4|
             ()
             (_ FloatingPoint 8 24))
(declare-fun |c:code.c@838@F@main@expected_value?3!0&0#4| () (_ BitVec 64))
(declare-fun |c:@F@main::$tmp::return_value$_nondet_double$3?24!0&0#1|
             ()
             (_ FloatingPoint 11 53))
(declare-fun |nondet$symex::nondet25| () (_ FloatingPoint 11 53))
(declare-fun |c:code.c@991@F@main@flip?24!0&0#1| () (_ BitVec 32))
(declare-fun |c:code.c@910@F@main@__ptid?3!0&0#5| () (_ BitVec 64))
(declare-fun |c:code.c@806@F@main@product_prob?3!0&0#5|
             ()
             (_ FloatingPoint 8 24))
(declare-fun |c:code.c@838@F@main@expected_value?3!0&0#5| () (_ BitVec 64))
(declare-fun |c:@F@main::$tmp::return_value$_nondet_double$3?25!0&0#1|
             ()
             (_ FloatingPoint 11 53))
(declare-fun |nondet$symex::nondet26| () (_ FloatingPoint 11 53))
(declare-fun |c:code.c@991@F@main@flip?25!0&0#1| () (_ BitVec 32))
(declare-fun |c:code.c@910@F@main@__ptid?3!0&0#6| () (_ BitVec 64))
(declare-fun |c:code.c@806@F@main@product_prob?3!0&0#6|
             ()
             (_ FloatingPoint 8 24))
(declare-fun |c:code.c@838@F@main@expected_value?3!0&0#6| () (_ BitVec 64))
(declare-fun |c:@F@main::$tmp::return_value$_nondet_double$3?26!0&0#1|
             ()
             (_ FloatingPoint 11 53))
(declare-fun |nondet$symex::nondet27| () (_ FloatingPoint 11 53))
(declare-fun |c:code.c@991@F@main@flip?26!0&0#1| () (_ BitVec 32))
(declare-fun |c:code.c@910@F@main@__ptid?3!0&0#7| () (_ BitVec 64))
(declare-fun |c:code.c@806@F@main@product_prob?3!0&0#7|
             ()
             (_ FloatingPoint 8 24))
(declare-fun |c:code.c@838@F@main@expected_value?3!0&0#7| () (_ BitVec 64))
(declare-fun |c:@F@main::$tmp::return_value$_nondet_double$3?27!0&0#1|
             ()
             (_ FloatingPoint 11 53))
(declare-fun |nondet$symex::nondet28| () (_ FloatingPoint 11 53))
(declare-fun |c:code.c@991@F@main@flip?27!0&0#1| () (_ BitVec 32))
(declare-fun |c:code.c@910@F@main@__ptid?3!0&0#8| () (_ BitVec 64))
(declare-fun |c:code.c@806@F@main@product_prob?3!0&0#8|
             ()
             (_ FloatingPoint 8 24))
(declare-fun |c:code.c@838@F@main@expected_value?3!0&0#8| () (_ BitVec 64))
(declare-fun |c:@F@main::$tmp::return_value$_nondet_double$3?28!0&0#1|
             ()
             (_ FloatingPoint 11 53))
(declare-fun |nondet$symex::nondet29| () (_ FloatingPoint 11 53))
(declare-fun |c:code.c@991@F@main@flip?28!0&0#1| () (_ BitVec 32))
(declare-fun |c:code.c@910@F@main@__ptid?3!0&0#9| () (_ BitVec 64))
(declare-fun |c:code.c@806@F@main@product_prob?3!0&0#9|
             ()
             (_ FloatingPoint 8 24))
(declare-fun |c:code.c@838@F@main@expected_value?3!0&0#9| () (_ BitVec 64))
(declare-fun |c:@F@main::$tmp::return_value$_nondet_double$3?29!0&0#1|
             ()
             (_ FloatingPoint 11 53))
(declare-fun |nondet$symex::nondet30| () (_ FloatingPoint 11 53))
(declare-fun |c:code.c@991@F@main@flip?29!0&0#1| () (_ BitVec 32))
(declare-fun |c:code.c@910@F@main@__ptid?3!0&0#10| () (_ BitVec 64))
(declare-fun |c:code.c@806@F@main@product_prob?3!0&0#10|
             ()
             (_ FloatingPoint 8 24))
(declare-fun |c:code.c@838@F@main@expected_value?3!0&0#10| () (_ BitVec 64))
(declare-fun |c:@F@main::$tmp::return_value$_nondet_double$3?30!0&0#1|
             ()
             (_ FloatingPoint 11 53))
(declare-fun |nondet$symex::nondet31| () (_ FloatingPoint 11 53))
(declare-fun |c:code.c@991@F@main@flip?30!0&0#1| () (_ BitVec 32))
(declare-fun |c:code.c@910@F@main@__ptid?3!0&0#11| () (_ BitVec 64))
(declare-fun |c:code.c@806@F@main@product_prob?3!0&0#11|
             ()
             (_ FloatingPoint 8 24))
(declare-fun |c:code.c@838@F@main@expected_value?3!0&0#11| () (_ BitVec 64))
(declare-fun |c:code.c@559@F@main@ptids?1!0&0#3|
             ()
             (Array (_ BitVec 3) (_ BitVec 64)))
(declare-fun |c:code.c@512@F@main@sum_prob?1!0&0#4| () (_ FloatingPoint 8 24))
(declare-fun |c:code.c@449@F@main@expected_sum?1!0&0#4| () (_ BitVec 64))
(declare-fun |goto_symex::guard?0!0&0#4| () Bool)
(declare-fun |c:@F@main::$tmp::return_value$_nondet_double$3?31!0&0#1|
             ()
             (_ FloatingPoint 11 53))
(declare-fun |nondet$symex::nondet32| () (_ FloatingPoint 11 53))
(declare-fun |c:code.c@991@F@main@flip?31!0&0#1| () (_ BitVec 32))
(declare-fun |c:code.c@910@F@main@__ptid?4!0&0#2| () (_ BitVec 64))
(declare-fun |c:code.c@806@F@main@product_prob?4!0&0#2|
             ()
             (_ FloatingPoint 8 24))
(declare-fun |c:code.c@838@F@main@expected_value?4!0&0#2| () (_ BitVec 64))
(declare-fun |c:@F@main::$tmp::return_value$_nondet_double$3?32!0&0#1|
             ()
             (_ FloatingPoint 11 53))
(declare-fun |nondet$symex::nondet33| () (_ FloatingPoint 11 53))
(declare-fun |c:code.c@991@F@main@flip?32!0&0#1| () (_ BitVec 32))
(declare-fun |c:code.c@910@F@main@__ptid?4!0&0#3| () (_ BitVec 64))
(declare-fun |c:code.c@806@F@main@product_prob?4!0&0#3|
             ()
             (_ FloatingPoint 8 24))
(declare-fun |c:code.c@838@F@main@expected_value?4!0&0#3| () (_ BitVec 64))
(declare-fun |c:@F@main::$tmp::return_value$_nondet_double$3?33!0&0#1|
             ()
             (_ FloatingPoint 11 53))
(declare-fun |nondet$symex::nondet34| () (_ FloatingPoint 11 53))
(declare-fun |c:code.c@991@F@main@flip?33!0&0#1| () (_ BitVec 32))
(declare-fun |c:code.c@910@F@main@__ptid?4!0&0#4| () (_ BitVec 64))
(declare-fun |c:code.c@806@F@main@product_prob?4!0&0#4|
             ()
             (_ FloatingPoint 8 24))
(declare-fun |c:code.c@838@F@main@expected_value?4!0&0#4| () (_ BitVec 64))
(declare-fun |c:@F@main::$tmp::return_value$_nondet_double$3?34!0&0#1|
             ()
             (_ FloatingPoint 11 53))
(declare-fun |nondet$symex::nondet35| () (_ FloatingPoint 11 53))
(declare-fun |c:code.c@991@F@main@flip?34!0&0#1| () (_ BitVec 32))
(declare-fun |c:code.c@910@F@main@__ptid?4!0&0#5| () (_ BitVec 64))
(declare-fun |c:code.c@806@F@main@product_prob?4!0&0#5|
             ()
             (_ FloatingPoint 8 24))
(declare-fun |c:code.c@838@F@main@expected_value?4!0&0#5| () (_ BitVec 64))
(declare-fun |c:@F@main::$tmp::return_value$_nondet_double$3?35!0&0#1|
             ()
             (_ FloatingPoint 11 53))
(declare-fun |nondet$symex::nondet36| () (_ FloatingPoint 11 53))
(declare-fun |c:code.c@991@F@main@flip?35!0&0#1| () (_ BitVec 32))
(declare-fun |c:code.c@910@F@main@__ptid?4!0&0#6| () (_ BitVec 64))
(declare-fun |c:code.c@806@F@main@product_prob?4!0&0#6|
             ()
             (_ FloatingPoint 8 24))
(declare-fun |c:code.c@838@F@main@expected_value?4!0&0#6| () (_ BitVec 64))
(declare-fun |c:@F@main::$tmp::return_value$_nondet_double$3?36!0&0#1|
             ()
             (_ FloatingPoint 11 53))
(declare-fun |nondet$symex::nondet37| () (_ FloatingPoint 11 53))
(declare-fun |c:code.c@991@F@main@flip?36!0&0#1| () (_ BitVec 32))
(declare-fun |c:code.c@910@F@main@__ptid?4!0&0#7| () (_ BitVec 64))
(declare-fun |c:code.c@806@F@main@product_prob?4!0&0#7|
             ()
             (_ FloatingPoint 8 24))
(declare-fun |c:code.c@838@F@main@expected_value?4!0&0#7| () (_ BitVec 64))
(declare-fun |c:@F@main::$tmp::return_value$_nondet_double$3?37!0&0#1|
             ()
             (_ FloatingPoint 11 53))
(declare-fun |nondet$symex::nondet38| () (_ FloatingPoint 11 53))
(declare-fun |c:code.c@991@F@main@flip?37!0&0#1| () (_ BitVec 32))
(declare-fun |c:code.c@910@F@main@__ptid?4!0&0#8| () (_ BitVec 64))
(declare-fun |c:code.c@806@F@main@product_prob?4!0&0#8|
             ()
             (_ FloatingPoint 8 24))
(declare-fun |c:code.c@838@F@main@expected_value?4!0&0#8| () (_ BitVec 64))
(declare-fun |c:@F@main::$tmp::return_value$_nondet_double$3?38!0&0#1|
             ()
             (_ FloatingPoint 11 53))
(declare-fun |nondet$symex::nondet39| () (_ FloatingPoint 11 53))
(declare-fun |c:code.c@991@F@main@flip?38!0&0#1| () (_ BitVec 32))
(declare-fun |c:code.c@910@F@main@__ptid?4!0&0#9| () (_ BitVec 64))
(declare-fun |c:code.c@806@F@main@product_prob?4!0&0#9|
             ()
             (_ FloatingPoint 8 24))
(declare-fun |c:code.c@838@F@main@expected_value?4!0&0#9| () (_ BitVec 64))
(declare-fun |c:@F@main::$tmp::return_value$_nondet_double$3?39!0&0#1|
             ()
             (_ FloatingPoint 11 53))
(declare-fun |nondet$symex::nondet40| () (_ FloatingPoint 11 53))
(declare-fun |c:code.c@991@F@main@flip?39!0&0#1| () (_ BitVec 32))
(declare-fun |c:code.c@910@F@main@__ptid?4!0&0#10| () (_ BitVec 64))
(declare-fun |c:code.c@806@F@main@product_prob?4!0&0#10|
             ()
             (_ FloatingPoint 8 24))
(declare-fun |c:code.c@838@F@main@expected_value?4!0&0#10| () (_ BitVec 64))
(declare-fun |c:@F@main::$tmp::return_value$_nondet_double$3?40!0&0#1|
             ()
             (_ FloatingPoint 11 53))
(declare-fun |nondet$symex::nondet41| () (_ FloatingPoint 11 53))
(declare-fun |c:code.c@991@F@main@flip?40!0&0#1| () (_ BitVec 32))
(declare-fun |c:code.c@910@F@main@__ptid?4!0&0#11| () (_ BitVec 64))
(declare-fun |c:code.c@806@F@main@product_prob?4!0&0#11|
             ()
             (_ FloatingPoint 8 24))
(declare-fun |c:code.c@838@F@main@expected_value?4!0&0#11| () (_ BitVec 64))
(declare-fun |c:code.c@559@F@main@ptids?1!0&0#4|
             ()
             (Array (_ BitVec 3) (_ BitVec 64)))
(declare-fun |c:code.c@512@F@main@sum_prob?1!0&0#5| () (_ FloatingPoint 8 24))
(declare-fun |c:code.c@449@F@main@expected_sum?1!0&0#5| () (_ BitVec 64))
(declare-fun |goto_symex::guard?0!0&0#5| () Bool)
(declare-fun |c:@F@main::$tmp::return_value$_nondet_double$3?41!0&0#1|
             ()
             (_ FloatingPoint 11 53))
(declare-fun |nondet$symex::nondet42| () (_ FloatingPoint 11 53))
(declare-fun |c:code.c@991@F@main@flip?41!0&0#1| () (_ BitVec 32))
(declare-fun |c:code.c@910@F@main@__ptid?5!0&0#2| () (_ BitVec 64))
(declare-fun |c:@F@main::$tmp::return_value$_nondet_double$3?42!0&0#1|
             ()
             (_ FloatingPoint 11 53))
(declare-fun |nondet$symex::nondet43| () (_ FloatingPoint 11 53))
(declare-fun |c:code.c@991@F@main@flip?42!0&0#1| () (_ BitVec 32))
(declare-fun |c:code.c@910@F@main@__ptid?5!0&0#3| () (_ BitVec 64))
(declare-fun |c:@F@main::$tmp::return_value$_nondet_double$3?43!0&0#1|
             ()
             (_ FloatingPoint 11 53))
(declare-fun |nondet$symex::nondet44| () (_ FloatingPoint 11 53))
(declare-fun |c:code.c@991@F@main@flip?43!0&0#1| () (_ BitVec 32))
(declare-fun |c:code.c@910@F@main@__ptid?5!0&0#4| () (_ BitVec 64))
(declare-fun |c:@F@main::$tmp::return_value$_nondet_double$3?44!0&0#1|
             ()
             (_ FloatingPoint 11 53))
(declare-fun |nondet$symex::nondet45| () (_ FloatingPoint 11 53))
(declare-fun |c:code.c@991@F@main@flip?44!0&0#1| () (_ BitVec 32))
(declare-fun |c:code.c@910@F@main@__ptid?5!0&0#5| () (_ BitVec 64))
(declare-fun |c:@F@main::$tmp::return_value$_nondet_double$3?45!0&0#1|
             ()
             (_ FloatingPoint 11 53))
(declare-fun |nondet$symex::nondet46| () (_ FloatingPoint 11 53))
(declare-fun |c:code.c@991@F@main@flip?45!0&0#1| () (_ BitVec 32))
(declare-fun |c:code.c@910@F@main@__ptid?5!0&0#6| () (_ BitVec 64))
(declare-fun |c:@F@main::$tmp::return_value$_nondet_double$3?46!0&0#1|
             ()
             (_ FloatingPoint 11 53))
(declare-fun |nondet$symex::nondet47| () (_ FloatingPoint 11 53))
(declare-fun |c:code.c@991@F@main@flip?46!0&0#1| () (_ BitVec 32))
(declare-fun |c:code.c@910@F@main@__ptid?5!0&0#7| () (_ BitVec 64))
(declare-fun |c:@F@main::$tmp::return_value$_nondet_double$3?47!0&0#1|
             ()
             (_ FloatingPoint 11 53))
(declare-fun |nondet$symex::nondet48| () (_ FloatingPoint 11 53))
(declare-fun |c:code.c@991@F@main@flip?47!0&0#1| () (_ BitVec 32))
(declare-fun |c:code.c@910@F@main@__ptid?5!0&0#8| () (_ BitVec 64))
(declare-fun |c:@F@main::$tmp::return_value$_nondet_double$3?48!0&0#1|
             ()
             (_ FloatingPoint 11 53))
(declare-fun |nondet$symex::nondet49| () (_ FloatingPoint 11 53))
(declare-fun |c:code.c@991@F@main@flip?48!0&0#1| () (_ BitVec 32))
(declare-fun |c:code.c@910@F@main@__ptid?5!0&0#9| () (_ BitVec 64))
(declare-fun |c:@F@main::$tmp::return_value$_nondet_double$3?49!0&0#1|
             ()
             (_ FloatingPoint 11 53))
(declare-fun |nondet$symex::nondet50| () (_ FloatingPoint 11 53))
(declare-fun |c:code.c@991@F@main@flip?49!0&0#1| () (_ BitVec 32))
(declare-fun |c:code.c@910@F@main@__ptid?5!0&0#10| () (_ BitVec 64))
(declare-fun |c:@F@main::$tmp::return_value$_nondet_double$3?50!0&0#1|
             ()
             (_ FloatingPoint 11 53))
(declare-fun |nondet$symex::nondet51| () (_ FloatingPoint 11 53))
(declare-fun |c:code.c@991@F@main@flip?50!0&0#1| () (_ BitVec 32))
(declare-fun |c:code.c@910@F@main@__ptid?5!0&0#11| () (_ BitVec 64))
(declare-fun |c:code.c@559@F@main@ptids?1!0&0#5|
             ()
             (Array (_ BitVec 3) (_ BitVec 64)))
(declare-fun |c:code.c@449@F@main@expected_sum?1!0&0#7| () (_ BitVec 64))
(declare-fun |c:code.c@449@F@main@expected_sum?1!0&0#8| () (_ BitVec 64))
(declare-fun |c:code.c@449@F@main@expected_sum?1!0&0#9| () (_ BitVec 64))
(declare-fun |c:code.c@449@F@main@expected_sum?1!0&0#10| () (_ BitVec 64))
(declare-fun |c:code.c@449@F@main@expected_sum?1!0&0#11| () (_ BitVec 64))
(declare-fun |goto_symex::guard?0!0&0#6| () Bool)
(declare-fun |execution_statet::\\guard_exec?0!0| () Bool)
(assert (= __ESBMC_ptr_obj_start_0 #x0000000000000000))
(assert (= __ESBMC_ptr_obj_end_0 #x0000000000000000))
(assert (= __ESBMC_ptr_obj_start_1 #x0000000000000001))
(assert (= __ESBMC_ptr_obj_end_1 #xffffffffffffffff))
(assert (= __ESBMC_ptr_addr_range_0
   (struct_type_addr_space_type __ESBMC_ptr_obj_start_0 __ESBMC_ptr_obj_end_0)))
(assert (= __ESBMC_ptr_addr_range_1
   (struct_type_addr_space_type __ESBMC_ptr_obj_start_1 __ESBMC_ptr_obj_end_1)))
(assert (= (store __ESBMC_addrspace_arr_1
          #x0000000000000000
          (struct_type_addr_space_type
            __ESBMC_ptr_obj_start_0
            __ESBMC_ptr_obj_end_0))
   __ESBMC_addrspace_arr_2))
(assert (= (store __ESBMC_addrspace_arr_2
          #x0000000000000001
          (struct_type_addr_space_type
            __ESBMC_ptr_obj_start_1
            __ESBMC_ptr_obj_end_1))
   __ESBMC_addrspace_arr_3))
(assert (= |0| (struct_type_pointer_struct #x0000000000000000 #x0000000000000000)))
(assert (= NULL (struct_type_pointer_struct #x0000000000000000 #x0000000000000000)))
(assert (= INVALID (struct_type_pointer_struct #x0000000000000001 #x0000000000000000)))
(assert (= |nondet$symex::nondet0|
   |c:@F@main::$tmp::return_value$___VERIFIER_nondet_uint$1?1!0&0#1|))
(assert (= |c:@F@main::$tmp::return_value$___VERIFIER_nondet_uint$1?1!0&0#1|
   |c:code.c@137@F@main@y?1!0&0#1|))
(assert (= |nondet$symex::nondet1|
   |c:@F@main::$tmp::return_value$___VERIFIER_nondet_float$2?1!0&0#1|))
(assert (= |c:@F@main::$tmp::return_value$___VERIFIER_nondet_float$2?1!0&0#1|
   |c:code.c@173@F@main@prob?1!0&0#1|))
(assert (= (fp.leq (fp #b0 #x00 #b00000000000000000000000)
           (fp.mul roundNearestTiesToEven
                   (fp #b0 #x7e #b10011001100110011001101)
                   |c:code.c@173@F@main@prob?1!0&0#1|))
   |goto_symex::guard?0!0&0#1|))
(assert (= |nondet$symex::nondet2|
   |c:@F@main::$tmp::return_value$_nondet_double$3?1!0&0#1|))
(assert (let ((a!1 (ite (fp.geq (fp.div roundNearestTiesToEven
                                |c:@F@main::$tmp::return_value$_nondet_double$3?1!0&0#1|
                                (fp #b0 #b10000011101 #xfffffffc00000))
                        ((_ to_fp 11 53)
                          roundNearestTiesToEven
                          |c:code.c@173@F@main@prob?1!0&0#1|))
                #x00000001
                #x00000000)))
  (= a!1 |c:code.c@991@F@main@flip?1!0&0#1|)))
(assert (= ((_ sign_extend 32)
     (ite (= |c:code.c@991@F@main@flip?1!0&0#1| #x00000001)
          #x00000000
          #x00000000))
   |c:code.c@910@F@main@__ptid?1!0&0#2|))
(assert (= (fp.mul roundNearestTiesToEven
           (fp #b0 #x7f #b00000000000000000000000)
           (ite (= |c:code.c@991@F@main@flip?1!0&0#1| #x00000001)
                |c:code.c@173@F@main@prob?1!0&0#1|
                (fp #b0 #x7f #b00000000000000000000000)))
   |c:code.c@806@F@main@product_prob?1!0&0#2|))
(assert (= (ite (= |c:code.c@991@F@main@flip?1!0&0#1| #x00000001)
        ((_ sign_extend 32) |c:code.c@137@F@main@y?1!0&0#1|)
        #x0000000000000000)
   |c:code.c@838@F@main@expected_value?1!0&0#2|))
(assert (= |nondet$symex::nondet3|
   |c:@F@main::$tmp::return_value$_nondet_double$3?2!0&0#1|))
(assert (let ((a!1 (ite (fp.geq (fp.div roundNearestTiesToEven
                                |c:@F@main::$tmp::return_value$_nondet_double$3?2!0&0#1|
                                (fp #b0 #b10000011101 #xfffffffc00000))
                        ((_ to_fp 11 53)
                          roundNearestTiesToEven
                          |c:code.c@173@F@main@prob?1!0&0#1|))
                #x00000001
                #x00000000)))
  (= a!1 |c:code.c@991@F@main@flip?2!0&0#1|)))
(assert (let ((a!1 (bvadd |c:code.c@910@F@main@__ptid?1!0&0#2|
                  ((_ sign_extend 32)
                    (ite (= |c:code.c@991@F@main@flip?2!0&0#1| #x00000001)
                         #x00000000
                         #x00000000)))))
  (= a!1 |c:code.c@910@F@main@__ptid?1!0&0#3|)))
(assert (= (fp.mul roundNearestTiesToEven
           |c:code.c@806@F@main@product_prob?1!0&0#2|
           (ite (= |c:code.c@991@F@main@flip?2!0&0#1| #x00000001)
                |c:code.c@173@F@main@prob?1!0&0#1|
                (fp #b0 #x7f #b00000000000000000000000)))
   |c:code.c@806@F@main@product_prob?1!0&0#3|))
(assert (= (bvadd |c:code.c@838@F@main@expected_value?1!0&0#2|
          (ite (= |c:code.c@991@F@main@flip?2!0&0#1| #x00000001)
               ((_ sign_extend 32) |c:code.c@137@F@main@y?1!0&0#1|)
               #x0000000000000000))
   |c:code.c@838@F@main@expected_value?1!0&0#3|))
(assert (= |nondet$symex::nondet4|
   |c:@F@main::$tmp::return_value$_nondet_double$3?3!0&0#1|))
(assert (let ((a!1 (ite (fp.geq (fp.div roundNearestTiesToEven
                                |c:@F@main::$tmp::return_value$_nondet_double$3?3!0&0#1|
                                (fp #b0 #b10000011101 #xfffffffc00000))
                        ((_ to_fp 11 53)
                          roundNearestTiesToEven
                          |c:code.c@173@F@main@prob?1!0&0#1|))
                #x00000001
                #x00000000)))
  (= a!1 |c:code.c@991@F@main@flip?3!0&0#1|)))
(assert (let ((a!1 (bvadd |c:code.c@910@F@main@__ptid?1!0&0#3|
                  ((_ sign_extend 32)
                    (ite (= |c:code.c@991@F@main@flip?3!0&0#1| #x00000001)
                         #x00000000
                         #x00000000)))))
  (= a!1 |c:code.c@910@F@main@__ptid?1!0&0#4|)))
(assert (= (fp.mul roundNearestTiesToEven
           |c:code.c@806@F@main@product_prob?1!0&0#3|
           (ite (= |c:code.c@991@F@main@flip?3!0&0#1| #x00000001)
                |c:code.c@173@F@main@prob?1!0&0#1|
                (fp #b0 #x7f #b00000000000000000000000)))
   |c:code.c@806@F@main@product_prob?1!0&0#4|))
(assert (= (bvadd |c:code.c@838@F@main@expected_value?1!0&0#3|
          (ite (= |c:code.c@991@F@main@flip?3!0&0#1| #x00000001)
               ((_ sign_extend 32) |c:code.c@137@F@main@y?1!0&0#1|)
               #x0000000000000000))
   |c:code.c@838@F@main@expected_value?1!0&0#4|))
(assert (= |nondet$symex::nondet5|
   |c:@F@main::$tmp::return_value$_nondet_double$3?4!0&0#1|))
(assert (let ((a!1 (ite (fp.geq (fp.div roundNearestTiesToEven
                                |c:@F@main::$tmp::return_value$_nondet_double$3?4!0&0#1|
                                (fp #b0 #b10000011101 #xfffffffc00000))
                        ((_ to_fp 11 53)
                          roundNearestTiesToEven
                          |c:code.c@173@F@main@prob?1!0&0#1|))
                #x00000001
                #x00000000)))
  (= a!1 |c:code.c@991@F@main@flip?4!0&0#1|)))
(assert (let ((a!1 (bvadd |c:code.c@910@F@main@__ptid?1!0&0#4|
                  ((_ sign_extend 32)
                    (ite (= |c:code.c@991@F@main@flip?4!0&0#1| #x00000001)
                         #x00000000
                         #x00000000)))))
  (= a!1 |c:code.c@910@F@main@__ptid?1!0&0#5|)))
(assert (= (fp.mul roundNearestTiesToEven
           |c:code.c@806@F@main@product_prob?1!0&0#4|
           (ite (= |c:code.c@991@F@main@flip?4!0&0#1| #x00000001)
                |c:code.c@173@F@main@prob?1!0&0#1|
                (fp #b0 #x7f #b00000000000000000000000)))
   |c:code.c@806@F@main@product_prob?1!0&0#5|))
(assert (= (bvadd |c:code.c@838@F@main@expected_value?1!0&0#4|
          (ite (= |c:code.c@991@F@main@flip?4!0&0#1| #x00000001)
               ((_ sign_extend 32) |c:code.c@137@F@main@y?1!0&0#1|)
               #x0000000000000000))
   |c:code.c@838@F@main@expected_value?1!0&0#5|))
(assert (= |nondet$symex::nondet6|
   |c:@F@main::$tmp::return_value$_nondet_double$3?5!0&0#1|))
(assert (let ((a!1 (ite (fp.geq (fp.div roundNearestTiesToEven
                                |c:@F@main::$tmp::return_value$_nondet_double$3?5!0&0#1|
                                (fp #b0 #b10000011101 #xfffffffc00000))
                        ((_ to_fp 11 53)
                          roundNearestTiesToEven
                          |c:code.c@173@F@main@prob?1!0&0#1|))
                #x00000001
                #x00000000)))
  (= a!1 |c:code.c@991@F@main@flip?5!0&0#1|)))
(assert (let ((a!1 (bvadd |c:code.c@910@F@main@__ptid?1!0&0#5|
                  ((_ sign_extend 32)
                    (ite (= |c:code.c@991@F@main@flip?5!0&0#1| #x00000001)
                         #x00000000
                         #x00000000)))))
  (= a!1 |c:code.c@910@F@main@__ptid?1!0&0#6|)))
(assert (= (fp.mul roundNearestTiesToEven
           |c:code.c@806@F@main@product_prob?1!0&0#5|
           (ite (= |c:code.c@991@F@main@flip?5!0&0#1| #x00000001)
                |c:code.c@173@F@main@prob?1!0&0#1|
                (fp #b0 #x7f #b00000000000000000000000)))
   |c:code.c@806@F@main@product_prob?1!0&0#6|))
(assert (= (bvadd |c:code.c@838@F@main@expected_value?1!0&0#5|
          (ite (= |c:code.c@991@F@main@flip?5!0&0#1| #x00000001)
               ((_ sign_extend 32) |c:code.c@137@F@main@y?1!0&0#1|)
               #x0000000000000000))
   |c:code.c@838@F@main@expected_value?1!0&0#6|))
(assert (= |nondet$symex::nondet7|
   |c:@F@main::$tmp::return_value$_nondet_double$3?6!0&0#1|))
(assert (let ((a!1 (ite (fp.geq (fp.div roundNearestTiesToEven
                                |c:@F@main::$tmp::return_value$_nondet_double$3?6!0&0#1|
                                (fp #b0 #b10000011101 #xfffffffc00000))
                        ((_ to_fp 11 53)
                          roundNearestTiesToEven
                          |c:code.c@173@F@main@prob?1!0&0#1|))
                #x00000001
                #x00000000)))
  (= a!1 |c:code.c@991@F@main@flip?6!0&0#1|)))
(assert (let ((a!1 (bvadd |c:code.c@910@F@main@__ptid?1!0&0#6|
                  ((_ sign_extend 32)
                    (ite (= |c:code.c@991@F@main@flip?6!0&0#1| #x00000001)
                         #x00000000
                         #x00000000)))))
  (= a!1 |c:code.c@910@F@main@__ptid?1!0&0#7|)))
(assert (= (fp.mul roundNearestTiesToEven
           |c:code.c@806@F@main@product_prob?1!0&0#6|
           (ite (= |c:code.c@991@F@main@flip?6!0&0#1| #x00000001)
                |c:code.c@173@F@main@prob?1!0&0#1|
                (fp #b0 #x7f #b00000000000000000000000)))
   |c:code.c@806@F@main@product_prob?1!0&0#7|))
(assert (= (bvadd |c:code.c@838@F@main@expected_value?1!0&0#6|
          (ite (= |c:code.c@991@F@main@flip?6!0&0#1| #x00000001)
               ((_ sign_extend 32) |c:code.c@137@F@main@y?1!0&0#1|)
               #x0000000000000000))
   |c:code.c@838@F@main@expected_value?1!0&0#7|))
(assert (= |nondet$symex::nondet8|
   |c:@F@main::$tmp::return_value$_nondet_double$3?7!0&0#1|))
(assert (let ((a!1 (ite (fp.geq (fp.div roundNearestTiesToEven
                                |c:@F@main::$tmp::return_value$_nondet_double$3?7!0&0#1|
                                (fp #b0 #b10000011101 #xfffffffc00000))
                        ((_ to_fp 11 53)
                          roundNearestTiesToEven
                          |c:code.c@173@F@main@prob?1!0&0#1|))
                #x00000001
                #x00000000)))
  (= a!1 |c:code.c@991@F@main@flip?7!0&0#1|)))
(assert (let ((a!1 (bvadd |c:code.c@910@F@main@__ptid?1!0&0#7|
                  ((_ sign_extend 32)
                    (ite (= |c:code.c@991@F@main@flip?7!0&0#1| #x00000001)
                         #x00000000
                         #x00000000)))))
  (= a!1 |c:code.c@910@F@main@__ptid?1!0&0#8|)))
(assert (= (fp.mul roundNearestTiesToEven
           |c:code.c@806@F@main@product_prob?1!0&0#7|
           (ite (= |c:code.c@991@F@main@flip?7!0&0#1| #x00000001)
                |c:code.c@173@F@main@prob?1!0&0#1|
                (fp #b0 #x7f #b00000000000000000000000)))
   |c:code.c@806@F@main@product_prob?1!0&0#8|))
(assert (= (bvadd |c:code.c@838@F@main@expected_value?1!0&0#7|
          (ite (= |c:code.c@991@F@main@flip?7!0&0#1| #x00000001)
               ((_ sign_extend 32) |c:code.c@137@F@main@y?1!0&0#1|)
               #x0000000000000000))
   |c:code.c@838@F@main@expected_value?1!0&0#8|))
(assert (= |nondet$symex::nondet9|
   |c:@F@main::$tmp::return_value$_nondet_double$3?8!0&0#1|))
(assert (let ((a!1 (ite (fp.geq (fp.div roundNearestTiesToEven
                                |c:@F@main::$tmp::return_value$_nondet_double$3?8!0&0#1|
                                (fp #b0 #b10000011101 #xfffffffc00000))
                        ((_ to_fp 11 53)
                          roundNearestTiesToEven
                          |c:code.c@173@F@main@prob?1!0&0#1|))
                #x00000001
                #x00000000)))
  (= a!1 |c:code.c@991@F@main@flip?8!0&0#1|)))
(assert (let ((a!1 (bvadd |c:code.c@910@F@main@__ptid?1!0&0#8|
                  ((_ sign_extend 32)
                    (ite (= |c:code.c@991@F@main@flip?8!0&0#1| #x00000001)
                         #x00000000
                         #x00000000)))))
  (= a!1 |c:code.c@910@F@main@__ptid?1!0&0#9|)))
(assert (= (fp.mul roundNearestTiesToEven
           |c:code.c@806@F@main@product_prob?1!0&0#8|
           (ite (= |c:code.c@991@F@main@flip?8!0&0#1| #x00000001)
                |c:code.c@173@F@main@prob?1!0&0#1|
                (fp #b0 #x7f #b00000000000000000000000)))
   |c:code.c@806@F@main@product_prob?1!0&0#9|))
(assert (= (bvadd |c:code.c@838@F@main@expected_value?1!0&0#8|
          (ite (= |c:code.c@991@F@main@flip?8!0&0#1| #x00000001)
               ((_ sign_extend 32) |c:code.c@137@F@main@y?1!0&0#1|)
               #x0000000000000000))
   |c:code.c@838@F@main@expected_value?1!0&0#9|))
(assert (= |nondet$symex::nondet10|
   |c:@F@main::$tmp::return_value$_nondet_double$3?9!0&0#1|))
(assert (let ((a!1 (ite (fp.geq (fp.div roundNearestTiesToEven
                                |c:@F@main::$tmp::return_value$_nondet_double$3?9!0&0#1|
                                (fp #b0 #b10000011101 #xfffffffc00000))
                        ((_ to_fp 11 53)
                          roundNearestTiesToEven
                          |c:code.c@173@F@main@prob?1!0&0#1|))
                #x00000001
                #x00000000)))
  (= a!1 |c:code.c@991@F@main@flip?9!0&0#1|)))
(assert (let ((a!1 (bvadd |c:code.c@910@F@main@__ptid?1!0&0#9|
                  ((_ sign_extend 32)
                    (ite (= |c:code.c@991@F@main@flip?9!0&0#1| #x00000001)
                         #x00000000
                         #x00000000)))))
  (= a!1 |c:code.c@910@F@main@__ptid?1!0&0#10|)))
(assert (= (fp.mul roundNearestTiesToEven
           |c:code.c@806@F@main@product_prob?1!0&0#9|
           (ite (= |c:code.c@991@F@main@flip?9!0&0#1| #x00000001)
                |c:code.c@173@F@main@prob?1!0&0#1|
                (fp #b0 #x7f #b00000000000000000000000)))
   |c:code.c@806@F@main@product_prob?1!0&0#10|))
(assert (= (bvadd |c:code.c@838@F@main@expected_value?1!0&0#9|
          (ite (= |c:code.c@991@F@main@flip?9!0&0#1| #x00000001)
               ((_ sign_extend 32) |c:code.c@137@F@main@y?1!0&0#1|)
               #x0000000000000000))
   |c:code.c@838@F@main@expected_value?1!0&0#10|))
(assert (= |nondet$symex::nondet11|
   |c:@F@main::$tmp::return_value$_nondet_double$3?10!0&0#1|))
(assert (let ((a!1 (ite (fp.geq (fp.div roundNearestTiesToEven
                                |c:@F@main::$tmp::return_value$_nondet_double$3?10!0&0#1|
                                (fp #b0 #b10000011101 #xfffffffc00000))
                        ((_ to_fp 11 53)
                          roundNearestTiesToEven
                          |c:code.c@173@F@main@prob?1!0&0#1|))
                #x00000001
                #x00000000)))
  (= a!1 |c:code.c@991@F@main@flip?10!0&0#1|)))
(assert (let ((a!1 (bvadd |c:code.c@910@F@main@__ptid?1!0&0#10|
                  ((_ sign_extend 32)
                    (ite (= |c:code.c@991@F@main@flip?10!0&0#1| #x00000001)
                         #x00000000
                         #x00000000)))))
  (= a!1 |c:code.c@910@F@main@__ptid?1!0&0#11|)))
(assert (= (fp.mul roundNearestTiesToEven
           |c:code.c@806@F@main@product_prob?1!0&0#10|
           (ite (= |c:code.c@991@F@main@flip?10!0&0#1| #x00000001)
                |c:code.c@173@F@main@prob?1!0&0#1|
                (fp #b0 #x7f #b00000000000000000000000)))
   |c:code.c@806@F@main@product_prob?1!0&0#11|))
(assert (= (bvadd |c:code.c@838@F@main@expected_value?1!0&0#10|
          (ite (= |c:code.c@991@F@main@flip?10!0&0#1| #x00000001)
               ((_ sign_extend 32) |c:code.c@137@F@main@y?1!0&0#1|)
               #x0000000000000000))
   |c:code.c@838@F@main@expected_value?1!0&0#11|))
(assert (= (store |c:code.c@559@F@main@ptids?1!0&0#0|
          ((_ extract 2 0) #x0000000000000000)
          |c:code.c@910@F@main@__ptid?1!0&0#11|)
   |c:code.c@559@F@main@ptids?1!0&0#1|))
(assert (= (fp.add roundNearestTiesToEven
           (fp #b0 #x00 #b00000000000000000000000)
           |c:code.c@806@F@main@product_prob?1!0&0#11|)
   |c:code.c@512@F@main@sum_prob?1!0&0#2|))
(assert (= |c:code.c@838@F@main@expected_value?1!0&0#11|
   |c:code.c@449@F@main@expected_sum?1!0&0#2|))
(assert (= (fp.leq |c:code.c@512@F@main@sum_prob?1!0&0#2|
           (fp.mul roundNearestTiesToEven
                   (fp #b0 #x7e #b10011001100110011001101)
                   |c:code.c@173@F@main@prob?1!0&0#1|))
   |goto_symex::guard?0!0&0#2|))
(assert (= |nondet$symex::nondet12|
   |c:@F@main::$tmp::return_value$_nondet_double$3?11!0&0#1|))
(assert (let ((a!1 (ite (fp.geq (fp.div roundNearestTiesToEven
                                |c:@F@main::$tmp::return_value$_nondet_double$3?11!0&0#1|
                                (fp #b0 #b10000011101 #xfffffffc00000))
                        ((_ to_fp 11 53)
                          roundNearestTiesToEven
                          |c:code.c@173@F@main@prob?1!0&0#1|))
                #x00000001
                #x00000000)))
  (= a!1 |c:code.c@991@F@main@flip?11!0&0#1|)))
(assert (= ((_ sign_extend 32)
     (ite (= |c:code.c@991@F@main@flip?11!0&0#1| #x00000001)
          #x00000000
          #x00000000))
   |c:code.c@910@F@main@__ptid?2!0&0#2|))
(assert (= (fp.mul roundNearestTiesToEven
           (fp #b0 #x7f #b00000000000000000000000)
           (ite (= |c:code.c@991@F@main@flip?11!0&0#1| #x00000001)
                |c:code.c@173@F@main@prob?1!0&0#1|
                (fp #b0 #x7f #b00000000000000000000000)))
   |c:code.c@806@F@main@product_prob?2!0&0#2|))
(assert (= (ite (= |c:code.c@991@F@main@flip?11!0&0#1| #x00000001)
        ((_ sign_extend 32) |c:code.c@137@F@main@y?1!0&0#1|)
        #x0000000000000000)
   |c:code.c@838@F@main@expected_value?2!0&0#2|))
(assert (= |nondet$symex::nondet13|
   |c:@F@main::$tmp::return_value$_nondet_double$3?12!0&0#1|))
(assert (let ((a!1 (ite (fp.geq (fp.div roundNearestTiesToEven
                                |c:@F@main::$tmp::return_value$_nondet_double$3?12!0&0#1|
                                (fp #b0 #b10000011101 #xfffffffc00000))
                        ((_ to_fp 11 53)
                          roundNearestTiesToEven
                          |c:code.c@173@F@main@prob?1!0&0#1|))
                #x00000001
                #x00000000)))
  (= a!1 |c:code.c@991@F@main@flip?12!0&0#1|)))
(assert (let ((a!1 (bvadd |c:code.c@910@F@main@__ptid?2!0&0#2|
                  ((_ sign_extend 32)
                    (ite (= |c:code.c@991@F@main@flip?12!0&0#1| #x00000001)
                         #x00000000
                         #x00000000)))))
  (= a!1 |c:code.c@910@F@main@__ptid?2!0&0#3|)))
(assert (= (fp.mul roundNearestTiesToEven
           |c:code.c@806@F@main@product_prob?2!0&0#2|
           (ite (= |c:code.c@991@F@main@flip?12!0&0#1| #x00000001)
                |c:code.c@173@F@main@prob?1!0&0#1|
                (fp #b0 #x7f #b00000000000000000000000)))
   |c:code.c@806@F@main@product_prob?2!0&0#3|))
(assert (= (bvadd |c:code.c@838@F@main@expected_value?2!0&0#2|
          (ite (= |c:code.c@991@F@main@flip?12!0&0#1| #x00000001)
               ((_ sign_extend 32) |c:code.c@137@F@main@y?1!0&0#1|)
               #x0000000000000000))
   |c:code.c@838@F@main@expected_value?2!0&0#3|))
(assert (= |nondet$symex::nondet14|
   |c:@F@main::$tmp::return_value$_nondet_double$3?13!0&0#1|))
(assert (let ((a!1 (ite (fp.geq (fp.div roundNearestTiesToEven
                                |c:@F@main::$tmp::return_value$_nondet_double$3?13!0&0#1|
                                (fp #b0 #b10000011101 #xfffffffc00000))
                        ((_ to_fp 11 53)
                          roundNearestTiesToEven
                          |c:code.c@173@F@main@prob?1!0&0#1|))
                #x00000001
                #x00000000)))
  (= a!1 |c:code.c@991@F@main@flip?13!0&0#1|)))
(assert (let ((a!1 (bvadd |c:code.c@910@F@main@__ptid?2!0&0#3|
                  ((_ sign_extend 32)
                    (ite (= |c:code.c@991@F@main@flip?13!0&0#1| #x00000001)
                         #x00000000
                         #x00000000)))))
  (= a!1 |c:code.c@910@F@main@__ptid?2!0&0#4|)))
(assert (= (fp.mul roundNearestTiesToEven
           |c:code.c@806@F@main@product_prob?2!0&0#3|
           (ite (= |c:code.c@991@F@main@flip?13!0&0#1| #x00000001)
                |c:code.c@173@F@main@prob?1!0&0#1|
                (fp #b0 #x7f #b00000000000000000000000)))
   |c:code.c@806@F@main@product_prob?2!0&0#4|))
(assert (= (bvadd |c:code.c@838@F@main@expected_value?2!0&0#3|
          (ite (= |c:code.c@991@F@main@flip?13!0&0#1| #x00000001)
               ((_ sign_extend 32) |c:code.c@137@F@main@y?1!0&0#1|)
               #x0000000000000000))
   |c:code.c@838@F@main@expected_value?2!0&0#4|))
(assert (= |nondet$symex::nondet15|
   |c:@F@main::$tmp::return_value$_nondet_double$3?14!0&0#1|))
(assert (let ((a!1 (ite (fp.geq (fp.div roundNearestTiesToEven
                                |c:@F@main::$tmp::return_value$_nondet_double$3?14!0&0#1|
                                (fp #b0 #b10000011101 #xfffffffc00000))
                        ((_ to_fp 11 53)
                          roundNearestTiesToEven
                          |c:code.c@173@F@main@prob?1!0&0#1|))
                #x00000001
                #x00000000)))
  (= a!1 |c:code.c@991@F@main@flip?14!0&0#1|)))
(assert (let ((a!1 (bvadd |c:code.c@910@F@main@__ptid?2!0&0#4|
                  ((_ sign_extend 32)
                    (ite (= |c:code.c@991@F@main@flip?14!0&0#1| #x00000001)
                         #x00000000
                         #x00000000)))))
  (= a!1 |c:code.c@910@F@main@__ptid?2!0&0#5|)))
(assert (= (fp.mul roundNearestTiesToEven
           |c:code.c@806@F@main@product_prob?2!0&0#4|
           (ite (= |c:code.c@991@F@main@flip?14!0&0#1| #x00000001)
                |c:code.c@173@F@main@prob?1!0&0#1|
                (fp #b0 #x7f #b00000000000000000000000)))
   |c:code.c@806@F@main@product_prob?2!0&0#5|))
(assert (= (bvadd |c:code.c@838@F@main@expected_value?2!0&0#4|
          (ite (= |c:code.c@991@F@main@flip?14!0&0#1| #x00000001)
               ((_ sign_extend 32) |c:code.c@137@F@main@y?1!0&0#1|)
               #x0000000000000000))
   |c:code.c@838@F@main@expected_value?2!0&0#5|))
(assert (= |nondet$symex::nondet16|
   |c:@F@main::$tmp::return_value$_nondet_double$3?15!0&0#1|))
(assert (let ((a!1 (ite (fp.geq (fp.div roundNearestTiesToEven
                                |c:@F@main::$tmp::return_value$_nondet_double$3?15!0&0#1|
                                (fp #b0 #b10000011101 #xfffffffc00000))
                        ((_ to_fp 11 53)
                          roundNearestTiesToEven
                          |c:code.c@173@F@main@prob?1!0&0#1|))
                #x00000001
                #x00000000)))
  (= a!1 |c:code.c@991@F@main@flip?15!0&0#1|)))
(assert (let ((a!1 (bvadd |c:code.c@910@F@main@__ptid?2!0&0#5|
                  ((_ sign_extend 32)
                    (ite (= |c:code.c@991@F@main@flip?15!0&0#1| #x00000001)
                         #x00000000
                         #x00000000)))))
  (= a!1 |c:code.c@910@F@main@__ptid?2!0&0#6|)))
(assert (= (fp.mul roundNearestTiesToEven
           |c:code.c@806@F@main@product_prob?2!0&0#5|
           (ite (= |c:code.c@991@F@main@flip?15!0&0#1| #x00000001)
                |c:code.c@173@F@main@prob?1!0&0#1|
                (fp #b0 #x7f #b00000000000000000000000)))
   |c:code.c@806@F@main@product_prob?2!0&0#6|))
(assert (= (bvadd |c:code.c@838@F@main@expected_value?2!0&0#5|
          (ite (= |c:code.c@991@F@main@flip?15!0&0#1| #x00000001)
               ((_ sign_extend 32) |c:code.c@137@F@main@y?1!0&0#1|)
               #x0000000000000000))
   |c:code.c@838@F@main@expected_value?2!0&0#6|))
(assert (= |nondet$symex::nondet17|
   |c:@F@main::$tmp::return_value$_nondet_double$3?16!0&0#1|))
(assert (let ((a!1 (ite (fp.geq (fp.div roundNearestTiesToEven
                                |c:@F@main::$tmp::return_value$_nondet_double$3?16!0&0#1|
                                (fp #b0 #b10000011101 #xfffffffc00000))
                        ((_ to_fp 11 53)
                          roundNearestTiesToEven
                          |c:code.c@173@F@main@prob?1!0&0#1|))
                #x00000001
                #x00000000)))
  (= a!1 |c:code.c@991@F@main@flip?16!0&0#1|)))
(assert (let ((a!1 (bvadd |c:code.c@910@F@main@__ptid?2!0&0#6|
                  ((_ sign_extend 32)
                    (ite (= |c:code.c@991@F@main@flip?16!0&0#1| #x00000001)
                         #x00000000
                         #x00000000)))))
  (= a!1 |c:code.c@910@F@main@__ptid?2!0&0#7|)))
(assert (= (fp.mul roundNearestTiesToEven
           |c:code.c@806@F@main@product_prob?2!0&0#6|
           (ite (= |c:code.c@991@F@main@flip?16!0&0#1| #x00000001)
                |c:code.c@173@F@main@prob?1!0&0#1|
                (fp #b0 #x7f #b00000000000000000000000)))
   |c:code.c@806@F@main@product_prob?2!0&0#7|))
(assert (= (bvadd |c:code.c@838@F@main@expected_value?2!0&0#6|
          (ite (= |c:code.c@991@F@main@flip?16!0&0#1| #x00000001)
               ((_ sign_extend 32) |c:code.c@137@F@main@y?1!0&0#1|)
               #x0000000000000000))
   |c:code.c@838@F@main@expected_value?2!0&0#7|))
(assert (= |nondet$symex::nondet18|
   |c:@F@main::$tmp::return_value$_nondet_double$3?17!0&0#1|))
(assert (let ((a!1 (ite (fp.geq (fp.div roundNearestTiesToEven
                                |c:@F@main::$tmp::return_value$_nondet_double$3?17!0&0#1|
                                (fp #b0 #b10000011101 #xfffffffc00000))
                        ((_ to_fp 11 53)
                          roundNearestTiesToEven
                          |c:code.c@173@F@main@prob?1!0&0#1|))
                #x00000001
                #x00000000)))
  (= a!1 |c:code.c@991@F@main@flip?17!0&0#1|)))
(assert (let ((a!1 (bvadd |c:code.c@910@F@main@__ptid?2!0&0#7|
                  ((_ sign_extend 32)
                    (ite (= |c:code.c@991@F@main@flip?17!0&0#1| #x00000001)
                         #x00000000
                         #x00000000)))))
  (= a!1 |c:code.c@910@F@main@__ptid?2!0&0#8|)))
(assert (= (fp.mul roundNearestTiesToEven
           |c:code.c@806@F@main@product_prob?2!0&0#7|
           (ite (= |c:code.c@991@F@main@flip?17!0&0#1| #x00000001)
                |c:code.c@173@F@main@prob?1!0&0#1|
                (fp #b0 #x7f #b00000000000000000000000)))
   |c:code.c@806@F@main@product_prob?2!0&0#8|))
(assert (= (bvadd |c:code.c@838@F@main@expected_value?2!0&0#7|
          (ite (= |c:code.c@991@F@main@flip?17!0&0#1| #x00000001)
               ((_ sign_extend 32) |c:code.c@137@F@main@y?1!0&0#1|)
               #x0000000000000000))
   |c:code.c@838@F@main@expected_value?2!0&0#8|))
(assert (= |nondet$symex::nondet19|
   |c:@F@main::$tmp::return_value$_nondet_double$3?18!0&0#1|))
(assert (let ((a!1 (ite (fp.geq (fp.div roundNearestTiesToEven
                                |c:@F@main::$tmp::return_value$_nondet_double$3?18!0&0#1|
                                (fp #b0 #b10000011101 #xfffffffc00000))
                        ((_ to_fp 11 53)
                          roundNearestTiesToEven
                          |c:code.c@173@F@main@prob?1!0&0#1|))
                #x00000001
                #x00000000)))
  (= a!1 |c:code.c@991@F@main@flip?18!0&0#1|)))
(assert (let ((a!1 (bvadd |c:code.c@910@F@main@__ptid?2!0&0#8|
                  ((_ sign_extend 32)
                    (ite (= |c:code.c@991@F@main@flip?18!0&0#1| #x00000001)
                         #x00000000
                         #x00000000)))))
  (= a!1 |c:code.c@910@F@main@__ptid?2!0&0#9|)))
(assert (= (fp.mul roundNearestTiesToEven
           |c:code.c@806@F@main@product_prob?2!0&0#8|
           (ite (= |c:code.c@991@F@main@flip?18!0&0#1| #x00000001)
                |c:code.c@173@F@main@prob?1!0&0#1|
                (fp #b0 #x7f #b00000000000000000000000)))
   |c:code.c@806@F@main@product_prob?2!0&0#9|))
(assert (= (bvadd |c:code.c@838@F@main@expected_value?2!0&0#8|
          (ite (= |c:code.c@991@F@main@flip?18!0&0#1| #x00000001)
               ((_ sign_extend 32) |c:code.c@137@F@main@y?1!0&0#1|)
               #x0000000000000000))
   |c:code.c@838@F@main@expected_value?2!0&0#9|))
(assert (= |nondet$symex::nondet20|
   |c:@F@main::$tmp::return_value$_nondet_double$3?19!0&0#1|))
(assert (let ((a!1 (ite (fp.geq (fp.div roundNearestTiesToEven
                                |c:@F@main::$tmp::return_value$_nondet_double$3?19!0&0#1|
                                (fp #b0 #b10000011101 #xfffffffc00000))
                        ((_ to_fp 11 53)
                          roundNearestTiesToEven
                          |c:code.c@173@F@main@prob?1!0&0#1|))
                #x00000001
                #x00000000)))
  (= a!1 |c:code.c@991@F@main@flip?19!0&0#1|)))
(assert (let ((a!1 (bvadd |c:code.c@910@F@main@__ptid?2!0&0#9|
                  ((_ sign_extend 32)
                    (ite (= |c:code.c@991@F@main@flip?19!0&0#1| #x00000001)
                         #x00000000
                         #x00000000)))))
  (= a!1 |c:code.c@910@F@main@__ptid?2!0&0#10|)))
(assert (= (fp.mul roundNearestTiesToEven
           |c:code.c@806@F@main@product_prob?2!0&0#9|
           (ite (= |c:code.c@991@F@main@flip?19!0&0#1| #x00000001)
                |c:code.c@173@F@main@prob?1!0&0#1|
                (fp #b0 #x7f #b00000000000000000000000)))
   |c:code.c@806@F@main@product_prob?2!0&0#10|))
(assert (= (bvadd |c:code.c@838@F@main@expected_value?2!0&0#9|
          (ite (= |c:code.c@991@F@main@flip?19!0&0#1| #x00000001)
               ((_ sign_extend 32) |c:code.c@137@F@main@y?1!0&0#1|)
               #x0000000000000000))
   |c:code.c@838@F@main@expected_value?2!0&0#10|))
(assert (= |nondet$symex::nondet21|
   |c:@F@main::$tmp::return_value$_nondet_double$3?20!0&0#1|))
(assert (let ((a!1 (ite (fp.geq (fp.div roundNearestTiesToEven
                                |c:@F@main::$tmp::return_value$_nondet_double$3?20!0&0#1|
                                (fp #b0 #b10000011101 #xfffffffc00000))
                        ((_ to_fp 11 53)
                          roundNearestTiesToEven
                          |c:code.c@173@F@main@prob?1!0&0#1|))
                #x00000001
                #x00000000)))
  (= a!1 |c:code.c@991@F@main@flip?20!0&0#1|)))
(assert (let ((a!1 (bvadd |c:code.c@910@F@main@__ptid?2!0&0#10|
                  ((_ sign_extend 32)
                    (ite (= |c:code.c@991@F@main@flip?20!0&0#1| #x00000001)
                         #x00000000
                         #x00000000)))))
  (= a!1 |c:code.c@910@F@main@__ptid?2!0&0#11|)))
(assert (= (fp.mul roundNearestTiesToEven
           |c:code.c@806@F@main@product_prob?2!0&0#10|
           (ite (= |c:code.c@991@F@main@flip?20!0&0#1| #x00000001)
                |c:code.c@173@F@main@prob?1!0&0#1|
                (fp #b0 #x7f #b00000000000000000000000)))
   |c:code.c@806@F@main@product_prob?2!0&0#11|))
(assert (= (bvadd |c:code.c@838@F@main@expected_value?2!0&0#10|
          (ite (= |c:code.c@991@F@main@flip?20!0&0#1| #x00000001)
               ((_ sign_extend 32) |c:code.c@137@F@main@y?1!0&0#1|)
               #x0000000000000000))
   |c:code.c@838@F@main@expected_value?2!0&0#11|))
(assert (= (store |c:code.c@559@F@main@ptids?1!0&0#1|
          ((_ extract 2 0) #x0000000000000001)
          |c:code.c@910@F@main@__ptid?2!0&0#11|)
   |c:code.c@559@F@main@ptids?1!0&0#2|))
(assert (= (fp.add roundNearestTiesToEven
           |c:code.c@512@F@main@sum_prob?1!0&0#2|
           |c:code.c@806@F@main@product_prob?2!0&0#11|)
   |c:code.c@512@F@main@sum_prob?1!0&0#3|))
(assert (= (bvadd |c:code.c@449@F@main@expected_sum?1!0&0#2|
          |c:code.c@838@F@main@expected_value?2!0&0#11|)
   |c:code.c@449@F@main@expected_sum?1!0&0#3|))
(assert (= (fp.leq |c:code.c@512@F@main@sum_prob?1!0&0#3|
           (fp.mul roundNearestTiesToEven
                   (fp #b0 #x7e #b10011001100110011001101)
                   |c:code.c@173@F@main@prob?1!0&0#1|))
   |goto_symex::guard?0!0&0#3|))
(assert (= |nondet$symex::nondet22|
   |c:@F@main::$tmp::return_value$_nondet_double$3?21!0&0#1|))
(assert (let ((a!1 (ite (fp.geq (fp.div roundNearestTiesToEven
                                |c:@F@main::$tmp::return_value$_nondet_double$3?21!0&0#1|
                                (fp #b0 #b10000011101 #xfffffffc00000))
                        ((_ to_fp 11 53)
                          roundNearestTiesToEven
                          |c:code.c@173@F@main@prob?1!0&0#1|))
                #x00000001
                #x00000000)))
  (= a!1 |c:code.c@991@F@main@flip?21!0&0#1|)))
(assert (= ((_ sign_extend 32)
     (ite (= |c:code.c@991@F@main@flip?21!0&0#1| #x00000001)
          #x00000000
          #x00000000))
   |c:code.c@910@F@main@__ptid?3!0&0#2|))
(assert (= (fp.mul roundNearestTiesToEven
           (fp #b0 #x7f #b00000000000000000000000)
           (ite (= |c:code.c@991@F@main@flip?21!0&0#1| #x00000001)
                |c:code.c@173@F@main@prob?1!0&0#1|
                (fp #b0 #x7f #b00000000000000000000000)))
   |c:code.c@806@F@main@product_prob?3!0&0#2|))
(assert (= (ite (= |c:code.c@991@F@main@flip?21!0&0#1| #x00000001)
        ((_ sign_extend 32) |c:code.c@137@F@main@y?1!0&0#1|)
        #x0000000000000000)
   |c:code.c@838@F@main@expected_value?3!0&0#2|))
(assert (= |nondet$symex::nondet23|
   |c:@F@main::$tmp::return_value$_nondet_double$3?22!0&0#1|))
(assert (let ((a!1 (ite (fp.geq (fp.div roundNearestTiesToEven
                                |c:@F@main::$tmp::return_value$_nondet_double$3?22!0&0#1|
                                (fp #b0 #b10000011101 #xfffffffc00000))
                        ((_ to_fp 11 53)
                          roundNearestTiesToEven
                          |c:code.c@173@F@main@prob?1!0&0#1|))
                #x00000001
                #x00000000)))
  (= a!1 |c:code.c@991@F@main@flip?22!0&0#1|)))
(assert (let ((a!1 (bvadd |c:code.c@910@F@main@__ptid?3!0&0#2|
                  ((_ sign_extend 32)
                    (ite (= |c:code.c@991@F@main@flip?22!0&0#1| #x00000001)
                         #x00000000
                         #x00000000)))))
  (= a!1 |c:code.c@910@F@main@__ptid?3!0&0#3|)))
(assert (= (fp.mul roundNearestTiesToEven
           |c:code.c@806@F@main@product_prob?3!0&0#2|
           (ite (= |c:code.c@991@F@main@flip?22!0&0#1| #x00000001)
                |c:code.c@173@F@main@prob?1!0&0#1|
                (fp #b0 #x7f #b00000000000000000000000)))
   |c:code.c@806@F@main@product_prob?3!0&0#3|))
(assert (= (bvadd |c:code.c@838@F@main@expected_value?3!0&0#2|
          (ite (= |c:code.c@991@F@main@flip?22!0&0#1| #x00000001)
               ((_ sign_extend 32) |c:code.c@137@F@main@y?1!0&0#1|)
               #x0000000000000000))
   |c:code.c@838@F@main@expected_value?3!0&0#3|))
(assert (= |nondet$symex::nondet24|
   |c:@F@main::$tmp::return_value$_nondet_double$3?23!0&0#1|))
(assert (let ((a!1 (ite (fp.geq (fp.div roundNearestTiesToEven
                                |c:@F@main::$tmp::return_value$_nondet_double$3?23!0&0#1|
                                (fp #b0 #b10000011101 #xfffffffc00000))
                        ((_ to_fp 11 53)
                          roundNearestTiesToEven
                          |c:code.c@173@F@main@prob?1!0&0#1|))
                #x00000001
                #x00000000)))
  (= a!1 |c:code.c@991@F@main@flip?23!0&0#1|)))
(assert (let ((a!1 (bvadd |c:code.c@910@F@main@__ptid?3!0&0#3|
                  ((_ sign_extend 32)
                    (ite (= |c:code.c@991@F@main@flip?23!0&0#1| #x00000001)
                         #x00000000
                         #x00000000)))))
  (= a!1 |c:code.c@910@F@main@__ptid?3!0&0#4|)))
(assert (= (fp.mul roundNearestTiesToEven
           |c:code.c@806@F@main@product_prob?3!0&0#3|
           (ite (= |c:code.c@991@F@main@flip?23!0&0#1| #x00000001)
                |c:code.c@173@F@main@prob?1!0&0#1|
                (fp #b0 #x7f #b00000000000000000000000)))
   |c:code.c@806@F@main@product_prob?3!0&0#4|))
(assert (= (bvadd |c:code.c@838@F@main@expected_value?3!0&0#3|
          (ite (= |c:code.c@991@F@main@flip?23!0&0#1| #x00000001)
               ((_ sign_extend 32) |c:code.c@137@F@main@y?1!0&0#1|)
               #x0000000000000000))
   |c:code.c@838@F@main@expected_value?3!0&0#4|))
(assert (= |nondet$symex::nondet25|
   |c:@F@main::$tmp::return_value$_nondet_double$3?24!0&0#1|))
(assert (let ((a!1 (ite (fp.geq (fp.div roundNearestTiesToEven
                                |c:@F@main::$tmp::return_value$_nondet_double$3?24!0&0#1|
                                (fp #b0 #b10000011101 #xfffffffc00000))
                        ((_ to_fp 11 53)
                          roundNearestTiesToEven
                          |c:code.c@173@F@main@prob?1!0&0#1|))
                #x00000001
                #x00000000)))
  (= a!1 |c:code.c@991@F@main@flip?24!0&0#1|)))
(assert (let ((a!1 (bvadd |c:code.c@910@F@main@__ptid?3!0&0#4|
                  ((_ sign_extend 32)
                    (ite (= |c:code.c@991@F@main@flip?24!0&0#1| #x00000001)
                         #x00000000
                         #x00000000)))))
  (= a!1 |c:code.c@910@F@main@__ptid?3!0&0#5|)))
(assert (= (fp.mul roundNearestTiesToEven
           |c:code.c@806@F@main@product_prob?3!0&0#4|
           (ite (= |c:code.c@991@F@main@flip?24!0&0#1| #x00000001)
                |c:code.c@173@F@main@prob?1!0&0#1|
                (fp #b0 #x7f #b00000000000000000000000)))
   |c:code.c@806@F@main@product_prob?3!0&0#5|))
(assert (= (bvadd |c:code.c@838@F@main@expected_value?3!0&0#4|
          (ite (= |c:code.c@991@F@main@flip?24!0&0#1| #x00000001)
               ((_ sign_extend 32) |c:code.c@137@F@main@y?1!0&0#1|)
               #x0000000000000000))
   |c:code.c@838@F@main@expected_value?3!0&0#5|))
(assert (= |nondet$symex::nondet26|
   |c:@F@main::$tmp::return_value$_nondet_double$3?25!0&0#1|))
(assert (let ((a!1 (ite (fp.geq (fp.div roundNearestTiesToEven
                                |c:@F@main::$tmp::return_value$_nondet_double$3?25!0&0#1|
                                (fp #b0 #b10000011101 #xfffffffc00000))
                        ((_ to_fp 11 53)
                          roundNearestTiesToEven
                          |c:code.c@173@F@main@prob?1!0&0#1|))
                #x00000001
                #x00000000)))
  (= a!1 |c:code.c@991@F@main@flip?25!0&0#1|)))
(assert (let ((a!1 (bvadd |c:code.c@910@F@main@__ptid?3!0&0#5|
                  ((_ sign_extend 32)
                    (ite (= |c:code.c@991@F@main@flip?25!0&0#1| #x00000001)
                         #x00000000
                         #x00000000)))))
  (= a!1 |c:code.c@910@F@main@__ptid?3!0&0#6|)))
(assert (= (fp.mul roundNearestTiesToEven
           |c:code.c@806@F@main@product_prob?3!0&0#5|
           (ite (= |c:code.c@991@F@main@flip?25!0&0#1| #x00000001)
                |c:code.c@173@F@main@prob?1!0&0#1|
                (fp #b0 #x7f #b00000000000000000000000)))
   |c:code.c@806@F@main@product_prob?3!0&0#6|))
(assert (= (bvadd |c:code.c@838@F@main@expected_value?3!0&0#5|
          (ite (= |c:code.c@991@F@main@flip?25!0&0#1| #x00000001)
               ((_ sign_extend 32) |c:code.c@137@F@main@y?1!0&0#1|)
               #x0000000000000000))
   |c:code.c@838@F@main@expected_value?3!0&0#6|))
(assert (= |nondet$symex::nondet27|
   |c:@F@main::$tmp::return_value$_nondet_double$3?26!0&0#1|))
(assert (let ((a!1 (ite (fp.geq (fp.div roundNearestTiesToEven
                                |c:@F@main::$tmp::return_value$_nondet_double$3?26!0&0#1|
                                (fp #b0 #b10000011101 #xfffffffc00000))
                        ((_ to_fp 11 53)
                          roundNearestTiesToEven
                          |c:code.c@173@F@main@prob?1!0&0#1|))
                #x00000001
                #x00000000)))
  (= a!1 |c:code.c@991@F@main@flip?26!0&0#1|)))
(assert (let ((a!1 (bvadd |c:code.c@910@F@main@__ptid?3!0&0#6|
                  ((_ sign_extend 32)
                    (ite (= |c:code.c@991@F@main@flip?26!0&0#1| #x00000001)
                         #x00000000
                         #x00000000)))))
  (= a!1 |c:code.c@910@F@main@__ptid?3!0&0#7|)))
(assert (= (fp.mul roundNearestTiesToEven
           |c:code.c@806@F@main@product_prob?3!0&0#6|
           (ite (= |c:code.c@991@F@main@flip?26!0&0#1| #x00000001)
                |c:code.c@173@F@main@prob?1!0&0#1|
                (fp #b0 #x7f #b00000000000000000000000)))
   |c:code.c@806@F@main@product_prob?3!0&0#7|))
(assert (= (bvadd |c:code.c@838@F@main@expected_value?3!0&0#6|
          (ite (= |c:code.c@991@F@main@flip?26!0&0#1| #x00000001)
               ((_ sign_extend 32) |c:code.c@137@F@main@y?1!0&0#1|)
               #x0000000000000000))
   |c:code.c@838@F@main@expected_value?3!0&0#7|))
(assert (= |nondet$symex::nondet28|
   |c:@F@main::$tmp::return_value$_nondet_double$3?27!0&0#1|))
(assert (let ((a!1 (ite (fp.geq (fp.div roundNearestTiesToEven
                                |c:@F@main::$tmp::return_value$_nondet_double$3?27!0&0#1|
                                (fp #b0 #b10000011101 #xfffffffc00000))
                        ((_ to_fp 11 53)
                          roundNearestTiesToEven
                          |c:code.c@173@F@main@prob?1!0&0#1|))
                #x00000001
                #x00000000)))
  (= a!1 |c:code.c@991@F@main@flip?27!0&0#1|)))
(assert (let ((a!1 (bvadd |c:code.c@910@F@main@__ptid?3!0&0#7|
                  ((_ sign_extend 32)
                    (ite (= |c:code.c@991@F@main@flip?27!0&0#1| #x00000001)
                         #x00000000
                         #x00000000)))))
  (= a!1 |c:code.c@910@F@main@__ptid?3!0&0#8|)))
(assert (= (fp.mul roundNearestTiesToEven
           |c:code.c@806@F@main@product_prob?3!0&0#7|
           (ite (= |c:code.c@991@F@main@flip?27!0&0#1| #x00000001)
                |c:code.c@173@F@main@prob?1!0&0#1|
                (fp #b0 #x7f #b00000000000000000000000)))
   |c:code.c@806@F@main@product_prob?3!0&0#8|))
(assert (= (bvadd |c:code.c@838@F@main@expected_value?3!0&0#7|
          (ite (= |c:code.c@991@F@main@flip?27!0&0#1| #x00000001)
               ((_ sign_extend 32) |c:code.c@137@F@main@y?1!0&0#1|)
               #x0000000000000000))
   |c:code.c@838@F@main@expected_value?3!0&0#8|))
(assert (= |nondet$symex::nondet29|
   |c:@F@main::$tmp::return_value$_nondet_double$3?28!0&0#1|))
(assert (let ((a!1 (ite (fp.geq (fp.div roundNearestTiesToEven
                                |c:@F@main::$tmp::return_value$_nondet_double$3?28!0&0#1|
                                (fp #b0 #b10000011101 #xfffffffc00000))
                        ((_ to_fp 11 53)
                          roundNearestTiesToEven
                          |c:code.c@173@F@main@prob?1!0&0#1|))
                #x00000001
                #x00000000)))
  (= a!1 |c:code.c@991@F@main@flip?28!0&0#1|)))
(assert (let ((a!1 (bvadd |c:code.c@910@F@main@__ptid?3!0&0#8|
                  ((_ sign_extend 32)
                    (ite (= |c:code.c@991@F@main@flip?28!0&0#1| #x00000001)
                         #x00000000
                         #x00000000)))))
  (= a!1 |c:code.c@910@F@main@__ptid?3!0&0#9|)))
(assert (= (fp.mul roundNearestTiesToEven
           |c:code.c@806@F@main@product_prob?3!0&0#8|
           (ite (= |c:code.c@991@F@main@flip?28!0&0#1| #x00000001)
                |c:code.c@173@F@main@prob?1!0&0#1|
                (fp #b0 #x7f #b00000000000000000000000)))
   |c:code.c@806@F@main@product_prob?3!0&0#9|))
(assert (= (bvadd |c:code.c@838@F@main@expected_value?3!0&0#8|
          (ite (= |c:code.c@991@F@main@flip?28!0&0#1| #x00000001)
               ((_ sign_extend 32) |c:code.c@137@F@main@y?1!0&0#1|)
               #x0000000000000000))
   |c:code.c@838@F@main@expected_value?3!0&0#9|))
(assert (= |nondet$symex::nondet30|
   |c:@F@main::$tmp::return_value$_nondet_double$3?29!0&0#1|))
(assert (let ((a!1 (ite (fp.geq (fp.div roundNearestTiesToEven
                                |c:@F@main::$tmp::return_value$_nondet_double$3?29!0&0#1|
                                (fp #b0 #b10000011101 #xfffffffc00000))
                        ((_ to_fp 11 53)
                          roundNearestTiesToEven
                          |c:code.c@173@F@main@prob?1!0&0#1|))
                #x00000001
                #x00000000)))
  (= a!1 |c:code.c@991@F@main@flip?29!0&0#1|)))
(assert (let ((a!1 (bvadd |c:code.c@910@F@main@__ptid?3!0&0#9|
                  ((_ sign_extend 32)
                    (ite (= |c:code.c@991@F@main@flip?29!0&0#1| #x00000001)
                         #x00000000
                         #x00000000)))))
  (= a!1 |c:code.c@910@F@main@__ptid?3!0&0#10|)))
(assert (= (fp.mul roundNearestTiesToEven
           |c:code.c@806@F@main@product_prob?3!0&0#9|
           (ite (= |c:code.c@991@F@main@flip?29!0&0#1| #x00000001)
                |c:code.c@173@F@main@prob?1!0&0#1|
                (fp #b0 #x7f #b00000000000000000000000)))
   |c:code.c@806@F@main@product_prob?3!0&0#10|))
(assert (= (bvadd |c:code.c@838@F@main@expected_value?3!0&0#9|
          (ite (= |c:code.c@991@F@main@flip?29!0&0#1| #x00000001)
               ((_ sign_extend 32) |c:code.c@137@F@main@y?1!0&0#1|)
               #x0000000000000000))
   |c:code.c@838@F@main@expected_value?3!0&0#10|))
(assert (= |nondet$symex::nondet31|
   |c:@F@main::$tmp::return_value$_nondet_double$3?30!0&0#1|))
(assert (let ((a!1 (ite (fp.geq (fp.div roundNearestTiesToEven
                                |c:@F@main::$tmp::return_value$_nondet_double$3?30!0&0#1|
                                (fp #b0 #b10000011101 #xfffffffc00000))
                        ((_ to_fp 11 53)
                          roundNearestTiesToEven
                          |c:code.c@173@F@main@prob?1!0&0#1|))
                #x00000001
                #x00000000)))
  (= a!1 |c:code.c@991@F@main@flip?30!0&0#1|)))
(assert (let ((a!1 (bvadd |c:code.c@910@F@main@__ptid?3!0&0#10|
                  ((_ sign_extend 32)
                    (ite (= |c:code.c@991@F@main@flip?30!0&0#1| #x00000001)
                         #x00000000
                         #x00000000)))))
  (= a!1 |c:code.c@910@F@main@__ptid?3!0&0#11|)))
(assert (= (fp.mul roundNearestTiesToEven
           |c:code.c@806@F@main@product_prob?3!0&0#10|
           (ite (= |c:code.c@991@F@main@flip?30!0&0#1| #x00000001)
                |c:code.c@173@F@main@prob?1!0&0#1|
                (fp #b0 #x7f #b00000000000000000000000)))
   |c:code.c@806@F@main@product_prob?3!0&0#11|))
(assert (= (bvadd |c:code.c@838@F@main@expected_value?3!0&0#10|
          (ite (= |c:code.c@991@F@main@flip?30!0&0#1| #x00000001)
               ((_ sign_extend 32) |c:code.c@137@F@main@y?1!0&0#1|)
               #x0000000000000000))
   |c:code.c@838@F@main@expected_value?3!0&0#11|))
(assert (= (store |c:code.c@559@F@main@ptids?1!0&0#2|
          ((_ extract 2 0) #x0000000000000002)
          |c:code.c@910@F@main@__ptid?3!0&0#11|)
   |c:code.c@559@F@main@ptids?1!0&0#3|))
(assert (= (fp.add roundNearestTiesToEven
           |c:code.c@512@F@main@sum_prob?1!0&0#3|
           |c:code.c@806@F@main@product_prob?3!0&0#11|)
   |c:code.c@512@F@main@sum_prob?1!0&0#4|))
(assert (= (bvadd |c:code.c@449@F@main@expected_sum?1!0&0#3|
          |c:code.c@838@F@main@expected_value?3!0&0#11|)
   |c:code.c@449@F@main@expected_sum?1!0&0#4|))
(assert (= (fp.leq |c:code.c@512@F@main@sum_prob?1!0&0#4|
           (fp.mul roundNearestTiesToEven
                   (fp #b0 #x7e #b10011001100110011001101)
                   |c:code.c@173@F@main@prob?1!0&0#1|))
   |goto_symex::guard?0!0&0#4|))
(assert (= |nondet$symex::nondet32|
   |c:@F@main::$tmp::return_value$_nondet_double$3?31!0&0#1|))
(assert (let ((a!1 (ite (fp.geq (fp.div roundNearestTiesToEven
                                |c:@F@main::$tmp::return_value$_nondet_double$3?31!0&0#1|
                                (fp #b0 #b10000011101 #xfffffffc00000))
                        ((_ to_fp 11 53)
                          roundNearestTiesToEven
                          |c:code.c@173@F@main@prob?1!0&0#1|))
                #x00000001
                #x00000000)))
  (= a!1 |c:code.c@991@F@main@flip?31!0&0#1|)))
(assert (= ((_ sign_extend 32)
     (ite (= |c:code.c@991@F@main@flip?31!0&0#1| #x00000001)
          #x00000000
          #x00000000))
   |c:code.c@910@F@main@__ptid?4!0&0#2|))
(assert (= (fp.mul roundNearestTiesToEven
           (fp #b0 #x7f #b00000000000000000000000)
           (ite (= |c:code.c@991@F@main@flip?31!0&0#1| #x00000001)
                |c:code.c@173@F@main@prob?1!0&0#1|
                (fp #b0 #x7f #b00000000000000000000000)))
   |c:code.c@806@F@main@product_prob?4!0&0#2|))
(assert (= (ite (= |c:code.c@991@F@main@flip?31!0&0#1| #x00000001)
        ((_ sign_extend 32) |c:code.c@137@F@main@y?1!0&0#1|)
        #x0000000000000000)
   |c:code.c@838@F@main@expected_value?4!0&0#2|))
(assert (= |nondet$symex::nondet33|
   |c:@F@main::$tmp::return_value$_nondet_double$3?32!0&0#1|))
(assert (let ((a!1 (ite (fp.geq (fp.div roundNearestTiesToEven
                                |c:@F@main::$tmp::return_value$_nondet_double$3?32!0&0#1|
                                (fp #b0 #b10000011101 #xfffffffc00000))
                        ((_ to_fp 11 53)
                          roundNearestTiesToEven
                          |c:code.c@173@F@main@prob?1!0&0#1|))
                #x00000001
                #x00000000)))
  (= a!1 |c:code.c@991@F@main@flip?32!0&0#1|)))
(assert (let ((a!1 (bvadd |c:code.c@910@F@main@__ptid?4!0&0#2|
                  ((_ sign_extend 32)
                    (ite (= |c:code.c@991@F@main@flip?32!0&0#1| #x00000001)
                         #x00000000
                         #x00000000)))))
  (= a!1 |c:code.c@910@F@main@__ptid?4!0&0#3|)))
(assert (= (fp.mul roundNearestTiesToEven
           |c:code.c@806@F@main@product_prob?4!0&0#2|
           (ite (= |c:code.c@991@F@main@flip?32!0&0#1| #x00000001)
                |c:code.c@173@F@main@prob?1!0&0#1|
                (fp #b0 #x7f #b00000000000000000000000)))
   |c:code.c@806@F@main@product_prob?4!0&0#3|))
(assert (= (bvadd |c:code.c@838@F@main@expected_value?4!0&0#2|
          (ite (= |c:code.c@991@F@main@flip?32!0&0#1| #x00000001)
               ((_ sign_extend 32) |c:code.c@137@F@main@y?1!0&0#1|)
               #x0000000000000000))
   |c:code.c@838@F@main@expected_value?4!0&0#3|))
(assert (= |nondet$symex::nondet34|
   |c:@F@main::$tmp::return_value$_nondet_double$3?33!0&0#1|))
(assert (let ((a!1 (ite (fp.geq (fp.div roundNearestTiesToEven
                                |c:@F@main::$tmp::return_value$_nondet_double$3?33!0&0#1|
                                (fp #b0 #b10000011101 #xfffffffc00000))
                        ((_ to_fp 11 53)
                          roundNearestTiesToEven
                          |c:code.c@173@F@main@prob?1!0&0#1|))
                #x00000001
                #x00000000)))
  (= a!1 |c:code.c@991@F@main@flip?33!0&0#1|)))
(assert (let ((a!1 (bvadd |c:code.c@910@F@main@__ptid?4!0&0#3|
                  ((_ sign_extend 32)
                    (ite (= |c:code.c@991@F@main@flip?33!0&0#1| #x00000001)
                         #x00000000
                         #x00000000)))))
  (= a!1 |c:code.c@910@F@main@__ptid?4!0&0#4|)))
(assert (= (fp.mul roundNearestTiesToEven
           |c:code.c@806@F@main@product_prob?4!0&0#3|
           (ite (= |c:code.c@991@F@main@flip?33!0&0#1| #x00000001)
                |c:code.c@173@F@main@prob?1!0&0#1|
                (fp #b0 #x7f #b00000000000000000000000)))
   |c:code.c@806@F@main@product_prob?4!0&0#4|))
(assert (= (bvadd |c:code.c@838@F@main@expected_value?4!0&0#3|
          (ite (= |c:code.c@991@F@main@flip?33!0&0#1| #x00000001)
               ((_ sign_extend 32) |c:code.c@137@F@main@y?1!0&0#1|)
               #x0000000000000000))
   |c:code.c@838@F@main@expected_value?4!0&0#4|))
(assert (= |nondet$symex::nondet35|
   |c:@F@main::$tmp::return_value$_nondet_double$3?34!0&0#1|))
(assert (let ((a!1 (ite (fp.geq (fp.div roundNearestTiesToEven
                                |c:@F@main::$tmp::return_value$_nondet_double$3?34!0&0#1|
                                (fp #b0 #b10000011101 #xfffffffc00000))
                        ((_ to_fp 11 53)
                          roundNearestTiesToEven
                          |c:code.c@173@F@main@prob?1!0&0#1|))
                #x00000001
                #x00000000)))
  (= a!1 |c:code.c@991@F@main@flip?34!0&0#1|)))
(assert (let ((a!1 (bvadd |c:code.c@910@F@main@__ptid?4!0&0#4|
                  ((_ sign_extend 32)
                    (ite (= |c:code.c@991@F@main@flip?34!0&0#1| #x00000001)
                         #x00000000
                         #x00000000)))))
  (= a!1 |c:code.c@910@F@main@__ptid?4!0&0#5|)))
(assert (= (fp.mul roundNearestTiesToEven
           |c:code.c@806@F@main@product_prob?4!0&0#4|
           (ite (= |c:code.c@991@F@main@flip?34!0&0#1| #x00000001)
                |c:code.c@173@F@main@prob?1!0&0#1|
                (fp #b0 #x7f #b00000000000000000000000)))
   |c:code.c@806@F@main@product_prob?4!0&0#5|))
(assert (= (bvadd |c:code.c@838@F@main@expected_value?4!0&0#4|
          (ite (= |c:code.c@991@F@main@flip?34!0&0#1| #x00000001)
               ((_ sign_extend 32) |c:code.c@137@F@main@y?1!0&0#1|)
               #x0000000000000000))
   |c:code.c@838@F@main@expected_value?4!0&0#5|))
(assert (= |nondet$symex::nondet36|
   |c:@F@main::$tmp::return_value$_nondet_double$3?35!0&0#1|))
(assert (let ((a!1 (ite (fp.geq (fp.div roundNearestTiesToEven
                                |c:@F@main::$tmp::return_value$_nondet_double$3?35!0&0#1|
                                (fp #b0 #b10000011101 #xfffffffc00000))
                        ((_ to_fp 11 53)
                          roundNearestTiesToEven
                          |c:code.c@173@F@main@prob?1!0&0#1|))
                #x00000001
                #x00000000)))
  (= a!1 |c:code.c@991@F@main@flip?35!0&0#1|)))
(assert (let ((a!1 (bvadd |c:code.c@910@F@main@__ptid?4!0&0#5|
                  ((_ sign_extend 32)
                    (ite (= |c:code.c@991@F@main@flip?35!0&0#1| #x00000001)
                         #x00000000
                         #x00000000)))))
  (= a!1 |c:code.c@910@F@main@__ptid?4!0&0#6|)))
(assert (= (fp.mul roundNearestTiesToEven
           |c:code.c@806@F@main@product_prob?4!0&0#5|
           (ite (= |c:code.c@991@F@main@flip?35!0&0#1| #x00000001)
                |c:code.c@173@F@main@prob?1!0&0#1|
                (fp #b0 #x7f #b00000000000000000000000)))
   |c:code.c@806@F@main@product_prob?4!0&0#6|))
(assert (= (bvadd |c:code.c@838@F@main@expected_value?4!0&0#5|
          (ite (= |c:code.c@991@F@main@flip?35!0&0#1| #x00000001)
               ((_ sign_extend 32) |c:code.c@137@F@main@y?1!0&0#1|)
               #x0000000000000000))
   |c:code.c@838@F@main@expected_value?4!0&0#6|))
(assert (= |nondet$symex::nondet37|
   |c:@F@main::$tmp::return_value$_nondet_double$3?36!0&0#1|))
(assert (let ((a!1 (ite (fp.geq (fp.div roundNearestTiesToEven
                                |c:@F@main::$tmp::return_value$_nondet_double$3?36!0&0#1|
                                (fp #b0 #b10000011101 #xfffffffc00000))
                        ((_ to_fp 11 53)
                          roundNearestTiesToEven
                          |c:code.c@173@F@main@prob?1!0&0#1|))
                #x00000001
                #x00000000)))
  (= a!1 |c:code.c@991@F@main@flip?36!0&0#1|)))
(assert (let ((a!1 (bvadd |c:code.c@910@F@main@__ptid?4!0&0#6|
                  ((_ sign_extend 32)
                    (ite (= |c:code.c@991@F@main@flip?36!0&0#1| #x00000001)
                         #x00000000
                         #x00000000)))))
  (= a!1 |c:code.c@910@F@main@__ptid?4!0&0#7|)))
(assert (= (fp.mul roundNearestTiesToEven
           |c:code.c@806@F@main@product_prob?4!0&0#6|
           (ite (= |c:code.c@991@F@main@flip?36!0&0#1| #x00000001)
                |c:code.c@173@F@main@prob?1!0&0#1|
                (fp #b0 #x7f #b00000000000000000000000)))
   |c:code.c@806@F@main@product_prob?4!0&0#7|))
(assert (= (bvadd |c:code.c@838@F@main@expected_value?4!0&0#6|
          (ite (= |c:code.c@991@F@main@flip?36!0&0#1| #x00000001)
               ((_ sign_extend 32) |c:code.c@137@F@main@y?1!0&0#1|)
               #x0000000000000000))
   |c:code.c@838@F@main@expected_value?4!0&0#7|))
(assert (= |nondet$symex::nondet38|
   |c:@F@main::$tmp::return_value$_nondet_double$3?37!0&0#1|))
(assert (let ((a!1 (ite (fp.geq (fp.div roundNearestTiesToEven
                                |c:@F@main::$tmp::return_value$_nondet_double$3?37!0&0#1|
                                (fp #b0 #b10000011101 #xfffffffc00000))
                        ((_ to_fp 11 53)
                          roundNearestTiesToEven
                          |c:code.c@173@F@main@prob?1!0&0#1|))
                #x00000001
                #x00000000)))
  (= a!1 |c:code.c@991@F@main@flip?37!0&0#1|)))
(assert (let ((a!1 (bvadd |c:code.c@910@F@main@__ptid?4!0&0#7|
                  ((_ sign_extend 32)
                    (ite (= |c:code.c@991@F@main@flip?37!0&0#1| #x00000001)
                         #x00000000
                         #x00000000)))))
  (= a!1 |c:code.c@910@F@main@__ptid?4!0&0#8|)))
(assert (= (fp.mul roundNearestTiesToEven
           |c:code.c@806@F@main@product_prob?4!0&0#7|
           (ite (= |c:code.c@991@F@main@flip?37!0&0#1| #x00000001)
                |c:code.c@173@F@main@prob?1!0&0#1|
                (fp #b0 #x7f #b00000000000000000000000)))
   |c:code.c@806@F@main@product_prob?4!0&0#8|))
(assert (= (bvadd |c:code.c@838@F@main@expected_value?4!0&0#7|
          (ite (= |c:code.c@991@F@main@flip?37!0&0#1| #x00000001)
               ((_ sign_extend 32) |c:code.c@137@F@main@y?1!0&0#1|)
               #x0000000000000000))
   |c:code.c@838@F@main@expected_value?4!0&0#8|))
(assert (= |nondet$symex::nondet39|
   |c:@F@main::$tmp::return_value$_nondet_double$3?38!0&0#1|))
(assert (let ((a!1 (ite (fp.geq (fp.div roundNearestTiesToEven
                                |c:@F@main::$tmp::return_value$_nondet_double$3?38!0&0#1|
                                (fp #b0 #b10000011101 #xfffffffc00000))
                        ((_ to_fp 11 53)
                          roundNearestTiesToEven
                          |c:code.c@173@F@main@prob?1!0&0#1|))
                #x00000001
                #x00000000)))
  (= a!1 |c:code.c@991@F@main@flip?38!0&0#1|)))
(assert (let ((a!1 (bvadd |c:code.c@910@F@main@__ptid?4!0&0#8|
                  ((_ sign_extend 32)
                    (ite (= |c:code.c@991@F@main@flip?38!0&0#1| #x00000001)
                         #x00000000
                         #x00000000)))))
  (= a!1 |c:code.c@910@F@main@__ptid?4!0&0#9|)))
(assert (= (fp.mul roundNearestTiesToEven
           |c:code.c@806@F@main@product_prob?4!0&0#8|
           (ite (= |c:code.c@991@F@main@flip?38!0&0#1| #x00000001)
                |c:code.c@173@F@main@prob?1!0&0#1|
                (fp #b0 #x7f #b00000000000000000000000)))
   |c:code.c@806@F@main@product_prob?4!0&0#9|))
(assert (= (bvadd |c:code.c@838@F@main@expected_value?4!0&0#8|
          (ite (= |c:code.c@991@F@main@flip?38!0&0#1| #x00000001)
               ((_ sign_extend 32) |c:code.c@137@F@main@y?1!0&0#1|)
               #x0000000000000000))
   |c:code.c@838@F@main@expected_value?4!0&0#9|))
(assert (= |nondet$symex::nondet40|
   |c:@F@main::$tmp::return_value$_nondet_double$3?39!0&0#1|))
(assert (let ((a!1 (ite (fp.geq (fp.div roundNearestTiesToEven
                                |c:@F@main::$tmp::return_value$_nondet_double$3?39!0&0#1|
                                (fp #b0 #b10000011101 #xfffffffc00000))
                        ((_ to_fp 11 53)
                          roundNearestTiesToEven
                          |c:code.c@173@F@main@prob?1!0&0#1|))
                #x00000001
                #x00000000)))
  (= a!1 |c:code.c@991@F@main@flip?39!0&0#1|)))
(assert (let ((a!1 (bvadd |c:code.c@910@F@main@__ptid?4!0&0#9|
                  ((_ sign_extend 32)
                    (ite (= |c:code.c@991@F@main@flip?39!0&0#1| #x00000001)
                         #x00000000
                         #x00000000)))))
  (= a!1 |c:code.c@910@F@main@__ptid?4!0&0#10|)))
(assert (= (fp.mul roundNearestTiesToEven
           |c:code.c@806@F@main@product_prob?4!0&0#9|
           (ite (= |c:code.c@991@F@main@flip?39!0&0#1| #x00000001)
                |c:code.c@173@F@main@prob?1!0&0#1|
                (fp #b0 #x7f #b00000000000000000000000)))
   |c:code.c@806@F@main@product_prob?4!0&0#10|))
(assert (= (bvadd |c:code.c@838@F@main@expected_value?4!0&0#9|
          (ite (= |c:code.c@991@F@main@flip?39!0&0#1| #x00000001)
               ((_ sign_extend 32) |c:code.c@137@F@main@y?1!0&0#1|)
               #x0000000000000000))
   |c:code.c@838@F@main@expected_value?4!0&0#10|))
(assert (= |nondet$symex::nondet41|
   |c:@F@main::$tmp::return_value$_nondet_double$3?40!0&0#1|))
(assert (let ((a!1 (ite (fp.geq (fp.div roundNearestTiesToEven
                                |c:@F@main::$tmp::return_value$_nondet_double$3?40!0&0#1|
                                (fp #b0 #b10000011101 #xfffffffc00000))
                        ((_ to_fp 11 53)
                          roundNearestTiesToEven
                          |c:code.c@173@F@main@prob?1!0&0#1|))
                #x00000001
                #x00000000)))
  (= a!1 |c:code.c@991@F@main@flip?40!0&0#1|)))
(assert (let ((a!1 (bvadd |c:code.c@910@F@main@__ptid?4!0&0#10|
                  ((_ sign_extend 32)
                    (ite (= |c:code.c@991@F@main@flip?40!0&0#1| #x00000001)
                         #x00000000
                         #x00000000)))))
  (= a!1 |c:code.c@910@F@main@__ptid?4!0&0#11|)))
(assert (= (fp.mul roundNearestTiesToEven
           |c:code.c@806@F@main@product_prob?4!0&0#10|
           (ite (= |c:code.c@991@F@main@flip?40!0&0#1| #x00000001)
                |c:code.c@173@F@main@prob?1!0&0#1|
                (fp #b0 #x7f #b00000000000000000000000)))
   |c:code.c@806@F@main@product_prob?4!0&0#11|))
(assert (= (bvadd |c:code.c@838@F@main@expected_value?4!0&0#10|
          (ite (= |c:code.c@991@F@main@flip?40!0&0#1| #x00000001)
               ((_ sign_extend 32) |c:code.c@137@F@main@y?1!0&0#1|)
               #x0000000000000000))
   |c:code.c@838@F@main@expected_value?4!0&0#11|))
(assert (= (store |c:code.c@559@F@main@ptids?1!0&0#3|
          ((_ extract 2 0) #x0000000000000003)
          |c:code.c@910@F@main@__ptid?4!0&0#11|)
   |c:code.c@559@F@main@ptids?1!0&0#4|))
(assert (= (fp.add roundNearestTiesToEven
           |c:code.c@512@F@main@sum_prob?1!0&0#4|
           |c:code.c@806@F@main@product_prob?4!0&0#11|)
   |c:code.c@512@F@main@sum_prob?1!0&0#5|))
(assert (= (bvadd |c:code.c@449@F@main@expected_sum?1!0&0#4|
          |c:code.c@838@F@main@expected_value?4!0&0#11|)
   |c:code.c@449@F@main@expected_sum?1!0&0#5|))
(assert (= (fp.leq |c:code.c@512@F@main@sum_prob?1!0&0#5|
           (fp.mul roundNearestTiesToEven
                   (fp #b0 #x7e #b10011001100110011001101)
                   |c:code.c@173@F@main@prob?1!0&0#1|))
   |goto_symex::guard?0!0&0#5|))
(assert (= |nondet$symex::nondet42|
   |c:@F@main::$tmp::return_value$_nondet_double$3?41!0&0#1|))
(assert (let ((a!1 (ite (fp.geq (fp.div roundNearestTiesToEven
                                |c:@F@main::$tmp::return_value$_nondet_double$3?41!0&0#1|
                                (fp #b0 #b10000011101 #xfffffffc00000))
                        ((_ to_fp 11 53)
                          roundNearestTiesToEven
                          |c:code.c@173@F@main@prob?1!0&0#1|))
                #x00000001
                #x00000000)))
  (= a!1 |c:code.c@991@F@main@flip?41!0&0#1|)))
(assert (= ((_ sign_extend 32)
     (ite (= |c:code.c@991@F@main@flip?41!0&0#1| #x00000001)
          #x00000000
          #x00000000))
   |c:code.c@910@F@main@__ptid?5!0&0#2|))
(assert (= |nondet$symex::nondet43|
   |c:@F@main::$tmp::return_value$_nondet_double$3?42!0&0#1|))
(assert (let ((a!1 (ite (fp.geq (fp.div roundNearestTiesToEven
                                |c:@F@main::$tmp::return_value$_nondet_double$3?42!0&0#1|
                                (fp #b0 #b10000011101 #xfffffffc00000))
                        ((_ to_fp 11 53)
                          roundNearestTiesToEven
                          |c:code.c@173@F@main@prob?1!0&0#1|))
                #x00000001
                #x00000000)))
  (= a!1 |c:code.c@991@F@main@flip?42!0&0#1|)))
(assert (let ((a!1 (bvadd |c:code.c@910@F@main@__ptid?5!0&0#2|
                  ((_ sign_extend 32)
                    (ite (= |c:code.c@991@F@main@flip?42!0&0#1| #x00000001)
                         #x00000000
                         #x00000000)))))
  (= a!1 |c:code.c@910@F@main@__ptid?5!0&0#3|)))
(assert (= |nondet$symex::nondet44|
   |c:@F@main::$tmp::return_value$_nondet_double$3?43!0&0#1|))
(assert (let ((a!1 (ite (fp.geq (fp.div roundNearestTiesToEven
                                |c:@F@main::$tmp::return_value$_nondet_double$3?43!0&0#1|
                                (fp #b0 #b10000011101 #xfffffffc00000))
                        ((_ to_fp 11 53)
                          roundNearestTiesToEven
                          |c:code.c@173@F@main@prob?1!0&0#1|))
                #x00000001
                #x00000000)))
  (= a!1 |c:code.c@991@F@main@flip?43!0&0#1|)))
(assert (let ((a!1 (bvadd |c:code.c@910@F@main@__ptid?5!0&0#3|
                  ((_ sign_extend 32)
                    (ite (= |c:code.c@991@F@main@flip?43!0&0#1| #x00000001)
                         #x00000000
                         #x00000000)))))
  (= a!1 |c:code.c@910@F@main@__ptid?5!0&0#4|)))
(assert (= |nondet$symex::nondet45|
   |c:@F@main::$tmp::return_value$_nondet_double$3?44!0&0#1|))
(assert (let ((a!1 (ite (fp.geq (fp.div roundNearestTiesToEven
                                |c:@F@main::$tmp::return_value$_nondet_double$3?44!0&0#1|
                                (fp #b0 #b10000011101 #xfffffffc00000))
                        ((_ to_fp 11 53)
                          roundNearestTiesToEven
                          |c:code.c@173@F@main@prob?1!0&0#1|))
                #x00000001
                #x00000000)))
  (= a!1 |c:code.c@991@F@main@flip?44!0&0#1|)))
(assert (let ((a!1 (bvadd |c:code.c@910@F@main@__ptid?5!0&0#4|
                  ((_ sign_extend 32)
                    (ite (= |c:code.c@991@F@main@flip?44!0&0#1| #x00000001)
                         #x00000000
                         #x00000000)))))
  (= a!1 |c:code.c@910@F@main@__ptid?5!0&0#5|)))
(assert (= |nondet$symex::nondet46|
   |c:@F@main::$tmp::return_value$_nondet_double$3?45!0&0#1|))
(assert (let ((a!1 (ite (fp.geq (fp.div roundNearestTiesToEven
                                |c:@F@main::$tmp::return_value$_nondet_double$3?45!0&0#1|
                                (fp #b0 #b10000011101 #xfffffffc00000))
                        ((_ to_fp 11 53)
                          roundNearestTiesToEven
                          |c:code.c@173@F@main@prob?1!0&0#1|))
                #x00000001
                #x00000000)))
  (= a!1 |c:code.c@991@F@main@flip?45!0&0#1|)))
(assert (let ((a!1 (bvadd |c:code.c@910@F@main@__ptid?5!0&0#5|
                  ((_ sign_extend 32)
                    (ite (= |c:code.c@991@F@main@flip?45!0&0#1| #x00000001)
                         #x00000000
                         #x00000000)))))
  (= a!1 |c:code.c@910@F@main@__ptid?5!0&0#6|)))
(assert (= |nondet$symex::nondet47|
   |c:@F@main::$tmp::return_value$_nondet_double$3?46!0&0#1|))
(assert (let ((a!1 (ite (fp.geq (fp.div roundNearestTiesToEven
                                |c:@F@main::$tmp::return_value$_nondet_double$3?46!0&0#1|
                                (fp #b0 #b10000011101 #xfffffffc00000))
                        ((_ to_fp 11 53)
                          roundNearestTiesToEven
                          |c:code.c@173@F@main@prob?1!0&0#1|))
                #x00000001
                #x00000000)))
  (= a!1 |c:code.c@991@F@main@flip?46!0&0#1|)))
(assert (let ((a!1 (bvadd |c:code.c@910@F@main@__ptid?5!0&0#6|
                  ((_ sign_extend 32)
                    (ite (= |c:code.c@991@F@main@flip?46!0&0#1| #x00000001)
                         #x00000000
                         #x00000000)))))
  (= a!1 |c:code.c@910@F@main@__ptid?5!0&0#7|)))
(assert (= |nondet$symex::nondet48|
   |c:@F@main::$tmp::return_value$_nondet_double$3?47!0&0#1|))
(assert (let ((a!1 (ite (fp.geq (fp.div roundNearestTiesToEven
                                |c:@F@main::$tmp::return_value$_nondet_double$3?47!0&0#1|
                                (fp #b0 #b10000011101 #xfffffffc00000))
                        ((_ to_fp 11 53)
                          roundNearestTiesToEven
                          |c:code.c@173@F@main@prob?1!0&0#1|))
                #x00000001
                #x00000000)))
  (= a!1 |c:code.c@991@F@main@flip?47!0&0#1|)))
(assert (let ((a!1 (bvadd |c:code.c@910@F@main@__ptid?5!0&0#7|
                  ((_ sign_extend 32)
                    (ite (= |c:code.c@991@F@main@flip?47!0&0#1| #x00000001)
                         #x00000000
                         #x00000000)))))
  (= a!1 |c:code.c@910@F@main@__ptid?5!0&0#8|)))
(assert (= |nondet$symex::nondet49|
   |c:@F@main::$tmp::return_value$_nondet_double$3?48!0&0#1|))
(assert (let ((a!1 (ite (fp.geq (fp.div roundNearestTiesToEven
                                |c:@F@main::$tmp::return_value$_nondet_double$3?48!0&0#1|
                                (fp #b0 #b10000011101 #xfffffffc00000))
                        ((_ to_fp 11 53)
                          roundNearestTiesToEven
                          |c:code.c@173@F@main@prob?1!0&0#1|))
                #x00000001
                #x00000000)))
  (= a!1 |c:code.c@991@F@main@flip?48!0&0#1|)))
(assert (let ((a!1 (bvadd |c:code.c@910@F@main@__ptid?5!0&0#8|
                  ((_ sign_extend 32)
                    (ite (= |c:code.c@991@F@main@flip?48!0&0#1| #x00000001)
                         #x00000000
                         #x00000000)))))
  (= a!1 |c:code.c@910@F@main@__ptid?5!0&0#9|)))
(assert (= |nondet$symex::nondet50|
   |c:@F@main::$tmp::return_value$_nondet_double$3?49!0&0#1|))
(assert (let ((a!1 (ite (fp.geq (fp.div roundNearestTiesToEven
                                |c:@F@main::$tmp::return_value$_nondet_double$3?49!0&0#1|
                                (fp #b0 #b10000011101 #xfffffffc00000))
                        ((_ to_fp 11 53)
                          roundNearestTiesToEven
                          |c:code.c@173@F@main@prob?1!0&0#1|))
                #x00000001
                #x00000000)))
  (= a!1 |c:code.c@991@F@main@flip?49!0&0#1|)))
(assert (let ((a!1 (bvadd |c:code.c@910@F@main@__ptid?5!0&0#9|
                  ((_ sign_extend 32)
                    (ite (= |c:code.c@991@F@main@flip?49!0&0#1| #x00000001)
                         #x00000000
                         #x00000000)))))
  (= a!1 |c:code.c@910@F@main@__ptid?5!0&0#10|)))
(assert (= |nondet$symex::nondet51|
   |c:@F@main::$tmp::return_value$_nondet_double$3?50!0&0#1|))
(assert (let ((a!1 (ite (fp.geq (fp.div roundNearestTiesToEven
                                |c:@F@main::$tmp::return_value$_nondet_double$3?50!0&0#1|
                                (fp #b0 #b10000011101 #xfffffffc00000))
                        ((_ to_fp 11 53)
                          roundNearestTiesToEven
                          |c:code.c@173@F@main@prob?1!0&0#1|))
                #x00000001
                #x00000000)))
  (= a!1 |c:code.c@991@F@main@flip?50!0&0#1|)))
(assert (let ((a!1 (bvadd |c:code.c@910@F@main@__ptid?5!0&0#10|
                  ((_ sign_extend 32)
                    (ite (= |c:code.c@991@F@main@flip?50!0&0#1| #x00000001)
                         #x00000000
                         #x00000000)))))
  (= a!1 |c:code.c@910@F@main@__ptid?5!0&0#11|)))
(assert (= (store |c:code.c@559@F@main@ptids?1!0&0#4|
          ((_ extract 2 0) #x0000000000000004)
          |c:code.c@910@F@main@__ptid?5!0&0#11|)
   |c:code.c@559@F@main@ptids?1!0&0#5|))
(assert (= |c:code.c@449@F@main@expected_sum?1!0&0#5|
   |c:code.c@449@F@main@expected_sum?1!0&0#7|))
(assert (= (ite (not |goto_symex::guard?0!0&0#4|)
        |c:code.c@449@F@main@expected_sum?1!0&0#4|
        |c:code.c@449@F@main@expected_sum?1!0&0#7|)
   |c:code.c@449@F@main@expected_sum?1!0&0#8|))
(assert (= (ite (not |goto_symex::guard?0!0&0#3|)
        |c:code.c@449@F@main@expected_sum?1!0&0#3|
        |c:code.c@449@F@main@expected_sum?1!0&0#8|)
   |c:code.c@449@F@main@expected_sum?1!0&0#9|))
(assert (= (ite (not |goto_symex::guard?0!0&0#2|)
        |c:code.c@449@F@main@expected_sum?1!0&0#2|
        |c:code.c@449@F@main@expected_sum?1!0&0#9|)
   |c:code.c@449@F@main@expected_sum?1!0&0#10|))
(assert (= (ite (not |goto_symex::guard?0!0&0#1|)
        #x0000000000000000
        |c:code.c@449@F@main@expected_sum?1!0&0#10|)
   |c:code.c@449@F@main@expected_sum?1!0&0#11|))
(assert (= (fp.leq |c:code.c@173@F@main@prob?1!0&0#1|
           (fp #b0 #x7e #b00000000000000000000000))
   |goto_symex::guard?0!0&0#6|))
(assert (let ((a!1 (not (= (select |c:code.c@559@F@main@ptids?1!0&0#2|
                           ((_ extract 2 0) #x0000000000000000))
                   |c:code.c@910@F@main@__ptid?2!0&0#11|)))
      (a!2 (not (= (select |c:code.c@559@F@main@ptids?1!0&0#3|
                           ((_ extract 2 0) #x0000000000000000))
                   |c:code.c@910@F@main@__ptid?3!0&0#11|)))
      (a!3 (not (= (select |c:code.c@559@F@main@ptids?1!0&0#3|
                           ((_ extract 2 0) #x0000000000000001))
                   |c:code.c@910@F@main@__ptid?3!0&0#11|)))
      (a!4 (not (= (select |c:code.c@559@F@main@ptids?1!0&0#4|
                           ((_ extract 2 0) #x0000000000000000))
                   |c:code.c@910@F@main@__ptid?4!0&0#11|)))
      (a!6 (not (= (select |c:code.c@559@F@main@ptids?1!0&0#4|
                           ((_ extract 2 0) #x0000000000000001))
                   |c:code.c@910@F@main@__ptid?4!0&0#11|)))
      (a!8 (not (= (select |c:code.c@559@F@main@ptids?1!0&0#4|
                           ((_ extract 2 0) #x0000000000000002))
                   |c:code.c@910@F@main@__ptid?4!0&0#11|)))
      (a!10 (and (and (and (and |goto_symex::guard?0!0&0#1|
                                |goto_symex::guard?0!0&0#2|)
                           |goto_symex::guard?0!0&0#3|)
                      |goto_symex::guard?0!0&0#4|)
                 |goto_symex::guard?0!0&0#5|))
      (a!11 (not (= (select |c:code.c@559@F@main@ptids?1!0&0#5|
                            ((_ extract 2 0) #x0000000000000000))
                    |c:code.c@910@F@main@__ptid?5!0&0#11|)))
      (a!12 (not (= (select |c:code.c@559@F@main@ptids?1!0&0#5|
                            ((_ extract 2 0) #x0000000000000001))
                    |c:code.c@910@F@main@__ptid?5!0&0#11|)))
      (a!13 (not (= (select |c:code.c@559@F@main@ptids?1!0&0#5|
                            ((_ extract 2 0) #x0000000000000002))
                    |c:code.c@910@F@main@__ptid?5!0&0#11|)))
      (a!14 (not (= (select |c:code.c@559@F@main@ptids?1!0&0#5|
                            ((_ extract 2 0) #x0000000000000003))
                    |c:code.c@910@F@main@__ptid?5!0&0#11|)))
      (a!17 (and |goto_symex::guard?0!0&0#3|
                 (or (and |goto_symex::guard?0!0&0#4|
                          (not |goto_symex::guard?0!0&0#5|))
                     (not |goto_symex::guard?0!0&0#4|)))))
(let ((a!5 (=> (and (and (and |goto_symex::guard?0!0&0#1|
                              |goto_symex::guard?0!0&0#2|)
                         |goto_symex::guard?0!0&0#3|)
                    |goto_symex::guard?0!0&0#4|)
               a!4))
      (a!7 (=> (and (and (and |goto_symex::guard?0!0&0#1|
                              |goto_symex::guard?0!0&0#2|)
                         |goto_symex::guard?0!0&0#3|)
                    |goto_symex::guard?0!0&0#4|)
               a!6))
      (a!9 (=> (and (and (and |goto_symex::guard?0!0&0#1|
                              |goto_symex::guard?0!0&0#2|)
                         |goto_symex::guard?0!0&0#3|)
                    |goto_symex::guard?0!0&0#4|)
               a!8))
      (a!18 (or (and |goto_symex::guard?0!0&0#2|
                     (or a!17 (not |goto_symex::guard?0!0&0#3|)))
                (not |goto_symex::guard?0!0&0#2|))))
(let ((a!15 (and true
                 (fp.gt |c:code.c@173@F@main@prob?1!0&0#1|
                        (fp #b0 #x71 #b10100011011011100010111))
                 (fp.leq |c:code.c@173@F@main@prob?1!0&0#1|
                         (fp #b0 #x7f #b00000000000000000000000))
                 (bvsgt |c:code.c@137@F@main@y?1!0&0#1| #x00000000)
                 (bvsle |c:code.c@137@F@main@y?1!0&0#1| #x000003e8)
                 (=> (and |goto_symex::guard?0!0&0#1|
                          |goto_symex::guard?0!0&0#2|)
                     a!1)
                 (=> (and (and |goto_symex::guard?0!0&0#1|
                               |goto_symex::guard?0!0&0#2|)
                          |goto_symex::guard?0!0&0#3|)
                     a!2)
                 (=> (and (and |goto_symex::guard?0!0&0#1|
                               |goto_symex::guard?0!0&0#2|)
                          |goto_symex::guard?0!0&0#3|)
                     a!3)
                 a!5
                 a!7
                 a!9
                 (=> a!10 a!11)
                 (=> a!10 a!12)
                 (=> a!10 a!13)
                 (=> a!10 a!14)))
      (a!19 (=> (and (or (and |goto_symex::guard?0!0&0#1| a!18)
                         (not |goto_symex::guard?0!0&0#1|))
                     |goto_symex::guard?0!0&0#6|)
                (fp.lt ((_ to_fp 11 53)
                         roundNearestTiesToEven
                         |c:code.c@449@F@main@expected_sum?1!0&0#11|)
                       (fp.mul roundNearestTiesToEven
                               (fp #b0 #b10000000001 #x0000000000000)
                               ((_ to_fp 11 53)
                                 roundNearestTiesToEven
                                 |c:code.c@137@F@main@y?1!0&0#1|)))))
      (a!20 (=> (and (or (and |goto_symex::guard?0!0&0#1| a!18)
                         (not |goto_symex::guard?0!0&0#1|))
                     (not |goto_symex::guard?0!0&0#6|))
                (fp.geq ((_ to_fp 11 53)
                          roundNearestTiesToEven
                          |c:code.c@449@F@main@expected_sum?1!0&0#11|)
                        (fp.mul roundNearestTiesToEven
                                (fp #b0 #b10000000001 #x8000000000000)
                                ((_ to_fp 11 53)
                                  roundNearestTiesToEven
                                  |c:code.c@137@F@main@y?1!0&0#1|))))))
(let ((a!16 (not (=> a!15 (=> |execution_statet::\\guard_exec?0!0| (not a!10))))))
  (or a!16
      (not (=> a!15 (=> |execution_statet::\\guard_exec?0!0| a!19)))
      (not (=> a!15 (=> |execution_statet::\\guard_exec?0!0| a!20)))))))))
; Asserts from ESMBC ends
; put optimization expression here.
; Eg : (maximize (ite c 1 0))
; Eg : (minimize obj)
(maximize |c:code.c@449@F@main@expected_sum?1!0&0#11|)
(check-sat)
(get-objectives)
(get-model)
(exit)
