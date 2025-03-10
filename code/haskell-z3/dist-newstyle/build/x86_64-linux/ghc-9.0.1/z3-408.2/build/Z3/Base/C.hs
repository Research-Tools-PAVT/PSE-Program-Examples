{-# LINE 1 "src/Z3/Base/C.hsc" #-}
{-# LANGUAGE EmptyDataDecls #-}

-- |
-- Module    : Z3.Base.C
-- Copyright : (c) Iago Abal, 2012-2014
--             (c) David Castro, 2012-2013
-- License   : BSD3
-- Maintainer: Iago Abal <mail@iagoabal.eu>,
--             David Castro <david.castro.dcp@gmail.com>
--
-- Z3 API foreign imports.

{- HACKING

Add here the foreign import to support a new API function:

* Take a look to a few others foreign imports and follow the same coding style.
    * 2-space wide indentation, no tabs.
    * No trailing spaces, please.
    * ...
* Place the foreign import in the right section, according to the Z3's API documentation.
* Include a reference to the function's API documentation.
-}

module Z3.Base.C where

import Foreign
import Foreign.C.Types
import Foreign.C.String




---------------------------------------------------------------------
-- * Types

data Z3_config

data Z3_context

data Z3_symbol

data Z3_symbol_kind

data Z3_ast

data Z3_sort

data Z3_func_decl

data Z3_decl_kind

data Z3_app

data Z3_pattern

data Z3_constructor

data Z3_constructor_list

data Z3_model

data Z3_goal

data Z3_goal_prec

data Z3_tactic

data Z3_probe

data Z3_apply_result

data Z3_func_interp

data Z3_func_entry

data Z3_fixedpoint

data Z3_optimize

data Z3_solver

data Z3_stats

data Z3_params

data Z3_param_descrs

data Z3_param_kind

data Z3_ast_vector

data Z3_ast_map

data Z3_rcf_num

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#ga6c2de6ea89b244e37c3ffb17a9ea2a89>
newtype Z3_lbool = Z3_lbool CInt
  deriving Eq

z3_l_true, z3_l_false, z3_l_undef :: Z3_lbool
z3_l_true  = Z3_lbool (1)
{-# LINE 103 "src/Z3/Base/C.hsc" #-}
z3_l_false = Z3_lbool (-1)
{-# LINE 104 "src/Z3/Base/C.hsc" #-}
z3_l_undef = Z3_lbool (0)
{-# LINE 105 "src/Z3/Base/C.hsc" #-}

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#ga3a65ded0ada3ee285865759a21140eeb>
newtype Z3_bool = Z3_bool CInt
  deriving Eq

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#ga311274c8a65a5d25cf715ebdf0c68747>
type Z3_error_handler = Ptr Z3_context -> Z3_error_code -> IO ()

z3_true, z3_false :: Z3_bool
-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#gad86c8730a2e4e61bac585b240a6288d4>
z3_true  = Z3_bool(1)
{-# LINE 116 "src/Z3/Base/C.hsc" #-}
-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#ga1d9cee57472b2c7623642f123b8f1781>
z3_false = Z3_bool(0)
{-# LINE 118 "src/Z3/Base/C.hsc" #-}

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#ga49f047b93b0282e686956678da5b86b1>
type Z3_string = CString

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#ga0112dc1e8e08a19bf7a4299bb09a9727>
type Z3_ast_print_mode = CInt
z3_print_smtlib_full :: Z3_ast_print_mode
z3_print_smtlib_full = 0
{-# LINE 126 "src/Z3/Base/C.hsc" #-}
z3_print_low_level :: Z3_ast_print_mode
z3_print_low_level = 1
{-# LINE 128 "src/Z3/Base/C.hsc" #-}
z3_print_smtlib2_compliant :: Z3_ast_print_mode
z3_print_smtlib2_compliant = 2
{-# LINE 130 "src/Z3/Base/C.hsc" #-}

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#gaa9f9e7b1b5b81381fab96debbaaa638f>
type Z3_error_code = CInt
z3_ok                 :: Z3_error_code
z3_ok                 =  0
z3_sort_error         :: Z3_error_code
z3_sort_error         =  1
z3_iob                :: Z3_error_code
z3_iob                =  2
z3_invalid_arg        :: Z3_error_code
z3_invalid_arg        =  3
z3_parser_error       :: Z3_error_code
z3_parser_error       =  4
z3_no_parser          :: Z3_error_code
z3_no_parser          =  5
z3_invalid_pattern    :: Z3_error_code
z3_invalid_pattern    =  6
z3_memout_fail        :: Z3_error_code
z3_memout_fail        =  7
z3_file_access_error  :: Z3_error_code
z3_file_access_error  =  8
z3_internal_fatal     :: Z3_error_code
z3_internal_fatal     =  9
z3_invalid_usage      :: Z3_error_code
z3_invalid_usage      =  10
z3_dec_ref_error      :: Z3_error_code
z3_dec_ref_error      =  11
z3_exception          :: Z3_error_code
z3_exception          =  12

{-# LINE 148 "src/Z3/Base/C.hsc" #-}

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#ga4cd6ad05aba48f4b679f0c13310ed2a4>
type Z3_sort_kind = CInt
z3_uninterpreted_sort :: Z3_sort_kind
z3_uninterpreted_sort = 0
{-# LINE 153 "src/Z3/Base/C.hsc" #-}
z3_bool_sort :: Z3_sort_kind
z3_bool_sort = 1
{-# LINE 155 "src/Z3/Base/C.hsc" #-}
z3_int_sort :: Z3_sort_kind
z3_int_sort = 2
{-# LINE 157 "src/Z3/Base/C.hsc" #-}
z3_real_sort :: Z3_sort_kind
z3_real_sort = 3
{-# LINE 159 "src/Z3/Base/C.hsc" #-}
z3_bv_sort :: Z3_sort_kind
z3_bv_sort = 4
{-# LINE 161 "src/Z3/Base/C.hsc" #-}
z3_array_sort :: Z3_sort_kind
z3_array_sort = 5
{-# LINE 163 "src/Z3/Base/C.hsc" #-}
z3_datatype_sort :: Z3_sort_kind
z3_datatype_sort = 6
{-# LINE 165 "src/Z3/Base/C.hsc" #-}
z3_relation_sort :: Z3_sort_kind
z3_relation_sort = 7
{-# LINE 167 "src/Z3/Base/C.hsc" #-}
z3_finite_domain_sort :: Z3_sort_kind
z3_finite_domain_sort = 8
{-# LINE 169 "src/Z3/Base/C.hsc" #-}
z3_floating_point_sort :: Z3_sort_kind
z3_floating_point_sort = 9
{-# LINE 171 "src/Z3/Base/C.hsc" #-}
z3_rounding_mode_sort :: Z3_sort_kind
z3_rounding_mode_sort = 10
{-# LINE 173 "src/Z3/Base/C.hsc" #-}
z3_unknown_sort :: Z3_sort_kind
z3_unknown_sort = 1000
{-# LINE 175 "src/Z3/Base/C.hsc" #-}


-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#ga015148ad21a032e79a496629651dedb8>
type Z3_ast_kind = CInt
z3_numeral_ast :: Z3_ast_kind
z3_numeral_ast = 0
{-# LINE 181 "src/Z3/Base/C.hsc" #-}
z3_app_ast :: Z3_ast_kind
z3_app_ast = 1
{-# LINE 183 "src/Z3/Base/C.hsc" #-}
z3_var_ast :: Z3_ast_kind
z3_var_ast = 2
{-# LINE 185 "src/Z3/Base/C.hsc" #-}
z3_quantifier_ast :: Z3_ast_kind
z3_quantifier_ast = 3
{-# LINE 187 "src/Z3/Base/C.hsc" #-}
z3_sort_ast :: Z3_ast_kind
z3_sort_ast = 4
{-# LINE 189 "src/Z3/Base/C.hsc" #-}
z3_func_decl_ast :: Z3_ast_kind
z3_func_decl_ast = 5
{-# LINE 191 "src/Z3/Base/C.hsc" #-}
z3_unknown_ast :: Z3_ast_kind
z3_unknown_ast = 1000
{-# LINE 193 "src/Z3/Base/C.hsc" #-}

---------------------------------------------------------------------
-- * Algebraic Numbers

foreign import ccall unsafe "Z3_algebraic_is_value"
    z3_algebraic_is_value :: Ptr Z3_context -> Ptr Z3_ast -> IO Z3_bool

foreign import ccall unsafe "Z3_algebraic_is_pos"
    z3_algebraic_is_pos :: Ptr Z3_context -> Ptr Z3_ast -> IO Z3_bool

foreign import ccall unsafe "Z3_algebraic_is_neg"
    z3_algebraic_is_neg :: Ptr Z3_context -> Ptr Z3_ast -> IO Z3_bool

foreign import ccall unsafe "Z3_algebraic_is_zero"
    z3_algebraic_is_zero :: Ptr Z3_context -> Ptr Z3_ast -> IO Z3_bool

foreign import ccall unsafe "Z3_algebraic_sign"
    z3_algebraic_sign :: Ptr Z3_context -> Ptr Z3_ast -> IO CInt

foreign import ccall unsafe "Z3_algebraic_add"
    z3_algebraic_add :: Ptr Z3_context -> Ptr Z3_ast -> Ptr Z3_ast -> IO (Ptr Z3_ast)

foreign import ccall unsafe "Z3_algebraic_sub"
    z3_algebraic_sub :: Ptr Z3_context -> Ptr Z3_ast -> Ptr Z3_ast -> IO (Ptr Z3_ast)

foreign import ccall unsafe "Z3_algebraic_mul"
    z3_algebraic_mul :: Ptr Z3_context -> Ptr Z3_ast -> Ptr Z3_ast -> IO (Ptr Z3_ast)

foreign import ccall unsafe "Z3_algebraic_div"
    z3_algebraic_div :: Ptr Z3_context -> Ptr Z3_ast -> Ptr Z3_ast -> IO (Ptr Z3_ast)

foreign import ccall unsafe "Z3_algebraic_root"
    z3_algebraic_root :: Ptr Z3_context -> Ptr Z3_ast -> CUInt -> IO (Ptr Z3_ast)

foreign import ccall unsafe "Z3_algebraic_power"
    z3_algebraic_power :: Ptr Z3_context -> Ptr Z3_ast -> CUInt -> IO (Ptr Z3_ast)

foreign import ccall unsafe "Z3_algebraic_lt"
    z3_algebraic_lt :: Ptr Z3_context -> Ptr Z3_ast -> Ptr Z3_ast -> IO Z3_bool

foreign import ccall unsafe "Z3_algebraic_gt"
    z3_algebraic_gt :: Ptr Z3_context -> Ptr Z3_ast -> Ptr Z3_ast -> IO Z3_bool

foreign import ccall unsafe "Z3_algebraic_le"
    z3_algebraic_le :: Ptr Z3_context -> Ptr Z3_ast -> Ptr Z3_ast -> IO Z3_bool

foreign import ccall unsafe "Z3_algebraic_ge"
    z3_algebraic_ge :: Ptr Z3_context -> Ptr Z3_ast -> Ptr Z3_ast -> IO Z3_bool

foreign import ccall unsafe "Z3_algebraic_eq"
    z3_algebraic_eq :: Ptr Z3_context -> Ptr Z3_ast -> Ptr Z3_ast -> IO Z3_bool

foreign import ccall unsafe "Z3_algebraic_neq"
    z3_algebraic_neq :: Ptr Z3_context -> Ptr Z3_ast -> Ptr Z3_ast -> IO Z3_bool

foreign import ccall unsafe "Z3_algebraic_roots"
    z3_algebraic_roots :: Ptr Z3_context -> Ptr Z3_ast -> CUInt -> Ptr (Ptr Z3_ast) -> IO (Ptr Z3_ast_vector)

foreign import ccall unsafe "Z3_algebraic_eval"
    z3_algebraic_eval :: Ptr Z3_context -> Ptr Z3_ast -> CUInt -> Ptr (Ptr Z3_ast) -> IO CInt

-- foreign import ccall unsafe "Z3_algebraic_get_poly"
--     z3_algebraic_get_poly :: Ptr Z3_context -> Ptr Z3_ast -> IO (Ptr Z3_ast_vector)

-- foreign import ccall unsafe "Z3_algebraic_get_i"
--     z3_algebraic_get_i :: Ptr Z3_context -> Ptr Z3_ast -> IO CUInt

---------------------------------------------------------------------
-- * Global Parameters

foreign import ccall unsafe "Z3_global_param_set"
    z3_global_param_set :: Z3_string -> Z3_string -> IO ()

foreign import ccall unsafe "Z3_global_param_reset_all"
    z3_global_param_reset_all :: IO ()

foreign import ccall unsafe "Z3_global_param_get"
    z3_global_param_get :: Z3_string -> Ptr Z3_string -> IO Z3_bool

---------------------------------------------------------------------
-- * Create configuration

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#ga7d6c40d9b79fe8a8851cc8540970787f>
foreign import ccall unsafe "Z3_mk_config"
    z3_mk_config :: IO (Ptr Z3_config)

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#ga5e620acf5d55d0271097c9bb97219774>
foreign import ccall unsafe "Z3_del_config"
    z3_del_config :: Ptr Z3_config -> IO ()

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#ga001ade87a1671fe77d7e53ed0f4f1ec3>
foreign import ccall unsafe "Z3_set_param_value"
    z3_set_param_value :: Ptr Z3_config -> Z3_string -> Z3_string -> IO ()


---------------------------------------------------------------------
-- * Create context

foreign import ccall unsafe "Z3_mk_context"
    z3_mk_context :: Ptr Z3_config -> IO (Ptr Z3_context)

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#ga98acd59d946eceb4f261bc50489216ee>
foreign import ccall unsafe "Z3_mk_context_rc"
    z3_mk_context_rc :: Ptr Z3_config -> IO (Ptr Z3_context)

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#ga556eae80ed43ab13e1e7dc3b38c35200>
foreign import ccall unsafe "Z3_del_context"
    z3_del_context :: Ptr Z3_context -> IO ()

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#ga4a11514494fbf3467b89f0a80ac81e7a>
foreign import ccall unsafe "Z3_inc_ref"
  z3_inc_ref :: Ptr Z3_context -> Ptr Z3_ast -> IO ()

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#ga9cd52225142c085630495044acc68bd2>
foreign import ccall unsafe "Z3_dec_ref"
  z3_dec_ref :: Ptr Z3_context -> Ptr Z3_ast -> IO ()

foreign import ccall unsafe "Z3_update_param_value"
  z3_update_param_value :: Ptr Z3_context -> Z3_string -> Z3_string -> IO ()

foreign import ccall unsafe "Z3_interrupt"
  z3_interrupt :: Ptr Z3_context -> IO ()

---------------------------------------------------------------------
-- * Parameters

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#gac7f883536538ab0ad234fde58988e673>
foreign import ccall unsafe "Z3_mk_params"
    z3_mk_params :: Ptr Z3_context -> IO (Ptr Z3_params)

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#ga3a91c9f749b89e1dcf1493177d395d0c>
foreign import ccall unsafe "Z3_params_inc_ref"
    z3_params_inc_ref :: Ptr Z3_context -> Ptr Z3_params -> IO ()

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#gae4df28ba713b81ee99abd929e32484ea>
foreign import ccall unsafe "Z3_params_dec_ref"
    z3_params_dec_ref :: Ptr Z3_context -> Ptr Z3_params -> IO ()

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#ga39e3df967eaad45b343256d56c54e91c>
foreign import ccall unsafe "Z3_params_set_bool"
    z3_params_set_bool :: Ptr Z3_context -> Ptr Z3_params -> Ptr Z3_symbol ->
                          Z3_bool -> IO ()

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#ga4974397cb652c7f7f479012eb465e250>
foreign import ccall unsafe "Z3_params_set_uint"
    z3_params_set_uint :: Ptr Z3_context -> Ptr Z3_params -> Ptr Z3_symbol ->
                          CUInt -> IO ()

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#ga11498ce4b25d294f5f89ab7ac1b74c62>
foreign import ccall unsafe "Z3_params_set_double"
    z3_params_set_double :: Ptr Z3_context -> Ptr Z3_params -> Ptr Z3_symbol ->
                            CDouble -> IO ()

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#gac2e899a4906b6133a23fdb60ef992ec9>
foreign import ccall unsafe "Z3_params_set_symbol"
    z3_params_set_symbol :: Ptr Z3_context -> Ptr Z3_params -> Ptr Z3_symbol ->
                            Ptr Z3_symbol -> IO ()

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#ga624e692e180a8b2f617156b1e1ae9722>
foreign import ccall unsafe "Z3_params_to_string"
    z3_params_to_string :: Ptr Z3_context -> Ptr Z3_params -> IO Z3_string

foreign import ccall unsafe "Z3_params_validate"
    z3_params_validate :: Ptr Z3_context -> Ptr Z3_params -> Ptr Z3_param_descrs -> IO ()

---------------------------------------------------------------------
-- * Parameter Descriptions

foreign import ccall unsafe "Z3_param_descrs_inc_ref"
    z3_param_descrs_inc_ref :: Ptr Z3_context -> Ptr Z3_param_descrs -> IO ()

foreign import ccall unsafe "Z3_param_descrs_dec_ref"
    z3_param_descrs_dec_ref :: Ptr Z3_context -> Ptr Z3_param_descrs -> IO ()

foreign import ccall unsafe "Z3_param_descrs_get_kind"
    z3_param_descrs_get_kind :: Ptr Z3_context -> Ptr Z3_param_descrs -> Ptr Z3_symbol -> IO (Ptr Z3_param_kind)

foreign import ccall unsafe "Z3_param_descrs_size"
    z3_param_descrs_size :: Ptr Z3_context -> Ptr Z3_param_descrs -> IO (CUInt)

foreign import ccall unsafe "Z3_param_descrs_get_name"
    z3_param_descrs_get_name :: Ptr Z3_context -> Ptr Z3_param_descrs -> CUInt -> IO (Ptr Z3_symbol)

foreign import ccall unsafe "Z3_param_descrs_get_documentation"
    z3_param_descrs_get_documentation :: Ptr Z3_context -> Ptr Z3_param_descrs -> Ptr Z3_symbol -> IO (Z3_string)

foreign import ccall unsafe "Z3_param_descrs_to_string"
    z3_param_descrs_to_string :: Ptr Z3_context -> Ptr Z3_param_descrs -> IO (Z3_string)

---------------------------------------------------------------------
-- * Symbols

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#ga3df806baf6124df3e63a58cf23e12411>
foreign import ccall unsafe "Z3_mk_int_symbol"
    z3_mk_int_symbol :: Ptr Z3_context -> CInt -> IO (Ptr Z3_symbol)

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#gafebb0d3c212927cf7834c3a20a84ecae>
foreign import ccall unsafe "Z3_mk_string_symbol"
    z3_mk_string_symbol :: Ptr Z3_context -> Z3_string -> IO (Ptr Z3_symbol)

---------------------------------------------------------------------
-- * Sorts

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#ga736e88741af1c178cbebf94c49aa42de>
foreign import ccall unsafe "Z3_mk_uninterpreted_sort"
    z3_mk_uninterpreted_sort :: Ptr Z3_context -> Ptr Z3_symbol -> IO (Ptr Z3_sort)

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#gacdc73510b69a010b71793d429015f342>
foreign import ccall unsafe "Z3_mk_bool_sort"
    z3_mk_bool_sort :: Ptr Z3_context -> IO (Ptr Z3_sort)

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#ga6cd426ab5748653b77d389fd3eac1015>
foreign import ccall unsafe "Z3_mk_int_sort"
    z3_mk_int_sort :: Ptr Z3_context -> IO (Ptr Z3_sort)

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#ga40ef93b9738485caed6dc84631c3c1a0>
foreign import ccall unsafe "Z3_mk_real_sort"
    z3_mk_real_sort :: Ptr Z3_context -> IO (Ptr Z3_sort)

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#gaeed000a1bbb84b6ca6fdaac6cf0c1688>
foreign import ccall unsafe "Z3_mk_bv_sort"
    z3_mk_bv_sort :: Ptr Z3_context -> CUInt -> IO (Ptr Z3_sort)

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#ga62166c0e3f9a8be4ba492eee5a52ce1b>
foreign import ccall unsafe "Z3_mk_finite_domain_sort"
    z3_mk_finite_domain_sort :: Ptr Z3_context -> Ptr Z3_symbol -> CULLong -> IO (Ptr Z3_sort)

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#gafe617994cce1b516f46128e448c84445>
foreign import ccall unsafe "Z3_mk_array_sort"
    z3_mk_array_sort :: Ptr Z3_context
                     -> Ptr Z3_sort  -- ^ domain
                     -> Ptr Z3_sort  -- ^ range
                     -> IO (Ptr Z3_sort)

foreign import ccall unsafe "Z3_mk_array_sort_n"
    z3_mk_array_sort_n :: Ptr Z3_context
                       -> CUInt              -- ^ number of arguments
                       -> Ptr (Ptr Z3_sort)  -- ^ domain
                       -> Ptr Z3_sort        -- ^ range
                       -> IO (Ptr Z3_sort)


-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#ga7156b9c0a76a28fae46c81f8e3cdf0f1>
foreign import ccall unsafe "Z3_mk_tuple_sort"
    z3_mk_tuple_sort :: Ptr Z3_context
                     -> Ptr Z3_symbol
                     -> CUInt
                     -> Ptr (Ptr Z3_symbol)
                     -> Ptr (Ptr Z3_sort)
                     -> Ptr (Ptr Z3_func_decl)
                     -> Ptr (Ptr Z3_func_decl)
                     -> IO (Ptr Z3_sort)

foreign import ccall unsafe "Z3_mk_enumeration_sort"
    z3_mk_enumeration_sort :: Ptr Z3_context
                           -> Ptr Z3_symbol
                           -> CUInt
                           -> Ptr (Ptr Z3_symbol)
                           -> Ptr (Ptr Z3_func_decl)
                           -> Ptr (Ptr Z3_func_decl)
                           -> IO (Ptr Z3_sort)

foreign import ccall unsafe "Z3_mk_list_sort"
    z3_mk_list_sort :: Ptr Z3_context
                    -> Ptr Z3_symbol
                    -> Ptr Z3_sort
                    -> Ptr (Ptr Z3_func_decl)
                    -> Ptr (Ptr Z3_func_decl)
                    -> Ptr (Ptr Z3_func_decl)
                    -> Ptr (Ptr Z3_func_decl)
                    -> Ptr (Ptr Z3_func_decl)
                    -> Ptr (Ptr Z3_func_decl)
                    -> IO (Ptr Z3_sort)

-- | Reference <http://z3prover.github.io/api/html/group__capi.html#gaa779e39f7050b9d51857887954b5f9b0>
foreign import ccall unsafe "Z3_mk_constructor"
    z3_mk_constructor :: Ptr Z3_context
                      -> Ptr Z3_symbol
                      -> Ptr Z3_symbol
                      -> CUInt
                      -> Ptr (Ptr Z3_symbol)
                      -> Ptr (Ptr Z3_sort)
                      -> Ptr CUInt
                      -> IO (Ptr Z3_constructor)

-- | Reference <http://z3prover.github.io/api/html/group__capi.html#ga63816efdbce93734c72f395b6a6a9e35>
foreign import ccall unsafe "Z3_del_constructor"
    z3_del_constructor :: Ptr Z3_context -> Ptr Z3_constructor -> IO ()

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#gab6809d53327d807da9158abdf75df387>
foreign import ccall unsafe "Z3_mk_datatype"
    z3_mk_datatype :: Ptr Z3_context
                   -> Ptr Z3_symbol
                   -> CUInt
                   -> Ptr (Ptr Z3_constructor)
                   -> IO (Ptr Z3_sort)

-- | Reference <http://z3prover.github.io/api/html/group__capi.html#gac9305d5d4eb1ce68d17300f5af19fafd>
foreign import ccall unsafe "Z3_mk_constructor_list"
    z3_mk_constructor_list :: Ptr Z3_context
                           -> CUInt
                           -> Ptr (Ptr Z3_constructor)
                           -> IO (Ptr Z3_constructor_list)

-- | Reference <http://z3prover.github.io/api/html/group__capi.html#gaa7a2e823e23fdfba407ea5088c8d1709>
foreign import ccall unsafe "Z3_del_constructor_list"
    z3_del_constructor_list :: Ptr Z3_context
                            -> Ptr (Z3_constructor_list)
                            -> IO ()

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#gac9305d5d4eb1ce68d17300f5af19fafd>
foreign import ccall unsafe "Z3_mk_datatypes"
    z3_mk_datatypes :: Ptr Z3_context
                    -> CUInt
                    -> Ptr (Ptr Z3_symbol)
                    -> Ptr (Ptr Z3_sort)
                    -> Ptr (Ptr Z3_constructor_list)
                    -> IO ()

-- TODO the func_decls need be Ptr(Ptr) I think
--      test it
foreign import ccall unsafe "Z3_query_constructor"
    z3_query_constructor :: Ptr Z3_context
                         -> Ptr Z3_constructor
                         -> CUInt
                         -> Ptr Z3_func_decl
                         -> Ptr Z3_func_decl
                         -> Ptr (Ptr Z3_func_decl)

---------------------------------------------------------------------
-- * Constants and Applications

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#gaa5c5e2602a44d5f1373f077434859ca2>
foreign import ccall unsafe "Z3_mk_func_decl"
    z3_mk_func_decl :: Ptr Z3_context
                         -> Ptr Z3_symbol
                         -> CUInt
                         -> Ptr (Ptr Z3_sort)
                         -> Ptr Z3_sort
                         -> IO (Ptr Z3_func_decl)

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#ga33a202d86bf628bfab9b6f437536cebe>
foreign import ccall unsafe "Z3_mk_app"
    z3_mk_app :: Ptr Z3_context
                   -> Ptr Z3_func_decl
                   -> CUInt
                   -> Ptr (Ptr Z3_ast)
                   -> IO (Ptr Z3_ast)

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#ga093c9703393f33ae282ec5e8729354ef>
foreign import ccall unsafe "Z3_mk_const"
    z3_mk_const :: Ptr Z3_context -> Ptr Z3_symbol -> Ptr Z3_sort -> IO (Ptr Z3_ast)

-- Reference: <http://z3prover.github.io/api/html/group__capi.html#ga1f60c7eb41c5603e55a188a14dc929ec>
foreign import ccall unsafe "Z3_mk_fresh_func_decl"
    z3_mk_fresh_func_decl :: Ptr z3_context
                          -> Z3_string
                          -> CUInt
                          -> Ptr (Ptr Z3_sort)
                          -> Ptr Z3_sort
                          -> IO (Ptr Z3_func_decl)

-- Reference: <http://z3prover.github.io/api/html/group__capi.html#ga99cbd3e87cdd759a3d0ea43b4884ed32>
foreign import ccall unsafe "Z3_mk_fresh_const"
    z3_mk_fresh_const :: Ptr Z3_context -> Z3_string -> Ptr Z3_sort -> IO (Ptr Z3_ast)

foreign import ccall unsafe "Z3_mk_rec_func_decl"
    z3_mk_rec_func_decl :: Ptr Z3_context
                        -> Ptr Z3_symbol
                        -> CUInt
                        -> Ptr (Ptr Z3_sort)
                        -> Ptr Z3_sort
                        -> IO (Ptr Z3_func_decl)

foreign import ccall unsafe "Z3_add_rec_def"
    z3_add_rec_def :: Ptr Z3_context
                   -> Ptr Z3_func_decl
                   -> CUInt
--                   -> Ptr Z3_ast_vector
                   -> Ptr (Ptr Z3_ast)
                   -> Ptr Z3_ast
                   -> IO ()

---------------------------------------------------------------------
-- * Propositional Logic and Equality

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#gae898e7380409bbc57b56cc5205ef1db7>
foreign import ccall unsafe "Z3_mk_true"
    z3_mk_true :: Ptr Z3_context -> IO (Ptr Z3_ast)

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#ga5952ac17671117a02001fed6575c778d>
foreign import ccall unsafe "Z3_mk_false"
    z3_mk_false :: Ptr Z3_context -> IO (Ptr Z3_ast)

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#ga95a19ce675b70e22bb0401f7137af37c>
foreign import ccall unsafe "Z3_mk_eq"
    z3_mk_eq :: Ptr Z3_context -> Ptr Z3_ast -> Ptr Z3_ast -> IO (Ptr Z3_ast)

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#gaa076d3a668e0ec97d61744403153ecf7>
foreign import ccall unsafe "Z3_mk_distinct"
    z3_mk_distinct :: Ptr Z3_context -> CUInt -> Ptr (Ptr Z3_ast) -> IO (Ptr Z3_ast)

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#ga3329538091996eb7b3dc677760a61072>
foreign import ccall unsafe "Z3_mk_not"
    z3_mk_not :: Ptr Z3_context -> Ptr Z3_ast -> IO (Ptr Z3_ast)

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#ga94417eed5c36e1ad48bcfc8ad6e83547>
foreign import ccall unsafe "Z3_mk_ite"
    z3_mk_ite :: Ptr Z3_context -> Ptr Z3_ast -> Ptr Z3_ast -> Ptr Z3_ast -> IO (Ptr Z3_ast)

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#ga930a8e844d345fbebc498ac43a696042>
foreign import ccall unsafe "Z3_mk_iff"
    z3_mk_iff :: Ptr Z3_context -> Ptr Z3_ast -> Ptr Z3_ast -> IO (Ptr Z3_ast)

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#gac829c0e25bbbd30343bf073f7b524517>
foreign import ccall unsafe "Z3_mk_implies"
    z3_mk_implies :: Ptr Z3_context -> Ptr Z3_ast -> Ptr Z3_ast -> IO (Ptr Z3_ast)

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#gacc6d1b848032dec0c4617b594d4229ec>
foreign import ccall unsafe "Z3_mk_xor"
    z3_mk_xor :: Ptr Z3_context -> Ptr Z3_ast -> Ptr Z3_ast -> IO (Ptr Z3_ast)

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#gacde98ce4a8ed1dde50b9669db4838c61>
foreign import ccall unsafe "Z3_mk_and"
    z3_mk_and :: Ptr Z3_context -> CUInt -> Ptr (Ptr Z3_ast) -> IO (Ptr Z3_ast)

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#ga00866d16331d505620a6c515302021f9>
foreign import ccall unsafe "Z3_mk_or"
    z3_mk_or :: Ptr Z3_context -> CUInt -> Ptr (Ptr Z3_ast) -> IO (Ptr Z3_ast)

---------------------------------------------------------------------
-- * Arithmetic: Integers and Reals

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#ga4e4ac0a4e53eee0b4b0ef159ed7d0cd5>
foreign import ccall unsafe "Z3_mk_add"
    z3_mk_add :: Ptr Z3_context -> CUInt -> Ptr (Ptr Z3_ast) -> IO (Ptr Z3_ast)

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#gab9affbf8401a18eea474b59ad4adc890>
foreign import ccall unsafe "Z3_mk_mul"
    z3_mk_mul :: Ptr Z3_context -> CUInt -> Ptr (Ptr Z3_ast) -> IO (Ptr Z3_ast)

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#ga4f5fea9b683f9e674fd8f14d676cc9a9>
foreign import ccall unsafe "Z3_mk_sub"
    z3_mk_sub :: Ptr Z3_context -> CUInt -> Ptr (Ptr Z3_ast) -> IO (Ptr Z3_ast)

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#gadcd2929ad732937e25f34277ce4988ea>
foreign import ccall unsafe "Z3_mk_unary_minus"
    z3_mk_unary_minus :: Ptr Z3_context -> Ptr Z3_ast -> IO (Ptr Z3_ast)

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#ga1ac60ee8307af8d0b900375914194ff3>
foreign import ccall unsafe "Z3_mk_div"
    z3_mk_div :: Ptr Z3_context -> Ptr Z3_ast -> Ptr Z3_ast ->  IO (Ptr Z3_ast)

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#ga8e350ac77e6b8fe805f57efe196e7713>
foreign import ccall unsafe "Z3_mk_mod"
    z3_mk_mod :: Ptr Z3_context -> Ptr Z3_ast -> Ptr Z3_ast ->  IO (Ptr Z3_ast)

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#ga2fcdb17f9039bbdaddf8a30d037bd9ff>
foreign import ccall unsafe "Z3_mk_rem"
    z3_mk_rem :: Ptr Z3_context -> Ptr Z3_ast -> Ptr Z3_ast ->  IO (Ptr Z3_ast)

-- | Reference: <https://z3prover.github.io/api/html/group__capi.html#ga8414506c805caa171f0c1fe29f9f9612>
foreign import ccall unsafe "Z3_mk_power"
    z3_mk_power :: Ptr Z3_context -> Ptr Z3_ast -> Ptr Z3_ast ->  IO (Ptr Z3_ast)

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#ga58a3dc67c5de52cf599c346803ba1534>
foreign import ccall unsafe "Z3_mk_lt"
    z3_mk_lt :: Ptr Z3_context -> Ptr Z3_ast -> Ptr Z3_ast ->  IO (Ptr Z3_ast)

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#gaa9a33d11096841f4e8c407f1578bc0bf>
foreign import ccall unsafe "Z3_mk_le"
    z3_mk_le :: Ptr Z3_context -> Ptr Z3_ast -> Ptr Z3_ast ->  IO (Ptr Z3_ast)

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#ga46167b86067586bb742c0557d7babfd3>
foreign import ccall unsafe "Z3_mk_gt"
    z3_mk_gt :: Ptr Z3_context -> Ptr Z3_ast -> Ptr Z3_ast ->  IO (Ptr Z3_ast)

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#gad9245cbadb80b192323d01a8360fb942>
foreign import ccall unsafe "Z3_mk_ge"
    z3_mk_ge :: Ptr Z3_context -> Ptr Z3_ast -> Ptr Z3_ast ->  IO (Ptr Z3_ast)

foreign import ccall unsafe "Z3_mk_divides"
    z3_mk_divides :: Ptr Z3_context -> Ptr Z3_ast -> Ptr Z3_ast ->  IO (Ptr Z3_ast)

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#ga7130641e614c7ebafd28ae16a7681a21>
foreign import ccall unsafe "Z3_mk_int2real"
    z3_mk_int2real :: Ptr Z3_context -> Ptr Z3_ast -> IO (Ptr Z3_ast)

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#ga759b6563ba1204aae55289009a3fdc6d>
foreign import ccall unsafe "Z3_mk_real2int"
    z3_mk_real2int :: Ptr Z3_context -> Ptr Z3_ast -> IO (Ptr Z3_ast)

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#gaac2ad0fb04e4900fdb4add438d137ad3>
foreign import ccall unsafe "Z3_mk_is_int"
    z3_mk_is_int :: Ptr Z3_context -> Ptr Z3_ast -> IO (Ptr Z3_ast)

---------------------------------------------------------------------
-- * Bit-vectors

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#ga36cf75c92c54c1ca633a230344f23080>
foreign import ccall unsafe "Z3_mk_bvnot"
    z3_mk_bvnot :: Ptr Z3_context -> Ptr Z3_ast -> IO (Ptr Z3_ast)

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#gaccc04f2b58903279b1b3be589b00a7d8>
foreign import ccall unsafe "Z3_mk_bvredand"
    z3_mk_bvredand :: Ptr Z3_context -> Ptr Z3_ast -> IO (Ptr Z3_ast)

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#gafd18e127c0586abf47ad9cd96895f7d2>
foreign import ccall unsafe "Z3_mk_bvredor"
    z3_mk_bvredor :: Ptr Z3_context -> Ptr Z3_ast -> IO (Ptr Z3_ast)

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#gab96e0ea55334cbcd5a0e79323b57615d>
foreign import ccall unsafe "Z3_mk_bvand"
    z3_mk_bvand :: Ptr Z3_context -> Ptr Z3_ast -> Ptr Z3_ast -> IO (Ptr Z3_ast)

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#ga77a6ae233fb3371d187c6d559b2843f5>
foreign import ccall unsafe "Z3_mk_bvor"
    z3_mk_bvor :: Ptr Z3_context -> Ptr Z3_ast -> Ptr Z3_ast -> IO (Ptr Z3_ast)

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#ga0a3821ea00b1c762205f73e4bc29e7d8>
foreign import ccall unsafe "Z3_mk_bvxor"
    z3_mk_bvxor :: Ptr Z3_context -> Ptr Z3_ast -> Ptr Z3_ast -> IO (Ptr Z3_ast)

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#ga96dc37d36efd658fff5b2b4df49b0e61>
foreign import ccall unsafe "Z3_mk_bvnand"
    z3_mk_bvnand :: Ptr Z3_context -> Ptr Z3_ast -> Ptr Z3_ast -> IO (Ptr Z3_ast)

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#gabf15059e9e8a2eafe4929fdfd259aadb>
foreign import ccall unsafe "Z3_mk_bvnor"
    z3_mk_bvnor :: Ptr Z3_context -> Ptr Z3_ast -> Ptr Z3_ast -> IO (Ptr Z3_ast)

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#ga784f5ca36a4b03b93c67242cc94b21d6>
foreign import ccall unsafe "Z3_mk_bvxnor"
    z3_mk_bvxnor :: Ptr Z3_context -> Ptr Z3_ast -> Ptr Z3_ast -> IO (Ptr Z3_ast)

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#ga0c78be00c03eda4ed6a983224ed5c7b7
foreign import ccall unsafe "Z3_mk_bvneg"
    z3_mk_bvneg :: Ptr Z3_context -> Ptr Z3_ast -> IO (Ptr Z3_ast)

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#ga819814e33573f3f9948b32fdc5311158>
foreign import ccall unsafe "Z3_mk_bvadd"
    z3_mk_bvadd :: Ptr Z3_context -> Ptr Z3_ast -> Ptr Z3_ast -> IO (Ptr Z3_ast)

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#ga688c9aa1347888c7a51be4e46c19178e>
foreign import ccall unsafe "Z3_mk_bvsub"
    z3_mk_bvsub :: Ptr Z3_context -> Ptr Z3_ast -> Ptr Z3_ast -> IO (Ptr Z3_ast)

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#ga6abd3dde2a1ceff1704cf7221a72258c>
foreign import ccall unsafe "Z3_mk_bvmul"
    z3_mk_bvmul :: Ptr Z3_context -> Ptr Z3_ast -> Ptr Z3_ast -> IO (Ptr Z3_ast)

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#ga56ce0cd61666c6f8cf5777286f590544>
foreign import ccall unsafe "Z3_mk_bvudiv"
    z3_mk_bvudiv :: Ptr Z3_context -> Ptr Z3_ast -> Ptr Z3_ast -> IO (Ptr Z3_ast)

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#gad240fedb2fda1c1005b8e9d3c7f3d5a0>
foreign import ccall unsafe "Z3_mk_bvsdiv"
    z3_mk_bvsdiv :: Ptr Z3_context -> Ptr Z3_ast -> Ptr Z3_ast -> IO (Ptr Z3_ast)

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#ga5df4298ec835e43ddc9e3e0bae690c8d>
foreign import ccall unsafe "Z3_mk_bvurem"
    z3_mk_bvurem :: Ptr Z3_context -> Ptr Z3_ast -> Ptr Z3_ast -> IO (Ptr Z3_ast)

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#ga46c18a3042fca174fe659d3185693db1>
foreign import ccall unsafe "Z3_mk_bvsrem"
    z3_mk_bvsrem :: Ptr Z3_context -> Ptr Z3_ast -> Ptr Z3_ast -> IO (Ptr Z3_ast)

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#ga95dac8e6eecb50f63cb82038560e0879>
foreign import ccall unsafe "Z3_mk_bvsmod"
    z3_mk_bvsmod :: Ptr Z3_context -> Ptr Z3_ast -> Ptr Z3_ast -> IO (Ptr Z3_ast)

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#ga5774b22e93abcaf9b594672af6c7c3c4>
foreign import ccall unsafe "Z3_mk_bvult"
    z3_mk_bvult :: Ptr Z3_context -> Ptr Z3_ast -> Ptr Z3_ast -> IO (Ptr Z3_ast)

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#ga8ce08af4ed1fbdf08d4d6e63d171663a>
foreign import ccall unsafe "Z3_mk_bvslt"
    z3_mk_bvslt :: Ptr Z3_context -> Ptr Z3_ast -> Ptr Z3_ast -> IO (Ptr Z3_ast)

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#gab738b89de0410e70c089d3ac9e696e87>
foreign import ccall unsafe "Z3_mk_bvule"
    z3_mk_bvule :: Ptr Z3_context -> Ptr Z3_ast -> Ptr Z3_ast -> IO (Ptr Z3_ast)

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#gab7c026feb93e7d2eab180e96f1e6255d>
foreign import ccall unsafe "Z3_mk_bvsle"
    z3_mk_bvsle :: Ptr Z3_context -> Ptr Z3_ast -> Ptr Z3_ast -> IO (Ptr Z3_ast)

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#gade58fbfcf61b67bf8c4a441490d3c4df>
foreign import ccall unsafe "Z3_mk_bvuge"
    z3_mk_bvuge :: Ptr Z3_context -> Ptr Z3_ast -> Ptr Z3_ast -> IO (Ptr Z3_ast)

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#gaeec3414c0e8a90a6aa5a23af36bf6dc5>
foreign import ccall unsafe "Z3_mk_bvsge"
    z3_mk_bvsge :: Ptr Z3_context -> Ptr Z3_ast -> Ptr Z3_ast -> IO (Ptr Z3_ast)

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#ga063ab9f16246c99e5c1c893613927ee3>
foreign import ccall unsafe "Z3_mk_bvugt"
    z3_mk_bvugt :: Ptr Z3_context -> Ptr Z3_ast -> Ptr Z3_ast -> IO (Ptr Z3_ast)

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#ga4e93a985aa2a7812c7c11a2c65d7c5f0>
foreign import ccall unsafe "Z3_mk_bvsgt"
    z3_mk_bvsgt :: Ptr Z3_context -> Ptr Z3_ast -> Ptr Z3_ast -> IO (Ptr Z3_ast)

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#gae774128fa5e9ff7458a36bd10e6ca0fa>
foreign import ccall unsafe "Z3_mk_concat"
    z3_mk_concat :: Ptr Z3_context -> Ptr Z3_ast -> Ptr Z3_ast -> IO (Ptr Z3_ast)

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#ga32d2fe7563f3e6b114c1b97b205d4317>
foreign import ccall unsafe "Z3_mk_extract"
    z3_mk_extract :: Ptr Z3_context -> CUInt -> CUInt -> Ptr Z3_ast -> IO (Ptr Z3_ast)

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#gad29099270b36d0680bb54b560353c10e>
foreign import ccall unsafe "Z3_mk_sign_ext"
    z3_mk_sign_ext :: Ptr Z3_context -> CUInt -> Ptr Z3_ast -> IO (Ptr Z3_ast)

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#gac9322fae11365a78640baf9078c428b3>
foreign import ccall unsafe "Z3_mk_zero_ext"
    z3_mk_zero_ext :: Ptr Z3_context -> CUInt -> Ptr Z3_ast -> IO (Ptr Z3_ast)

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#ga03e81721502ea225c264d1f556c9119d>
foreign import ccall unsafe "Z3_mk_repeat"
    z3_mk_repeat :: Ptr Z3_context -> CUInt -> Ptr Z3_ast -> IO (Ptr Z3_ast)

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#gac8d5e776c786c1172fa0d7dfede454e1>
foreign import ccall unsafe "Z3_mk_bvshl"
    z3_mk_bvshl :: Ptr Z3_context -> Ptr Z3_ast -> Ptr Z3_ast -> IO (Ptr Z3_ast)

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#gac59645a6edadad79a201f417e4e0c512>
foreign import ccall unsafe "Z3_mk_bvlshr"
    z3_mk_bvlshr :: Ptr Z3_context -> Ptr Z3_ast -> Ptr Z3_ast -> IO (Ptr Z3_ast)

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#ga674b580ad605ba1c2c9f9d3748be87c4>
foreign import ccall unsafe "Z3_mk_bvashr"
    z3_mk_bvashr :: Ptr Z3_context -> Ptr Z3_ast -> Ptr Z3_ast -> IO (Ptr Z3_ast)

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#ga4932b7d08fea079dd903cd857a52dcda>
foreign import ccall unsafe "Z3_mk_rotate_left"
    z3_mk_rotate_left :: Ptr Z3_context -> CUInt -> Ptr Z3_ast -> IO (Ptr Z3_ast)

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#ga3b94e1bf87ecd1a1858af8ebc1da4a1c>
foreign import ccall unsafe "Z3_mk_rotate_right"
    z3_mk_rotate_right :: Ptr Z3_context -> CUInt -> Ptr Z3_ast -> IO (Ptr Z3_ast)

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#gaf46f1cb80e5a56044591a76e7c89e5e7>
foreign import ccall unsafe "Z3_mk_ext_rotate_left"
    z3_mk_ext_rotate_left :: Ptr Z3_context -> Ptr Z3_ast -> Ptr Z3_ast -> IO (Ptr Z3_ast)

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#gabb227526c592b523879083f12aab281f>
foreign import ccall unsafe "Z3_mk_ext_rotate_right"
    z3_mk_ext_rotate_right :: Ptr Z3_context -> Ptr Z3_ast -> Ptr Z3_ast -> IO (Ptr Z3_ast)

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#ga35f89eb05df43fbd9cce7200cc1f30b5>
foreign import ccall unsafe "Z3_mk_int2bv"
    z3_mk_int2bv :: Ptr Z3_context -> CUInt -> Ptr Z3_ast -> IO (Ptr Z3_ast)

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#gac87b227dc3821d57258d7f53a28323d4>
foreign import ccall unsafe "Z3_mk_bv2int"
    z3_mk_bv2int :: Ptr Z3_context -> Ptr Z3_ast -> Z3_bool -> IO (Ptr Z3_ast)

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#ga88f6b5ec876f05e0d7ba51e96c4b077f>
foreign import ccall unsafe "Z3_mk_bvadd_no_overflow"
    z3_mk_bvadd_no_overflow :: Ptr Z3_context -> Ptr Z3_ast -> Ptr Z3_ast -> Z3_bool -> IO (Ptr Z3_ast)

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#ga1e2b1927cf4e50000c1600d47a152947>
foreign import ccall unsafe "Z3_mk_bvadd_no_underflow"
    z3_mk_bvadd_no_underflow :: Ptr Z3_context -> Ptr Z3_ast -> Ptr Z3_ast -> IO (Ptr Z3_ast)

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#ga785f8127b87e0b42130e6d8f52167d7c>
foreign import ccall unsafe "Z3_mk_bvsub_no_overflow"
    z3_mk_bvsub_no_overflow :: Ptr Z3_context -> Ptr Z3_ast -> Ptr Z3_ast -> IO (Ptr Z3_ast)

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#ga6480850f9fa01e14aea936c88ff184c4>
foreign import ccall unsafe "Z3_mk_bvsub_no_underflow"
    z3_mk_bvsub_no_underflow :: Ptr Z3_context -> Ptr Z3_ast -> Ptr Z3_ast -> IO (Ptr Z3_ast)

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#gaa17e7b2c33dfe2abbd74d390927ae83e>
foreign import ccall unsafe "Z3_mk_bvsdiv_no_overflow"
    z3_mk_bvsdiv_no_overflow :: Ptr Z3_context -> Ptr Z3_ast -> Ptr Z3_ast -> IO (Ptr Z3_ast)

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#gae9c5d72605ddcd0e76657341eaccb6c7>
foreign import ccall unsafe "Z3_mk_bvneg_no_overflow"
    z3_mk_bvneg_no_overflow :: Ptr Z3_context -> Ptr Z3_ast -> IO (Ptr Z3_ast)

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#ga86f4415719d295a2f6845c70b3aaa1df>
foreign import ccall unsafe "Z3_mk_bvmul_no_overflow"
    z3_mk_bvmul_no_overflow :: Ptr Z3_context -> Ptr Z3_ast -> Ptr Z3_ast -> Z3_bool -> IO (Ptr Z3_ast)

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#ga501ccc01d737aad3ede5699741717fda>
foreign import ccall unsafe "Z3_mk_bvmul_no_underflow"
    z3_mk_bvmul_no_underflow :: Ptr Z3_context -> Ptr Z3_ast -> Ptr Z3_ast -> IO (Ptr Z3_ast)

--------------------------------------------------------------------------------
-- * Arrays

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#ga38f423f3683379e7f597a7fe59eccb67>
foreign import ccall unsafe "Z3_mk_select"
    z3_mk_select :: Ptr Z3_context
                 -> Ptr Z3_ast  -- ^ aray
                 -> Ptr Z3_ast  -- ^ index
                 -> IO (Ptr Z3_ast)

foreign import ccall unsafe "Z3_mk_select_n"
    z3_mk_select_n :: Ptr Z3_context
                   -> Ptr Z3_ast
                   -> CUInt
                   -> Ptr Z3_ast_vector
                   -> IO (Ptr Z3_ast)

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#gae305a4f54b4a64f7e5973ae6ccb13593>
foreign import ccall unsafe "Z3_mk_store"
    z3_mk_store :: Ptr Z3_context
                -> Ptr Z3_ast  -- ^ array
                -> Ptr Z3_ast  -- ^ index
                -> Ptr Z3_ast  -- ^ value to store at array[index]
                -> IO (Ptr Z3_ast)

foreign import ccall unsafe "Z3_mk_store_n"
    z3_mk_store_n :: Ptr Z3_context
                  -> Ptr Z3_ast
                  -> CUInt
                  -> Ptr Z3_ast_vector
                  -> Ptr Z3_ast
                   -> IO (Ptr Z3_ast)

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#ga84ea6f0c32b99c70033feaa8f00e8f2d>
foreign import ccall unsafe "Z3_mk_const_array"
    z3_mk_const_array :: Ptr Z3_context -> Ptr Z3_sort -> Ptr Z3_ast -> IO (Ptr Z3_ast)

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#ga9150242d9430a8c3d55d2ca3b9a4362d>
foreign import ccall unsafe "Z3_mk_map"
    z3_mk_map :: Ptr Z3_context -> Ptr Z3_func_decl -> CUInt -> Ptr (Ptr Z3_ast) -> IO (Ptr Z3_ast)

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#ga78e89cca82f0ab4d5f4e662e5e5fba7d>
foreign import ccall unsafe "Z3_mk_array_default"
    z3_mk_array_default :: Ptr Z3_context -> Ptr Z3_ast -> IO (Ptr Z3_ast)

foreign import ccall unsafe "Z3_mk_as_array"
    z3_mk_as_array :: Ptr Z3_context
                   -> Ptr Z3_func_decl
                   -> IO (Ptr Z3_ast)

foreign import ccall unsafe "Z3_mk_set_has_size"
    z3_mk_set_has_size :: Ptr Z3_context
                       -> Ptr Z3_ast
                       -> Ptr Z3_ast
                       -> IO (Ptr Z3_ast)

--------------------------------------------------------------------------------
-- * Sets

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#ga6865879523e7e882d7e50a2d8445ac8b>
foreign import ccall unsafe "Z3_mk_set_sort"
    z3_mk_set_sort :: Ptr Z3_context -> Ptr Z3_sort -> IO (Ptr Z3_sort)

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#ga358b6b80509a567148f1c0ca9252118c>
foreign import ccall unsafe "Z3_mk_empty_set"
    z3_mk_empty_set :: Ptr Z3_context -> Ptr Z3_sort -> IO (Ptr Z3_ast)

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#ga5e92662c657374f7332aa32ce4503dd2>
foreign import ccall unsafe "Z3_mk_full_set"
    z3_mk_full_set :: Ptr Z3_context -> Ptr Z3_sort -> IO (Ptr Z3_ast)

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#ga856c3d0e28ce720f53912c2bbdd76175>
foreign import ccall unsafe "Z3_mk_set_add"
    z3_mk_set_add :: Ptr Z3_context -> Ptr Z3_ast -> Ptr Z3_ast -> IO (Ptr Z3_ast)

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#ga80e883f39dd3b88f9d0745c8a5b91d1d>
foreign import ccall unsafe "Z3_mk_set_del"
    z3_mk_set_del :: Ptr Z3_context -> Ptr Z3_ast -> Ptr Z3_ast -> IO (Ptr Z3_ast)

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#ga4050162a13d539b8913200963bb4743c>
foreign import ccall unsafe "Z3_mk_set_union"
    z3_mk_set_union :: Ptr Z3_context -> CUInt -> Ptr (Ptr Z3_ast) -> IO (Ptr Z3_ast)

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#ga8a8abff0ebe6aeeaa6c919eaa013049d>
foreign import ccall unsafe "Z3_mk_set_intersect"
    z3_mk_set_intersect :: Ptr Z3_context -> CUInt -> Ptr (Ptr Z3_ast) -> IO (Ptr Z3_ast)

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#gabb49c62f70b8198362e1a29ba6d8bde1>
foreign import ccall unsafe "Z3_mk_set_difference"
    z3_mk_set_difference :: Ptr Z3_context -> Ptr Z3_ast -> Ptr Z3_ast -> IO (Ptr Z3_ast)

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#ga5c57143c9229cdf730c5103ff696590f>
foreign import ccall unsafe "Z3_mk_set_complement"
    z3_mk_set_complement :: Ptr Z3_context -> Ptr Z3_ast -> IO (Ptr Z3_ast)

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#gac6e516f3dce0bdd41095c6d6daf56063>
foreign import ccall unsafe "Z3_mk_set_member"
    z3_mk_set_member :: Ptr Z3_context -> Ptr Z3_ast -> Ptr Z3_ast -> IO (Ptr Z3_ast)

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#ga139c5803af0e86464adc7cedc53e7f3a>
foreign import ccall unsafe "Z3_mk_set_subset"
    z3_mk_set_subset :: Ptr Z3_context -> Ptr Z3_ast -> Ptr Z3_ast -> IO (Ptr Z3_ast)

foreign import ccall unsafe "Z3_mk_array_ext"
    z3_mk_array_ext :: Ptr Z3_context
                    -> Ptr Z3_ast
                    -> Ptr Z3_ast
                    -> IO (Ptr Z3_ast)

---------------------------------------------------------------------
-- * Numerals

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#gac8aca397e32ca33618d8024bff32948c>
foreign import ccall unsafe "Z3_mk_numeral"
    z3_mk_numeral :: Ptr Z3_context -> Z3_string -> Ptr Z3_sort ->  IO (Ptr Z3_ast)

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#gabe0bbc1e01a084a75506a62e5e6900b3>
foreign import ccall unsafe "Z3_mk_real"
    z3_mk_real :: Ptr Z3_context -> CInt -> CInt -> IO (Ptr Z3_ast)

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#ga8779204998136569c3e166c34cfd3e2c>
foreign import ccall unsafe "Z3_mk_int"
    z3_mk_int :: Ptr Z3_context -> CInt -> Ptr Z3_sort ->  IO (Ptr Z3_ast)

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#ga7201b6231b61421c005457206760a121>
foreign import ccall unsafe "Z3_mk_unsigned_int"
    z3_mk_unsigned_int :: Ptr Z3_context -> CUInt -> Ptr Z3_sort ->  IO (Ptr Z3_ast)

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#ga42cc319787d485d9cb665d80e02d206f>
foreign import ccall unsafe "Z3_mk_int64"
    z3_mk_int64 :: Ptr Z3_context -> CLLong -> Ptr Z3_sort ->  IO (Ptr Z3_ast)

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#ga88a165138162a8bac401672f0a1b7891>
foreign import ccall unsafe "Z3_mk_unsigned_int64"
    z3_mk_unsigned_int64 :: Ptr Z3_context -> CULLong -> Ptr Z3_sort ->  IO (Ptr Z3_ast)

foreign import ccall unsafe "Z3_mk_bv_numeral"
    z3_mk_bv_numeral :: Ptr Z3_context
                     -> CUInt
                     -> Ptr Z3_bool
                     -> IO (Ptr Z3_ast)

---------------------------------------------------------------------
-- * Sequences and regular expressions

foreign import ccall unsafe "Z3_mk_seq_sort"
    z3_mk_seq_sort :: Ptr Z3_context -> Ptr Z3_sort -> IO (Ptr Z3_sort)

foreign import ccall unsafe "Z3_is_seq_sort"
    z3_is_seq_sort :: Ptr Z3_context -> Ptr Z3_sort -> IO Z3_bool

foreign import ccall unsafe "Z3_get_seq_sort_basis"
    z3_get_seq_sort_basis :: Ptr Z3_context
                          -> Ptr Z3_sort
                          -> IO (Ptr Z3_sort)

foreign import ccall unsafe "Z3_mk_re_sort"
    z3_mk_re_sort :: Ptr Z3_context -> Ptr Z3_sort -> IO (Ptr Z3_sort)

foreign import ccall unsafe "Z3_is_re_sort"
    z3_is_re_sort :: Ptr Z3_context -> Ptr Z3_sort -> IO Z3_bool

foreign import ccall unsafe "Z3_get_re_sort_basis"
    z3_get_re_sort_basis :: Ptr Z3_context
                         -> Ptr Z3_sort
                         -> IO (Ptr Z3_sort)

foreign import ccall unsafe "Z3_mk_string_sort"
    z3_mk_string_sort :: Ptr Z3_context -> IO (Ptr Z3_sort)

foreign import ccall unsafe "Z3_is_string_sort"
    z3_is_string_sort :: Ptr Z3_context -> Ptr Z3_sort -> IO Z3_bool

foreign import ccall unsafe "Z3_mk_string"
    z3_mk_string :: Ptr Z3_context -> Z3_string -> IO (Ptr Z3_ast)

foreign import ccall unsafe "Z3_mk_lstring"
    z3_mk_lstring :: Ptr Z3_context -> CUInt -> Z3_string -> IO (Ptr Z3_ast)

foreign import ccall unsafe "Z3_is_string"
    z3_is_string :: Ptr Z3_context -> Ptr Z3_ast -> IO Z3_bool

foreign import ccall unsafe "Z3_get_string"
    z3_get_string :: Ptr Z3_context -> Ptr Z3_ast -> IO Z3_string

foreign import ccall unsafe "Z3_get_lstring"
    z3_get_lstring :: Ptr Z3_context -> Ptr Z3_ast -> CUInt -> IO Z3_string

foreign import ccall unsafe "Z3_mk_seq_empty"
    z3_mk_seq_empty :: Ptr Z3_context -> Ptr Z3_sort -> IO (Ptr Z3_ast)

foreign import ccall unsafe "Z3_mk_seq_unit"
    z3_mk_seq_unit :: Ptr Z3_context -> Ptr Z3_ast -> IO (Ptr Z3_ast)

foreign import ccall unsafe "Z3_mk_seq_concat"
    z3_mk_seq_concat :: Ptr Z3_context -> CUInt -> Ptr (Ptr Z3_ast) -> IO (Ptr Z3_ast)

foreign import ccall unsafe "Z3_mk_seq_prefix"
    z3_mk_seq_prefix :: Ptr Z3_context -> Ptr Z3_ast -> Ptr Z3_ast -> IO (Ptr Z3_ast)

foreign import ccall unsafe "Z3_mk_seq_suffix"
    z3_mk_seq_suffix :: Ptr Z3_context -> Ptr Z3_ast -> Ptr Z3_ast -> IO (Ptr Z3_ast)

foreign import ccall unsafe "Z3_mk_seq_contains"
    z3_mk_seq_contains :: Ptr Z3_context -> Ptr Z3_ast -> Ptr Z3_ast -> IO (Ptr Z3_ast)

foreign import ccall unsafe "Z3_mk_str_lt"
    z3_mk_str_lt :: Ptr Z3_context -> Ptr Z3_ast -> Ptr Z3_ast -> IO (Ptr Z3_ast)

foreign import ccall unsafe "Z3_mk_str_le"
    z3_mk_str_le :: Ptr Z3_context -> Ptr Z3_ast -> Ptr Z3_ast -> IO (Ptr Z3_ast)

foreign import ccall unsafe "Z3_mk_seq_extract"
    z3_mk_seq_extract :: Ptr Z3_context -> Ptr Z3_ast -> Ptr Z3_ast -> Ptr Z3_ast -> IO (Ptr Z3_ast)

foreign import ccall unsafe "Z3_mk_seq_replace"
    z3_mk_seq_replace :: Ptr Z3_context -> Ptr Z3_ast -> Ptr Z3_ast -> Ptr Z3_ast -> IO (Ptr Z3_ast)

foreign import ccall unsafe "Z3_mk_seq_at"
    z3_mk_seq_at :: Ptr Z3_context -> Ptr Z3_ast -> Ptr Z3_ast -> IO (Ptr Z3_ast)

foreign import ccall unsafe "Z3_mk_seq_nth"
    z3_mk_seq_nth :: Ptr Z3_context -> Ptr Z3_ast -> Ptr Z3_ast -> IO (Ptr Z3_ast)

foreign import ccall unsafe "Z3_mk_seq_length"
    z3_mk_seq_length :: Ptr Z3_context -> Ptr Z3_ast -> IO (Ptr Z3_ast)

foreign import ccall unsafe "Z3_mk_seq_index"
    z3_mk_seq_index :: Ptr Z3_context -> Ptr Z3_ast -> Ptr Z3_ast -> Ptr Z3_ast -> IO (Ptr Z3_ast)

foreign import ccall unsafe "Z3_mk_seq_last_index"
    z3_mk_seq_last_index :: Ptr Z3_context -> Ptr Z3_ast -> Ptr Z3_ast -> Ptr Z3_ast -> IO (Ptr Z3_ast)

foreign import ccall unsafe "Z3_mk_str_to_int"
    z3_mk_str_to_int :: Ptr Z3_context -> Ptr Z3_ast -> IO (Ptr Z3_ast)

foreign import ccall unsafe "Z3_mk_int_to_str"
    z3_mk_int_to_str :: Ptr Z3_context -> Ptr Z3_ast -> IO (Ptr Z3_ast)

foreign import ccall unsafe "Z3_mk_seq_to_re"
    z3_mk_seq_to_re :: Ptr Z3_context -> Ptr Z3_ast -> IO (Ptr Z3_ast)

foreign import ccall unsafe "Z3_mk_seq_in_re"
    z3_mk_seq_in_re :: Ptr Z3_context -> Ptr Z3_ast -> Ptr Z3_ast -> IO (Ptr Z3_ast)

foreign import ccall unsafe "Z3_mk_re_plus"
    z3_mk_re_plus :: Ptr Z3_context -> Ptr Z3_ast -> IO (Ptr Z3_ast)

foreign import ccall unsafe "Z3_mk_re_star"
    z3_mk_re_star :: Ptr Z3_context -> Ptr Z3_ast -> IO (Ptr Z3_ast)

foreign import ccall unsafe "Z3_mk_re_option"
    z3_mk_re_option :: Ptr Z3_context -> Ptr Z3_ast -> IO (Ptr Z3_ast)

foreign import ccall unsafe "Z3_mk_re_union"
    z3_mk_re_union :: Ptr Z3_context -> CUInt -> Ptr (Ptr Z3_ast) -> IO (Ptr Z3_ast)

foreign import ccall unsafe "Z3_mk_re_concat"
    z3_mk_re_concat :: Ptr Z3_context -> CUInt -> Ptr (Ptr Z3_ast) -> IO (Ptr Z3_ast)

foreign import ccall unsafe "Z3_mk_re_range"
    z3_mk_re_range :: Ptr Z3_context -> Ptr Z3_ast -> Ptr Z3_ast -> IO (Ptr Z3_ast)

foreign import ccall unsafe "Z3_mk_re_loop"
    z3_mk_re_loop :: Ptr Z3_context -> Ptr Z3_ast -> CUInt -> CUInt -> IO (Ptr Z3_ast)

foreign import ccall unsafe "Z3_mk_re_intersect"
    z3_mk_re_intersect :: Ptr Z3_context -> CUInt -> Ptr (Ptr Z3_ast) -> IO (Ptr Z3_ast)

foreign import ccall unsafe "Z3_mk_re_complement"
    z3_mk_re_complement :: Ptr Z3_context -> Ptr Z3_ast -> IO (Ptr Z3_ast)

foreign import ccall unsafe "Z3_mk_re_empty"
    z3_mk_re_empty :: Ptr Z3_context -> Ptr Z3_sort -> IO (Ptr Z3_ast)

foreign import ccall unsafe "Z3_mk_re_full"
    z3_mk_re_full :: Ptr Z3_context -> Ptr Z3_sort -> IO (Ptr Z3_ast)


---------------------------------------------------------------------
-- * Special relations

foreign import ccall unsafe "Z3_mk_linear_order"
    z3_mk_linear_order :: Ptr Z3_context -> Ptr Z3_sort -> CUInt -> IO (Ptr Z3_func_decl)

foreign import ccall unsafe "Z3_mk_partial_order"
    z3_mk_partial_order :: Ptr Z3_context -> Ptr Z3_sort -> CUInt -> IO (Ptr Z3_func_decl)

foreign import ccall unsafe "Z3_mk_piecewise_linear_order"
    z3_mk_piecewise_linear_order :: Ptr Z3_context -> Ptr Z3_sort -> CUInt -> IO (Ptr Z3_func_decl)

foreign import ccall unsafe "Z3_mk_tree_order"
    z3_mk_tree_order :: Ptr Z3_context -> Ptr Z3_sort -> CUInt -> IO (Ptr Z3_func_decl)

foreign import ccall unsafe "Z3_mk_transitive_closure"
    z3_mk_transitive_closure :: Ptr Z3_context -> Ptr Z3_func_decl -> IO (Ptr Z3_func_decl)

---------------------------------------------------------------------
-- * Quantifiers

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#gaf15c95b66dc3b0af735774ee401a6f85>
foreign import ccall unsafe "Z3_mk_pattern"
  z3_mk_pattern :: Ptr Z3_context -> CUInt -> Ptr (Ptr Z3_ast) -> IO (Ptr Z3_pattern)

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#ga1d4da8849fca699b345322f8ee1fa31e>
foreign import ccall unsafe "Z3_mk_bound"
  z3_mk_bound :: Ptr Z3_context -> CUInt -> Ptr Z3_sort -> IO (Ptr Z3_ast)

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#ga7e975b7d7ac96de1db73d8f71166c663>
foreign import ccall unsafe "Z3_mk_forall"
  z3_mk_forall :: Ptr Z3_context -> CUInt
                  -> CUInt -> Ptr (Ptr Z3_pattern)
                  -> CUInt -> Ptr (Ptr Z3_sort) -> Ptr (Ptr Z3_symbol)
                  -> Ptr Z3_ast
                  -> IO (Ptr Z3_ast)

-- | Referece: <http://z3prover.github.io/api/html/group__capi.html#ga4ffce34ff9117e6243283f11d87c1407>
foreign import ccall unsafe "Z3_mk_exists"
  z3_mk_exists :: Ptr Z3_context -> CUInt
                  -> CUInt -> Ptr (Ptr Z3_pattern)
                  -> CUInt -> Ptr (Ptr Z3_sort) -> Ptr (Ptr Z3_symbol)
                  -> Ptr Z3_ast
                  -> IO (Ptr Z3_ast)

foreign import ccall unsafe "Z3_mk_quantifier"
    z3_mk_quantifier :: Ptr Z3_context
                     -> Z3_bool
                     -> CUInt
                     -> CUInt
                     -> Ptr (Ptr Z3_pattern)
                     -> CUInt
                     -> Ptr (Ptr Z3_sort)
                     -> Ptr (Ptr Z3_symbol)
                     -> Ptr Z3_ast
                     -> IO (Ptr Z3_ast)

foreign import ccall unsafe "Z3_mk_quantifier_ex"
    z3_mk_quantifier_ex :: Ptr Z3_context
                        -> Z3_bool
                        -> CUInt
                        -> Ptr Z3_symbol
                        -> Ptr Z3_symbol
                        -> CUInt
                        -> Ptr (Ptr Z3_pattern)
                        -> CUInt
                        -> Ptr (Ptr Z3_pattern)
                        -> CUInt
                        -> Ptr (Ptr Z3_sort)
                        -> Ptr (Ptr Z3_symbol)
                        -> Ptr Z3_ast
                        -> IO (Ptr Z3_ast)

-- | Reference <http://z3prover.github.io/api/html/group__capi.html#gabdb40b3ac220bce5a3801e6d29fb3bb6>
foreign import ccall unsafe "Z3_mk_forall_const"
  z3_mk_forall_const :: Ptr Z3_context
                     -> CUInt
                     -> CUInt
                     -> Ptr (Ptr Z3_app)
                     -> CUInt
                     -> Ptr (Ptr Z3_pattern)
                     -> Ptr Z3_ast
                     -> IO (Ptr Z3_ast)

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#ga2011bea0f4445d58ec4d7cefe4499ceb>
foreign import ccall unsafe "Z3_mk_exists_const"
  z3_mk_exists_const :: Ptr Z3_context
                     -> CUInt
                     -> CUInt
                     -> Ptr (Ptr Z3_app)
                     -> CUInt
                     -> Ptr (Ptr Z3_pattern)
                     -> Ptr Z3_ast
                     -> IO (Ptr Z3_ast)

foreign import ccall unsafe "Z3_mk_quantifier_const"
    z3_mk_quantifier_const :: Ptr Z3_context
                           -> Z3_bool
                           -> CUInt
                           -> CUInt
                           -> Ptr (Ptr Z3_app)
                           -> CUInt
                           -> Ptr (Ptr Z3_pattern)
                           -> Ptr Z3_ast
                           -> IO (Ptr Z3_ast)

foreign import ccall unsafe "Z3_mk_quantifier_const_ex"
    z3_mk_quantifier_const_ex :: Ptr Z3_context
                              -> Z3_bool
                              -> CUInt
                              -> Ptr Z3_symbol
                              -> Ptr Z3_symbol
                              -> CUInt
                              -> Ptr (Ptr Z3_app)
                              -> CUInt
                              -> Ptr (Ptr Z3_pattern)
                              -> CUInt
                              -> Ptr (Ptr Z3_pattern)
                              -> Ptr Z3_ast
                              -> IO (Ptr Z3_ast)

foreign import ccall unsafe "Z3_mk_lambda"
    z3_mk_lambda :: Ptr Z3_context
                 -> CUInt
                 -> Ptr (Ptr Z3_sort)
                 -> Ptr (Ptr Z3_symbol)
                 -> Ptr Z3_ast
                 -> IO (Ptr Z3_ast)

foreign import ccall unsafe "Z3_mk_lambda_const"
    z3_mk_lambda_const :: Ptr Z3_context
                       -> CUInt
                       -> Ptr (Ptr Z3_app)
                       -> Ptr Z3_ast
                       -> IO (Ptr Z3_ast)

---------------------------------------------------------------------
-- * Accessors

foreign import ccall unsafe "Z3_get_symbol_kind"
    z3_get_symbol_kind :: Ptr Z3_context
                       -> Ptr Z3_symbol
                       -> IO (Ptr Z3_symbol_kind)

foreign import ccall unsafe "Z3_get_symbol_int"
    z3_get_symbol_int :: Ptr Z3_context
                       -> Ptr Z3_symbol
                       -> IO (CInt)

-- Reference: <http://z3prover.github.io/api/html/group__capi.html#gaf1683d9464f377e5089ce6ebf2a9bd31>
foreign import ccall unsafe "Z3_get_symbol_string"
    z3_get_symbol_string :: Ptr Z3_context -> Ptr Z3_symbol -> IO Z3_string

-- Reference: <https://z3prover.github.io/api/html/group__capi.html#gab66884f00730c61cf3a5e6814aa2ebd0>
foreign import ccall unsafe "Z3_get_sort_name"
    z3_get_sort_name :: Ptr Z3_context -> Ptr Z3_sort -> IO (Ptr Z3_symbol)

-- Reference: <https://z3prover.github.io/api/html/group__capi.html#gacc77e9b5ce5ada28c5af4ddb67d6702a>
foreign import ccall unsafe "Z3_get_sort_id"
    z3_get_sort_id :: Ptr Z3_context -> Ptr Z3_sort -> IO CUInt

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#ga57c27f2c4e9eccf17072a84c6cecb1db>
foreign import ccall unsafe "Z3_sort_to_ast"
    z3_sort_to_ast :: Ptr Z3_context -> Ptr Z3_sort -> IO (Ptr Z3_ast)

-- | Reference: <https://z3prover.github.io/api/html/group__capi.html#gaf260f3b5bc786cd0552e1ed4f8232a4b>
foreign import ccall unsafe "Z3_is_eq_sort"
    z3_is_eq_sort :: Ptr Z3_context -> Ptr Z3_sort -> Ptr Z3_sort -> IO (Z3_bool)

-- Reference: <http://z3prover.github.io/api/html/group__capi.html#gacd85d48842c7bfaa696596d16875681a>
foreign import ccall unsafe "Z3_get_sort_kind"
    z3_get_sort_kind :: Ptr Z3_context -> Ptr Z3_sort -> IO Z3_sort_kind

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#ga8fc3550edace7bc046e16d1f96ddb419>
foreign import ccall unsafe "Z3_get_bv_sort_size"
    z3_get_bv_sort_size :: Ptr Z3_context -> Ptr Z3_sort -> IO CUInt

foreign import ccall unsafe "Z3_get_finite_domain_sort_size"
    z3_get_finite_domain_sort_size :: Ptr Z3_context -> Ptr Z3_sort -> Ptr CULLong -> IO Z3_bool

-- | Reference: <https://z3prover.github.io/api/html/group__capi.html#ga6ffa46d55e4632d761db4dfae7441c09>
foreign import ccall unsafe "Z3_get_array_sort_domain"
    z3_get_array_sort_domain :: Ptr Z3_context -> Ptr Z3_sort -> IO (Ptr Z3_sort)

-- | Reference: <https://z3prover.github.io/api/html/group__capi.html#gaa6f84f1b2b178f6fe5bc3b9a5762a73b>
foreign import ccall unsafe "Z3_get_array_sort_range"
    z3_get_array_sort_range :: Ptr Z3_context -> Ptr Z3_sort -> IO (Ptr Z3_sort)

foreign import ccall unsafe "Z3_get_tuple_sort_mk_decl"
    z3_get_tuple_sort_mk_decl :: Ptr Z3_context -> Ptr Z3_sort -> IO (Ptr Z3_func_decl)

foreign import ccall unsafe "Z3_get_tuple_sort_num_fields"
    z3_get_tuple_sort_num_fields :: Ptr Z3_context -> Ptr Z3_sort -> IO CUInt

foreign import ccall unsafe "Z3_get_tuple_sort_field_decl"
    z3_get_tuple_sort_field_decl :: Ptr Z3_context -> Ptr Z3_sort -> CUInt -> IO (Ptr Z3_func_decl)

-- Reference: <http://z3prover.github.io/api/html/group__capi.html#gae9ab82612fd84f5ce7991ade7d7ad920>
foreign import ccall unsafe "Z3_get_datatype_sort_num_constructors"
    z3_get_datatype_sort_num_constructors :: Ptr Z3_context -> Ptr Z3_sort -> IO CUInt

-- Reference: <http://z3prover.github.io/api/html/group__capi.html#gaa5630cbd0f28d2bda21dc5376fe86a9b>
foreign import ccall unsafe "Z3_get_datatype_sort_constructor"
    z3_get_datatype_sort_constructor :: Ptr Z3_context -> Ptr Z3_sort -> CUInt -> IO (Ptr Z3_func_decl)

-- Reference: <http://z3prover.github.io/api/html/group__capi.html#gacf79f46d05b3ed69684d47eaf242319c>
foreign import ccall unsafe "Z3_get_datatype_sort_recognizer"
    z3_get_datatype_sort_recognizer :: Ptr Z3_context -> Ptr Z3_sort -> CUInt -> IO (Ptr Z3_func_decl)

-- Reference: <http://z3prover.github.io/api/html/group__capi.html#gab0ade72138d0479409f47cef21972eb2>
foreign import ccall unsafe "Z3_get_datatype_sort_constructor_accessor"
    z3_get_datatype_sort_constructor_accessor :: Ptr Z3_context -> Ptr Z3_sort -> CUInt -> CUInt -> IO (Ptr Z3_func_decl)

foreign import ccall unsafe "Z3_datatype_update_field"
    z3_datatype_update_field :: Ptr Z3_context -> Ptr Z3_func_decl -> Ptr Z3_ast -> Ptr Z3_ast -> IO (Ptr Z3_ast)

foreign import ccall unsafe "Z3_get_relation_arity"
    z3_get_relation_arity :: Ptr Z3_context -> Ptr Z3_sort -> IO CUInt

foreign import ccall unsafe "Z3_get_relation_column"
    z3_get_relation_column :: Ptr Z3_context -> Ptr Z3_sort -> CUInt -> IO (Ptr Z3_sort)

foreign import ccall unsafe "Z3_mk_atmost"
    z3_mk_atmost :: Ptr Z3_context -> CUInt -> Ptr (Ptr Z3_ast) -> CUInt -> IO (Ptr Z3_ast)

foreign import ccall unsafe "Z3_mk_atleast"
    z3_mk_atleast :: Ptr Z3_context -> CUInt -> Ptr (Ptr Z3_ast) -> CUInt -> IO (Ptr Z3_ast)

foreign import ccall unsafe "Z3_mk_pble"
    z3_mk_pble :: Ptr Z3_context -> CUInt -> Ptr Z3_ast_vector -> Ptr CInt -> CInt -> IO (Ptr Z3_ast)

foreign import ccall unsafe "Z3_mk_pbge"
    z3_mk_pbge :: Ptr Z3_context -> CUInt -> Ptr Z3_ast_vector -> Ptr CInt -> CInt -> IO (Ptr Z3_ast)

foreign import ccall unsafe "Z3_mk_pbeq"
    z3_mk_pbeq :: Ptr Z3_context -> CUInt -> Ptr Z3_ast_vector -> Ptr CInt -> CInt -> IO (Ptr Z3_ast)

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#gadc82da786f3b558de8ded05bf6478902>
foreign import ccall unsafe "Z3_func_decl_to_ast"
    z3_func_decl_to_ast :: Ptr Z3_context -> Ptr Z3_func_decl -> IO (Ptr Z3_ast)

foreign import ccall unsafe "Z3_is_eq_func_decl"
    z3_is_eq_func_decl :: Ptr Z3_context -> Ptr Z3_func_decl -> Ptr Z3_func_decl -> IO Z3_bool

foreign import ccall unsafe "Z3_get_func_decl_id"
    z3_get_func_decl_id :: Ptr Z3_context -> Ptr Z3_func_decl -> IO CUInt

-- Reference: <http://z3prover.github.io/api/html/group__capi.html#ga741b1bf11cb92aa2ec9ef2fef73ff129>
foreign import ccall unsafe "Z3_get_decl_name"
    z3_get_decl_name :: Ptr Z3_context -> Ptr Z3_func_decl -> IO (Ptr Z3_symbol)

foreign import ccall unsafe "Z3_get_decl_kind"
    z3_get_decl_kind :: Ptr Z3_context -> Ptr Z3_func_decl -> IO (Ptr Z3_decl_kind)

foreign import ccall unsafe "Z3_get_domain_size"
    z3_get_domain_size :: Ptr Z3_context -> Ptr Z3_func_decl -> IO CUInt

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#ga203f32e3b904955f703f61f91a8626a4>
foreign import ccall unsafe "Z3_get_arity"
    z3_get_arity :: Ptr Z3_context -> Ptr Z3_func_decl -> IO CUInt

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#gad025402a9cac1a8d8facddba3f8cbddc>
foreign import ccall unsafe "Z3_get_domain"
    z3_get_domain :: Ptr Z3_context -> Ptr Z3_func_decl -> CUInt -> IO (Ptr Z3_sort)

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#ga913ecf28cd4bddc8255f77f80b6aafe9>
foreign import ccall unsafe "Z3_get_range"
    z3_get_range :: Ptr Z3_context -> Ptr Z3_func_decl -> IO (Ptr Z3_sort)

foreign import ccall unsafe "Z3_get_decl_num_parameters"
    z3_get_decl_num_parameters :: Ptr Z3_context -> Ptr Z3_func_decl -> IO CUInt

foreign import ccall unsafe "Z3_get_decl_parameter_kind"
    z3_get_decl_parameter_kind :: Ptr Z3_context -> Ptr Z3_func_decl -> CUInt -> IO (Ptr Z3_param_kind)

foreign import ccall unsafe "Z3_get_decl_int_parameter"
    z3_get_decl_int_parameter :: Ptr Z3_context -> Ptr Z3_func_decl -> CUInt -> IO CInt

foreign import ccall unsafe "Z3_get_decl_double_parameter"
    z3_get_decl_double_parameter :: Ptr Z3_context -> Ptr Z3_func_decl -> CUInt -> IO CDouble

foreign import ccall unsafe "Z3_get_decl_symbol_parameter"
    z3_get_decl_symbol_parameter :: Ptr Z3_context -> Ptr Z3_func_decl -> CUInt -> IO (Ptr Z3_symbol)

foreign import ccall unsafe "Z3_get_decl_sort_parameter"
    z3_get_decl_sort_parameter :: Ptr Z3_context -> Ptr Z3_func_decl -> CUInt -> IO (Ptr Z3_sort)

foreign import ccall unsafe "Z3_get_decl_ast_parameter"
    z3_get_decl_ast_parameter :: Ptr Z3_context -> Ptr Z3_func_decl -> CUInt -> IO (Ptr Z3_ast)

foreign import ccall unsafe "Z3_get_decl_func_decl_parameter"
    z3_get_decl_func_decl_parameter :: Ptr Z3_context -> Ptr Z3_func_decl -> CUInt -> IO (Ptr Z3_func_decl)

foreign import ccall unsafe "Z3_get_decl_rational_parameter"
    z3_get_decl_rational_parameter :: Ptr Z3_context -> Ptr Z3_func_decl -> CUInt -> IO Z3_string

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#gae259256eb0f2c10e48fc6227760b7fda>
foreign import ccall unsafe "Z3_app_to_ast"
    z3_app_to_ast :: Ptr Z3_context -> Ptr Z3_app -> IO (Ptr Z3_ast)

-- Reference: <http://z3prover.github.io/api/html/group__capi.html#ga4ffab51c30484a32edc65194573cfd28>
foreign import ccall unsafe "Z3_get_app_decl"
    z3_get_app_decl :: Ptr Z3_context -> Ptr Z3_app -> IO (Ptr Z3_func_decl)

-- Reference: <http://z3prover.github.io/api/html/group__capi.html#gae8ad520b79b46c323863bacffa0e12c0>
foreign import ccall unsafe "Z3_get_app_num_args"
    z3_get_app_num_args :: Ptr Z3_context -> Ptr Z3_app -> IO CUInt

-- Reference: <http://z3prover.github.io/api/html/group__capi.html#ga49a576b11f9f6ca4a94670e538a84c6b>
foreign import ccall unsafe "Z3_get_app_arg"
    z3_get_app_arg :: Ptr Z3_context -> Ptr Z3_app -> CUInt -> IO (Ptr Z3_ast)

-- | Reference: <https://z3prover.github.io/api/html/group__capi.html#gabc6d17e7862f2db40c778409152e931f>
foreign import ccall unsafe "Z3_is_eq_ast"
    z3_is_eq_ast :: Ptr Z3_context
                 -> Ptr Z3_ast
                 -> Ptr Z3_ast
                 -> IO Z3_bool

foreign import ccall unsafe "Z3_get_ast_id"
    z3_get_ast_id :: Ptr Z3_context
                 -> Ptr Z3_ast
                 -> IO CUInt

foreign import ccall unsafe "Z3_get_ast_hash"
    z3_get_ast_hash :: Ptr Z3_context
                    -> Ptr Z3_ast
                    -> IO CUInt

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#ga0a4dac7e9397ff067136354cd33cb933>
foreign import ccall unsafe "Z3_get_sort"
    z3_get_sort :: Ptr Z3_context -> Ptr Z3_ast -> IO (Ptr Z3_sort)

foreign import ccall unsafe "Z3_is_well_sorted"
    z3_is_well_sorted :: Ptr Z3_context -> Ptr Z3_ast -> IO (Z3_bool)

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#ga133aaa1ec31af9b570ed7627a3c8c5a4>
foreign import ccall unsafe "Z3_get_bool_value"
    z3_get_bool_value :: Ptr Z3_context -> Ptr Z3_ast -> IO Z3_lbool

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#ga4c43608feea4cae363ef9c520c239a5c>
foreign import ccall unsafe "Z3_get_ast_kind"
    z3_get_ast_kind :: Ptr Z3_context -> Ptr Z3_ast -> IO Z3_ast_kind

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#ga87a4f9add28db792a24476a1082b4fe4>
foreign import ccall unsafe "Z3_is_app"
    z3_is_app :: Ptr Z3_context -> Ptr Z3_ast -> IO Z3_bool

foreign import ccall unsafe "Z3_is_numeral_ast"
    z3_is_numeral_ast :: Ptr Z3_context -> Ptr Z3_ast -> IO Z3_bool

foreign import ccall unsafe "Z3_is_algebraic_number"
    z3_is_algebraic_number :: Ptr Z3_context -> Ptr Z3_ast -> IO Z3_bool

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#gaf9345fd0822d7e9928dd4ab14a09765b>
foreign import ccall unsafe "Z3_to_app"
  z3_to_app :: Ptr Z3_context -> Ptr Z3_ast -> IO (Ptr Z3_app)

foreign import ccall unsafe "Z3_to_func_decl"
  z3_to_func_decl :: Ptr Z3_context -> Ptr Z3_ast -> IO (Ptr Z3_func_decl)

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#ga94617ef18fa7157e1a3f85db625d2f4b>
foreign import ccall unsafe "Z3_get_numeral_string"
    z3_get_numeral_string :: Ptr Z3_context -> Ptr Z3_ast -> IO Z3_string

-- foreign import ccall unsafe "Z3_get_numeral_binary_string"
--   z3_get_numeral_binary_string :: Ptr Z3_context -> Ptr Z3_ast -> IO Z3_string

foreign import ccall unsafe "Z3_get_numeral_decimal_string"
  z3_get_numeral_decimal_string :: Ptr Z3_context -> Ptr Z3_ast -> IO Z3_string

foreign import ccall unsafe "Z3_get_numeral_double"
  z3_get_numeral_double :: Ptr Z3_context -> Ptr Z3_ast -> IO CDouble

-- | Reference: <https://z3prover.github.io/api/html/group__capi.html#ga2d37084eb47ea0ab19638a3407ce610b>
foreign import ccall unsafe "Z3_get_numerator"
  z3_get_numerator :: Ptr Z3_context -> Ptr Z3_ast -> IO (Ptr Z3_ast)

-- | Reference: <https://z3prover.github.io/api/html/group__capi.html#ga07549939888e8fdfc8e0fde1776c31a7>
foreign import ccall unsafe "Z3_get_denominator"
  z3_get_denominator :: Ptr Z3_context -> Ptr Z3_ast -> IO (Ptr Z3_ast)

foreign import ccall unsafe "Z3_get_numeral_small"
  z3_get_numeral_small :: Ptr Z3_context -> Ptr Z3_ast -> Ptr CLong -> Ptr CLong -> IO Z3_bool

foreign import ccall unsafe "Z3_get_numeral_int"
  z3_get_numeral_int :: Ptr Z3_context -> Ptr Z3_ast -> Ptr CInt -> IO Z3_bool

foreign import ccall unsafe "Z3_get_numeral_uint"
  z3_get_numeral_uint :: Ptr Z3_context -> Ptr Z3_ast -> Ptr CUInt -> IO Z3_bool

foreign import ccall unsafe "Z3_get_numeral_uint64"
  z3_get_numeral_uint64 :: Ptr Z3_context -> Ptr Z3_ast -> Ptr CULong -> IO Z3_bool

foreign import ccall unsafe "Z3_get_numeral_int64"
  z3_get_numeral_int64 :: Ptr Z3_context -> Ptr Z3_ast -> Ptr CLong -> IO Z3_bool

foreign import ccall unsafe "Z3_get_numeral_rational_int64"
  z3_get_numeral_rational_int64 :: Ptr Z3_context -> Ptr Z3_ast -> Ptr CLong -> Ptr CLong -> IO Z3_bool

foreign import ccall unsafe "Z3_get_algebraic_number_lower"
  z3_get_algebraic_number_lower :: Ptr Z3_context -> Ptr Z3_ast -> CUInt -> IO (Ptr Z3_ast)

foreign import ccall unsafe "Z3_get_algebraic_number_upper"
  z3_get_algebraic_number_upper :: Ptr Z3_context -> Ptr Z3_ast -> CUInt -> IO (Ptr Z3_ast)

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#gafe4334258b639fa1f8754375b9b56fd7>
foreign import ccall unsafe "Z3_pattern_to_ast"
  z3_pattern_to_ast :: Ptr Z3_context -> Ptr Z3_pattern -> IO (Ptr Z3_ast)

foreign import ccall unsafe "Z3_get_pattern_num_terms"
  z3_get_pattern_num_terms :: Ptr Z3_context -> Ptr Z3_pattern -> IO CUInt

foreign import ccall unsafe "Z3_get_pattern"
  z3_get_pattern :: Ptr Z3_context -> Ptr Z3_pattern -> CUInt -> IO (Ptr Z3_ast)

-- | Reference: <https://z3prover.github.io/api/html/group__capi.html#gab3c5c7eadcfd209eec72ec0ac0ad2e96>
foreign import ccall unsafe "Z3_get_index_value"
    z3_get_index_value :: Ptr Z3_context -> Ptr Z3_ast -> IO CUInt

-- | Reference: <https://z3prover.github.io/api/html/group__capi.html#gac47b42af13aee024d34bb37ffaa0ad75>
foreign import ccall unsafe "Z3_is_quantifier_forall"
  z3_is_quantifier_forall :: Ptr Z3_context -> Ptr Z3_ast -> IO Z3_bool

foreign import ccall unsafe "Z3_is_quantifier_exists"
  z3_is_quantifier_exists :: Ptr Z3_context -> Ptr Z3_ast -> IO Z3_bool

foreign import ccall unsafe "Z3_is_lambda"
  z3_is_lambda :: Ptr Z3_context -> Ptr Z3_ast -> IO Z3_bool

-- | Reference: <https://z3prover.github.io/api/html/group__capi.html#gaa5820368b5ae944bd17f10c2f8247c11>
foreign import ccall unsafe "Z3_get_quantifier_weight"
  z3_get_quantifier_weight :: Ptr Z3_context -> Ptr Z3_ast -> IO CUInt

-- | Reference: <https://z3prover.github.io/api/html/group__capi.html#ga3e5cb3bd6e9b9de0d6e6a6e80eb36bba>
foreign import ccall unsafe "Z3_get_quantifier_num_patterns"
  z3_get_quantifier_num_patterns :: Ptr Z3_context -> Ptr Z3_ast -> IO CUInt

-- | Reference: <https://z3prover.github.io/api/html/group__capi.html#gad48dd00ca5ebce768c66dca447f50037>
foreign import ccall unsafe "Z3_get_quantifier_pattern_ast"
  z3_get_quantifier_pattern_ast :: Ptr Z3_context -> Ptr Z3_ast -> CUInt -> IO (Ptr Z3_ast)

-- | Reference: <https://z3prover.github.io/api/html/group__capi.html#ga6b2c35b148f0bb05e9ebf8ab17c2b16e>
foreign import ccall unsafe "Z3_get_quantifier_num_no_patterns"
  z3_get_quantifier_num_no_patterns :: Ptr Z3_context -> Ptr Z3_ast -> IO CUInt

-- | Reference: <https://z3prover.github.io/api/html/group__capi.html#ga7b68758cbe05352eca541e4028f9a8d8>
foreign import ccall unsafe "Z3_get_quantifier_no_pattern_ast"
  z3_get_quantifier_no_pattern_ast :: Ptr Z3_context -> Ptr Z3_ast -> CUInt -> IO (Ptr Z3_ast)

-- | Reference: <https://z3prover.github.io/api/html/group__capi.html#gac85bd38ea5c41ec9e0e956a8a1734a7d>
foreign import ccall unsafe "Z3_get_quantifier_num_bound"
  z3_get_quantifier_num_bound :: Ptr Z3_context -> Ptr Z3_ast -> IO CUInt

-- | Reference: <https://z3prover.github.io/api/html/group__capi.html#ga3e6914c9186de8e588da66af78aa271f>
foreign import ccall unsafe "Z3_get_quantifier_bound_name"
  z3_get_quantifier_bound_name :: Ptr Z3_context -> Ptr Z3_ast -> CUInt -> IO (Ptr Z3_symbol)

-- | Reference: <https://z3prover.github.io/api/html/group__capi.html#gae9a7280ad96d05c8266aad869efb9b25>
foreign import ccall unsafe "Z3_get_quantifier_bound_sort"
  z3_get_quantifier_bound_sort :: Ptr Z3_context -> Ptr Z3_ast -> CUInt -> IO (Ptr Z3_sort)

-- | Reference: <https://z3prover.github.io/api/html/group__capi.html#ga94b1bdd4d3351afc860f6cbd2a2ada9f>
foreign import ccall unsafe "Z3_get_quantifier_body"
  z3_get_quantifier_body :: Ptr Z3_context -> Ptr Z3_ast -> IO (Ptr Z3_ast)

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#gada433553406475e5dd6a494ea957844c>
foreign import ccall unsafe "Z3_simplify"
  z3_simplify :: Ptr Z3_context -> Ptr Z3_ast -> IO (Ptr Z3_ast)

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#ga34329d4c83ca8c98e18b2884b679008c>
foreign import ccall unsafe "Z3_simplify_ex"
  z3_simplify_ex :: Ptr Z3_context -> Ptr Z3_ast -> Ptr Z3_params -> IO (Ptr Z3_ast)

foreign import ccall unsafe "Z3_simplify_get_help"
  z3_simplify_get_help :: Ptr Z3_context -> IO Z3_string

foreign import ccall unsafe "Z3_simplify_get_param_descrs"
  z3_simplify_get_param_descrs :: Ptr Z3_context -> IO (Ptr Z3_param_descrs)

---------------------------------------------------------------------
-- * Modifiers

foreign import ccall unsafe "Z3_update_term"
  z3_update_term :: Ptr Z3_context -> IO (Ptr Z3_ast_vector)

-- | Reference: <https://z3prover.github.io/api/html/group__capi.html#gad6e8afe205259b3d924f460d22665e90>
foreign import ccall unsafe "Z3_substitute_vars"
    z3_substitute_vars :: Ptr Z3_context -> Ptr Z3_ast -> CUInt -> Ptr (Ptr Z3_ast) -> IO (Ptr Z3_ast)

-- | Reference: <https://z3prover.github.io/api/html/group__capi.html#ga0f8ba9b735388e010044b8a1d39c6af0>
foreign import ccall unsafe "Z3_substitute"
    z3_substitute :: Ptr Z3_context -> Ptr Z3_ast -> CUInt -> Ptr (Ptr Z3_ast) -> Ptr (Ptr Z3_ast) -> IO (Ptr Z3_ast)

foreign import ccall unsafe "Z3_translate"
  z3_translate :: Ptr Z3_context -> Ptr Z3_ast -> Ptr Z3_context -> IO (Ptr Z3_ast)

---------------------------------------------------------------------
-- * Models

foreign import ccall unsafe "Z3_mk_model"
  z3_mk_model :: Ptr Z3_context -> IO (Ptr Z3_model)

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#gac06a904e7ac6209d8019c606412d3cec>
foreign import ccall unsafe "Z3_model_inc_ref"
    z3_model_inc_ref :: Ptr Z3_context
                     -> Ptr Z3_model
                     -> IO ()

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#gacc2df0767d4a94d7216d3db49c41547f>
foreign import ccall unsafe "Z3_model_dec_ref"
    z3_model_dec_ref :: Ptr Z3_context
                     -> Ptr Z3_model
                     -> IO ()

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#ga86670c291a16640b932e7892176a9d1b>
foreign import ccall unsafe "Z3_model_eval"
    z3_model_eval :: Ptr Z3_context
                  -> Ptr Z3_model
                  -> Ptr Z3_ast
                  -> Z3_bool
                  -> Ptr (Ptr Z3_ast)
                  -> IO Z3_bool

-- | Reference: https://z3prover.github.io/api/html/group__capi.html#ga01bc2993f3eb358f7bd3b2d2d4cf5e51
foreign import ccall unsafe "Z3_model_get_const_interp"
    z3_model_get_const_interp :: Ptr Z3_context
                             -> Ptr Z3_model
                             -> Ptr Z3_func_decl
                             -> IO (Ptr Z3_ast)

-- | Reference: https://z3prover.github.io/api/html/group__capi.html#ga3c7f8f6ce7c9f30710d3b73fa091f6b3
foreign import ccall unsafe "Z3_model_has_interp"
    z3_model_has_interp :: Ptr Z3_context
                        -> Ptr Z3_model
                        -> Ptr Z3_func_decl
                        -> IO Z3_bool

-- | Reference: https://z3prover.github.io/api/html/group__capi.html#gaf5e9adb229e98b29cbeb7cebf41433a3
foreign import ccall unsafe "Z3_model_get_func_interp"
    z3_model_get_func_interp :: Ptr Z3_context
                             -> Ptr Z3_model
                             -> Ptr Z3_func_decl
                             -> IO (Ptr Z3_func_interp)


-- | Reference: https://z3prover.github.io/api/html/group__capi.html#ga3ff26c1c0f55d17ebf2c152a74eac743
foreign import ccall unsafe "Z3_model_get_num_consts"
    z3_model_get_num_consts :: Ptr Z3_context
                            -> Ptr Z3_model
                            -> IO CUInt

-- | Reference: https://z3prover.github.io/api/html/group__capi.html#ga8e70ac56fe6748301b7776191395184a
foreign import ccall unsafe "Z3_model_get_const_decl"
    z3_model_get_const_decl :: Ptr Z3_context
                            -> Ptr Z3_model
                            -> CUInt
                            -> IO (Ptr Z3_func_decl)

-- | Reference: https://z3prover.github.io/api/html/group__capi.html#gaab062a06c0789b432885f4813dd9633b
foreign import ccall unsafe "Z3_model_get_num_funcs"
    z3_model_get_num_funcs :: Ptr Z3_context
                           -> Ptr Z3_model
                           -> IO CUInt

-- | Reference: https://z3prover.github.io/api/html/group__capi.html#ga2a1a4524289574ae34ce2eecdade84d7
foreign import ccall unsafe "Z3_model_get_func_decl"
    z3_model_get_func_decl :: Ptr Z3_context
                           -> Ptr Z3_model
                           -> CUInt
                           -> IO (Ptr Z3_func_decl)

foreign import ccall unsafe "Z3_model_get_num_sorts"
    z3_model_get_num_sorts :: Ptr Z3_context
                           -> Ptr Z3_model
                           -> IO CUInt

foreign import ccall unsafe "Z3_model_get_sort"
    z3_model_get_sort :: Ptr Z3_context
                         -> Ptr Z3_model
                         -> CUInt
                         -> IO (Ptr Z3_sort)

foreign import ccall unsafe "Z3_model_get_sort_universe"
    z3_model_get_sort_universe :: Ptr Z3_context
                               -> Ptr Z3_model
                               -> Ptr Z3_sort
                               -> IO (Ptr Z3_ast_vector)

foreign import ccall unsafe "Z3_model_translate"
    z3_model_translate :: Ptr Z3_context
                       -> Ptr Z3_model
                       -> Ptr Z3_context
                       -> IO (Ptr Z3_model)

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#ga4674da67d226bfb16861829b9f129cfa>
foreign import ccall unsafe "Z3_is_as_array"
    z3_is_as_array :: Ptr Z3_context
                   -> Ptr Z3_ast
                   -> IO Z3_bool


-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#ga7d9262dc6e79f2aeb23fd4a383589dda>
foreign import ccall unsafe "Z3_get_as_array_func_decl"
    z3_get_as_array_func_decl :: Ptr Z3_context
                              -> Ptr Z3_ast
                              -> IO (Ptr Z3_func_decl)

-- | Reference: https://z3prover.github.io/api/html/group__capi.html#ga1f30176bce864257bebb1fb30a103779
foreign import ccall unsafe "Z3_add_func_interp"
    z3_add_func_interp :: Ptr Z3_context
                   -> Ptr Z3_model
                   -> Ptr Z3_func_decl
                   -> Ptr Z3_ast
                   -> IO (Ptr Z3_func_interp)

-- | Reference: https://z3prover.github.io/api/html/group__capi.html#ga73b1de0ec17bb4f2e47d256a7628925c
foreign import ccall unsafe "Z3_add_const_interp"
    z3_add_const_interp :: Ptr Z3_context
                   -> Ptr Z3_model
                   -> Ptr Z3_func_decl
                   -> Ptr Z3_ast
                   -> IO ()

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#ga80218e1d50bdc4dac5ba18bd13a8ddfb>
foreign import ccall unsafe "Z3_func_interp_inc_ref"
    z3_func_interp_inc_ref :: Ptr Z3_context
                           -> Ptr Z3_func_interp
                           -> IO ()

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#gabe3aefc84db4fc3ce5349e958f1ec34b>
foreign import ccall unsafe "Z3_func_interp_dec_ref"
    z3_func_interp_dec_ref :: Ptr Z3_context
                           -> Ptr Z3_func_interp
                           -> IO ()

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#ga2bab9ae1444940e7593729beec279844>
foreign import ccall unsafe "Z3_func_interp_get_num_entries"
    z3_func_interp_get_num_entries :: Ptr Z3_context
                                   -> Ptr Z3_func_interp
                                   -> IO CUInt

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#gaf157e1e1cd8c0cfe6a21be6370f659da>
foreign import ccall unsafe "Z3_func_interp_get_entry"
    z3_func_interp_get_entry :: Ptr Z3_context
                             -> Ptr Z3_func_interp
                             -> CUInt
                             -> IO (Ptr Z3_func_entry)

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#ga46de7559826ba71b8488d727cba1fb64>
foreign import ccall unsafe "Z3_func_interp_get_else"
    z3_func_interp_get_else :: Ptr Z3_context
                            -> Ptr Z3_func_interp
                            -> IO (Ptr Z3_ast)

foreign import ccall unsafe "Z3_func_interp_set_else"
    z3_func_interp_set_else :: Ptr Z3_context
                            -> Ptr Z3_func_interp
                            -> Ptr Z3_ast
                            -> IO ()

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#gaca22cbdb6f7787aaae5d814f2ab383d8>
foreign import ccall unsafe "Z3_func_interp_get_arity"
    z3_func_interp_get_arity :: Ptr Z3_context
                             -> Ptr Z3_func_interp
                             -> IO CUInt

foreign import ccall unsafe "Z3_func_interp_add_entry"
    z3_func_interp_add_entry :: Ptr Z3_context
                             -> Ptr Z3_func_interp
                             -> Ptr Z3_ast_vector
                             -> Ptr Z3_ast
                             -> IO ()

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#ga82cd36e7b02c432436950d5c2301245e>
foreign import ccall unsafe "Z3_func_entry_inc_ref"
    z3_func_entry_inc_ref :: Ptr Z3_context
                            -> Ptr Z3_func_entry
                            -> IO ()

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#ga9a9a2a75d7fc3d842839662e53365903>
foreign import ccall unsafe "Z3_func_entry_dec_ref"
    z3_func_entry_dec_ref :: Ptr Z3_context
                            -> Ptr Z3_func_entry
                            -> IO ()

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#ga9fd65e2ab039aa8e40608c2ecf7084da>
foreign import ccall unsafe "Z3_func_entry_get_value"
    z3_func_entry_get_value :: Ptr Z3_context
                            -> Ptr Z3_func_entry
                            -> IO (Ptr Z3_ast)

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#ga51aed8c5bc4b1f53f0c371312de3ce1a>
foreign import ccall unsafe "Z3_func_entry_get_num_args"
    z3_func_entry_get_num_args :: Ptr Z3_context
                               -> Ptr Z3_func_entry
                               -> IO CUInt

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#ga6fe03fe3c824fceb52766a4d8c2cbeab>
foreign import ccall unsafe "Z3_func_entry_get_arg"
    z3_func_entry_get_arg :: Ptr Z3_context
                          -> Ptr Z3_func_entry
                          -> CUInt
                          -> IO (Ptr Z3_ast)

---------------------------------------------------------------------
-- * Interaction logging

foreign import ccall unsafe "Z3_open_log"
    z3_open_log :: Z3_string -> IO Z3_bool

foreign import ccall unsafe "Z3_append_log"
    z3_append_log :: Z3_string -> IO Z3_bool

foreign import ccall unsafe "Z3_close_log"
    z3_close_log :: IO ()

foreign import ccall unsafe "Z3_toggle_warning_messages"
    z3_toggle_warning_messages :: Z3_bool -> IO ()

---------------------------------------------------------------------
-- * String Conversion

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#ga20d66dac19b6d6a06537843d0e25f761>
foreign import ccall unsafe "Z3_set_ast_print_mode"
    z3_set_ast_print_mode :: Ptr Z3_context -> Z3_ast_print_mode -> IO ()

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#gab1aa4b78298fe00b3167bf7bfd88aea3>
foreign import ccall unsafe "Z3_ast_to_string"
    z3_ast_to_string :: Ptr Z3_context -> Ptr Z3_ast -> IO Z3_string

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#ga51b048ddbbcd88708e7aa4fe1c2462d6>
foreign import ccall unsafe "Z3_pattern_to_string"
    z3_pattern_to_string :: Ptr Z3_context -> Ptr Z3_pattern -> IO Z3_string

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#gaf90c72f63eab298e1dd750f6a26fb945>
foreign import ccall unsafe "Z3_sort_to_string"
    z3_sort_to_string :: Ptr Z3_context -> Ptr Z3_sort -> IO Z3_string

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#ga15243dcad77f5571e28e8aa1da465675>
foreign import ccall unsafe "Z3_func_decl_to_string"
    z3_func_decl_to_string :: Ptr Z3_context -> Ptr Z3_func_decl -> IO Z3_string

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#gaf36d49862a8c0d20dd5e6508eef5f8af>
foreign import ccall unsafe "Z3_model_to_string"
    z3_model_to_string :: Ptr Z3_context -> Ptr Z3_model -> IO Z3_string

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#gaf93844a5964ad8dee609fac3470d86e4>
foreign import ccall unsafe "Z3_benchmark_to_smtlib_string"
    z3_benchmark_to_smtlib_string :: Ptr Z3_context
                                      -> Z3_string        -- ^ name
                                      -> Z3_string        -- ^ logic
                                      -> Z3_string        -- ^ status
                                      -> Z3_string        -- ^ attributes
                                      -> CUInt            -- ^ assumptions#
                                      -> Ptr (Ptr Z3_ast) -- ^ assumptions
                                      -> Ptr Z3_ast       -- ^ formula
                                      -> IO Z3_string

---------------------------------------------------------------------
-- * Parser Interface

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#ga74e6e5107c4143be3929e80bdaf73d6d>
foreign import ccall unsafe "Z3_parse_smtlib2_string"
  z3_parse_smtlib2_string :: Ptr Z3_context
                          -> Z3_string
                          -> CUInt
                          -> Ptr (Ptr Z3_symbol)
                          -> Ptr (Ptr Z3_sort)
                          -> CUInt
                          -> Ptr (Ptr Z3_symbol)
                          -> Ptr (Ptr Z3_func_decl)
                          -> IO (Ptr Z3_ast_vector)

-- | Referece <http://z3prover.github.io/api/html/group__capi.html#ga6168be4babb03fbbccff1fa7df451300>
foreign import ccall unsafe "Z3_parse_smtlib2_file"
  z3_parse_smtlib2_file :: Ptr Z3_context
                        -> Z3_string
                        -> CUInt
                        -> Ptr (Ptr Z3_symbol)
                        -> Ptr (Ptr Z3_sort)
                        -> CUInt
                        -> Ptr (Ptr Z3_symbol)
                        -> Ptr (Ptr Z3_func_decl)
                        -> IO (Ptr Z3_ast_vector)

foreign import ccall unsafe "Z3_eval_smtlib2_string"
  z3_eval_smtlib2_string :: Ptr Z3_context
                         -> Z3_string
                         -> IO Z3_string

---------------------------------------------------------------------
-- * Error Handling

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#ga8ac771e68b28d2c86f40aa84889b3807>
foreign import ccall unsafe "Z3_get_error_code"
    z3_get_error_code :: Ptr Z3_context -> IO Z3_error_code

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#gadaa12e9990f37b0c1e2bf1dd502dbf39>
foreign import ccall unsafe "Z3_set_error_handler"
    z3_set_error_handler :: Ptr Z3_context -> FunPtr Z3_error_handler -> IO ()

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#ga41cf70319c4802ab7301dd168d6f5e45>
foreign import ccall unsafe "Z3_set_error"
    z3_set_error :: Ptr Z3_context -> Z3_error_code -> IO ()

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#gaf06357c49299efb8a0bdaeb3bc96c6d6>
foreign import ccall unsafe "Z3_get_error_msg"
    z3_get_error_msg :: Ptr Z3_context -> Z3_error_code -> IO Z3_string


---------------------------------------------------------------------
-- * Miscellaneous

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#ga45fcd18a00379b13a536c5b6117190ae>
foreign import ccall unsafe "Z3_get_version"
    z3_get_version :: Ptr CUInt -> Ptr CUInt -> Ptr CUInt -> Ptr CUInt -> IO ()

foreign import ccall unsafe "Z3_get_full_version"
    z3_get_full_version :: IO Z3_string

foreign import ccall unsafe "Z3_enable_trace"
    z3_enable_trace :: Z3_string -> IO ()

foreign import ccall unsafe "Z3_disable_trace"
    z3_disable_trace :: Z3_string -> IO ()

foreign import ccall unsafe "Z3_reset_memory"
    z3_reset_memory :: IO ()

foreign import ccall unsafe "Z3_finalize_memory"
    z3_finalize_memory :: IO ()

---------------------------------------------------------------------
-- * Goals

-- | Reference: <https://z3prover.github.io/api/html/group__capi.html#ga631394a36c83a1e0db7825fe92d8aebe>
foreign import ccall unsafe "Z3_mk_goal"
    z3_mk_goal :: Ptr Z3_context -> Z3_bool -> Z3_bool -> Z3_bool -> IO (Ptr Z3_goal)

-- | Reference: <https://z3prover.github.io/api/html/group__capi.html#ga63a581c33213fb14efe9e6175c74546b>
foreign import ccall unsafe "Z3_goal_inc_ref"
    z3_goal_inc_ref :: Ptr Z3_context -> Ptr Z3_goal -> IO ()

-- | Reference: <https://z3prover.github.io/api/html/group__capi.html#gad65f4f9f7035b6eef161ee93bb694e52>
foreign import ccall unsafe "Z3_goal_dec_ref"
    z3_goal_dec_ref :: Ptr Z3_context -> Ptr Z3_goal -> IO ()

foreign import ccall unsafe "Z3_goal_precision"
    z3_goal_precision :: Ptr Z3_context -> Ptr Z3_goal -> IO (Ptr Z3_goal_prec)

-- | Reference: <https://z3prover.github.io/api/html/group__capi.html#ga3052a11993ce35250f108c365bc09ff7>
foreign import ccall unsafe "Z3_goal_assert"
    z3_goal_assert :: Ptr Z3_context -> Ptr Z3_goal -> Ptr Z3_ast -> IO ()

foreign import ccall unsafe "Z3_goal_inconsistent"
    z3_goal_inconsistent :: Ptr Z3_context -> Ptr Z3_goal -> IO Z3_bool

foreign import ccall unsafe "Z3_goal_depth"
    z3_goal_depth :: Ptr Z3_context -> Ptr Z3_goal -> IO CUInt

foreign import ccall unsafe "Z3_goal_reset"
    z3_goal_reset :: Ptr Z3_context -> Ptr Z3_goal -> IO ()

-- | Reference: <https://z3prover.github.io/api/html/group__capi.html#ga5badc99b0a1e154ef3cef17ff35fd021>
foreign import ccall unsafe "Z3_goal_size"
    z3_goal_size :: Ptr Z3_context -> Ptr Z3_goal -> IO CUInt

-- | Reference: <https://z3prover.github.io/api/html/group__capi.html#gaec43d4d20ed7e7bf4c7a57d37dc3bfc6>
foreign import ccall unsafe "Z3_goal_formula"
    z3_goal_formula :: Ptr Z3_context -> Ptr Z3_goal -> CUInt -> IO (Ptr Z3_ast)

foreign import ccall unsafe "Z3_goal_num_exprs"
    z3_goal_num_exprs :: Ptr Z3_context -> Ptr Z3_goal -> IO CUInt

foreign import ccall unsafe "Z3_goal_is_decided_sat"
    z3_goal_is_decided_sat :: Ptr Z3_context -> Ptr Z3_goal -> IO Z3_bool

foreign import ccall unsafe "Z3_goal_is_decided_unsat"
    z3_goal_is_decided_unsat :: Ptr Z3_context -> Ptr Z3_goal -> IO Z3_bool

foreign import ccall unsafe "Z3_goal_translate"
    z3_goal_translate :: Ptr Z3_context -> Ptr Z3_goal -> Ptr Z3_context -> IO (Ptr Z3_goal)

foreign import ccall unsafe "Z3_goal_convert_model"
    z3_goal_convert_model :: Ptr Z3_context -> Ptr Z3_goal -> Ptr Z3_model-> IO (Ptr Z3_model)

foreign import ccall unsafe "Z3_goal_to_string"
    z3_goal_to_string :: Ptr Z3_context -> Ptr Z3_goal -> IO Z3_string

foreign import ccall unsafe "Z3_goal_to_dimacs_string"
    z3_goal_to_dimacs_string :: Ptr Z3_context -> Ptr Z3_goal -> IO Z3_string

---------------------------------------------------------------------
-- * Tactics and Probes

-- | Reference: <https://z3prover.github.io/api/html/group__capi.html#gaa4b9d53ba194d2d3a8bb2f55bec7e78e>
foreign import ccall unsafe "Z3_mk_tactic"
    z3_mk_tactic :: Ptr Z3_context -> Ptr CChar -> IO (Ptr Z3_tactic)

-- | Reference: <https://z3prover.github.io/api/html/group__capi.html#gabd0874d8777b3bc426782a87c04206b9>
foreign import ccall unsafe "Z3_tactic_inc_ref"
    z3_tactic_inc_ref :: Ptr Z3_context -> Ptr Z3_tactic -> IO ()

-- | Reference: <https://z3prover.github.io/api/html/group__capi.html#ga8feaef3d36dcb136fa7812a8c10cf178>
foreign import ccall unsafe "Z3_tactic_dec_ref"
    z3_tactic_dec_ref :: Ptr Z3_context -> Ptr Z3_tactic -> IO ()

foreign import ccall unsafe "Z3_mk_probe"
    z3_mk_probe :: Ptr Z3_context -> Z3_string -> IO (Ptr Z3_probe)

foreign import ccall unsafe "Z3_probe_inc_ref"
    z3_probe_inc_ref :: Ptr Z3_context -> Ptr Z3_probe -> IO ()

foreign import ccall unsafe "Z3_probe_dec_ref"
    z3_probe_dec_ref :: Ptr Z3_context -> Ptr Z3_probe -> IO ()

-- | Reference: <https://z3prover.github.io/api/html/group__capi.html#gaf53dac8f6c9b615cd21b9a2eeb006005>
foreign import ccall unsafe "Z3_tactic_and_then"
    z3_tactic_and_then :: Ptr Z3_context -> Ptr Z3_tactic -> Ptr Z3_tactic -> IO (Ptr Z3_tactic)

-- | Reference: <https://z3prover.github.io/api/html/group__capi.html#gad9964357958dd12ab20f0b315ddc219b>
foreign import ccall unsafe "Z3_tactic_or_else"
    z3_tactic_or_else :: Ptr Z3_context -> Ptr Z3_tactic -> Ptr Z3_tactic -> IO (Ptr Z3_tactic)

foreign import ccall unsafe "Z3_tactic_par_or"
    z3_tactic_par_or :: Ptr Z3_context -> CUInt -> Ptr (Ptr Z3_tactic) -> IO (Ptr Z3_tactic)

foreign import ccall unsafe "Z3_tactic_par_and_then"
    z3_tactic_par_and_then :: Ptr Z3_context -> Ptr Z3_tactic -> Ptr Z3_tactic -> IO (Ptr Z3_tactic)

-- | Reference: <https://z3prover.github.io/api/html/group__capi.html#gac0670bd04fa76af71b2abbc2f8b62889>
foreign import ccall unsafe "Z3_tactic_try_for"
    z3_tactic_try_for :: Ptr Z3_context -> Ptr Z3_tactic -> CUInt -> IO (Ptr Z3_tactic)

foreign import ccall unsafe "Z3_tactic_when"
    z3_tactic_when :: Ptr Z3_context -> Ptr Z3_probe -> Ptr Z3_tactic -> IO (Ptr Z3_tactic)

foreign import ccall unsafe "Z3_tactic_cond"
    z3_tactic_cond :: Ptr Z3_context -> Ptr Z3_probe -> Ptr Z3_tactic -> Ptr Z3_tactic -> IO (Ptr Z3_tactic)

foreign import ccall unsafe "Z3_tactic_repeat"
    z3_tactic_repeat :: Ptr Z3_context -> Ptr Z3_tactic -> CUInt -> IO (Ptr Z3_tactic)

-- | Reference: <https://z3prover.github.io/api/html/group__capi.html#gab940c1401643ece97517ff27838313c4>
foreign import ccall unsafe "Z3_tactic_skip"
    z3_tactic_skip :: Ptr Z3_context -> IO (Ptr Z3_tactic)

foreign import ccall unsafe "Z3_tactic_fail"
    z3_tactic_fail :: Ptr Z3_context -> IO (Ptr Z3_tactic)

foreign import ccall unsafe "Z3_tactic_fail_if"
    z3_tactic_fail_if :: Ptr Z3_context -> Ptr Z3_probe -> IO (Ptr Z3_tactic)

foreign import ccall unsafe "Z3_tactic_fail_if_not_decided"
    z3_tactic_fail_if_not_decided :: Ptr Z3_context -> IO (Ptr Z3_tactic)

foreign import ccall unsafe "Z3_tactic_using_params"
    z3_tactic_using_params :: Ptr Z3_context -> Ptr Z3_tactic -> Ptr Z3_params -> IO (Ptr Z3_tactic)

foreign import ccall unsafe "Z3_probe_const"
    z3_probe_const :: Ptr Z3_context -> CDouble -> IO (Ptr Z3_probe)

foreign import ccall unsafe "Z3_probe_lt"
    z3_probe_lt :: Ptr Z3_context -> Ptr Z3_probe -> Ptr Z3_probe -> IO (Ptr Z3_probe)

foreign import ccall unsafe "Z3_probe_gt"
    z3_probe_gt :: Ptr Z3_context -> Ptr Z3_probe -> Ptr Z3_probe -> IO (Ptr Z3_probe)

foreign import ccall unsafe "Z3_probe_le"
    z3_probe_le :: Ptr Z3_context -> Ptr Z3_probe -> Ptr Z3_probe -> IO (Ptr Z3_probe)

foreign import ccall unsafe "Z3_probe_ge"
    z3_probe_ge :: Ptr Z3_context -> Ptr Z3_probe -> Ptr Z3_probe -> IO (Ptr Z3_probe)

foreign import ccall unsafe "Z3_probe_eq"
    z3_probe_eq :: Ptr Z3_context -> Ptr Z3_probe -> Ptr Z3_probe -> IO (Ptr Z3_probe)

foreign import ccall unsafe "Z3_probe_and"
    z3_probe_and :: Ptr Z3_context -> Ptr Z3_probe -> Ptr Z3_probe -> IO (Ptr Z3_probe)

foreign import ccall unsafe "Z3_probe_or"
    z3_probe_or :: Ptr Z3_context -> Ptr Z3_probe -> Ptr Z3_probe -> IO (Ptr Z3_probe)

foreign import ccall unsafe "Z3_probe_not"
    z3_probe_not :: Ptr Z3_context -> Ptr Z3_probe -> IO (Ptr Z3_probe)

foreign import ccall unsafe "Z3_get_num_tactics"
    z3_get_num_tactics :: Ptr Z3_context -> IO CUInt

foreign import ccall unsafe "Z3_get_tactic_name"
    z3_get_tactic_name :: Ptr Z3_context -> Ptr CUInt -> IO Z3_string

foreign import ccall unsafe "Z3_get_num_probes"
    z3_get_num_probes :: Ptr Z3_context -> IO CUInt

foreign import ccall unsafe "Z3_get_probe_name"
    z3_get_probe_name :: Ptr Z3_context -> Ptr CUInt -> IO Z3_string

foreign import ccall unsafe "Z3_tactic_get_help"
    z3_tactic_get_help :: Ptr Z3_context -> Ptr Z3_tactic -> IO Z3_string

foreign import ccall unsafe "Z3_tactic_get_param_descrs"
    z3_tactic_get_param_descrs :: Ptr Z3_context -> Ptr Z3_tactic -> IO (Ptr Z3_param_descrs)

foreign import ccall unsafe "Z3_tactic_get_descr"
    z3_tactic_get_descr :: Ptr Z3_context -> Z3_string -> IO Z3_string

foreign import ccall unsafe "Z3_probe_get_descr"
    z3_probe_get_descr :: Ptr Z3_context -> Z3_string -> IO Z3_string

foreign import ccall unsafe "Z3_probe_apply"
    z3_probe_apply :: Ptr Z3_context -> Ptr Z3_probe -> Ptr Z3_goal -> IO CDouble

-- | Reference: <https://z3prover.github.io/api/html/group__capi.html#gac9e9da38d6a9acff293bc22bf0cf1a20>
foreign import ccall unsafe "Z3_tactic_apply"
    z3_tactic_apply :: Ptr Z3_context -> Ptr Z3_tactic -> Ptr Z3_goal -> IO (Ptr Z3_apply_result)

foreign import ccall unsafe "Z3_tactic_apply_ex"
    z3_tactic_apply_ex :: Ptr Z3_context -> Ptr Z3_tactic -> Ptr Z3_goal -> Ptr Z3_params -> IO (Ptr Z3_apply_result)

-- | Reference: <https://z3prover.github.io/api/html/group__capi.html#ga1f182e7ef80015e8f2dcde219371aedc>
foreign import ccall unsafe "Z3_apply_result_inc_ref"
    z3_apply_result_inc_ref :: Ptr Z3_context -> Ptr Z3_apply_result -> IO ()

-- | Reference: <https://z3prover.github.io/api/html/group__capi.html#gac0fa60e39840a704f201ced90cde0ef9>
foreign import ccall unsafe "Z3_apply_result_dec_ref"
    z3_apply_result_dec_ref :: Ptr Z3_context -> Ptr Z3_apply_result -> IO ()

foreign import ccall unsafe "Z3_apply_result_to_string"
    z3_apply_result_to_string :: Ptr Z3_context -> Ptr Z3_apply_result -> IO Z3_string

-- | Reference: <https://z3prover.github.io/api/html/group__capi.html#ga5ab8e77bdbfecc6f8845734cd7a729f7>
foreign import ccall unsafe "Z3_apply_result_get_num_subgoals"
    z3_apply_result_get_num_subgoals :: Ptr Z3_context -> Ptr Z3_apply_result -> IO CUInt

-- | Reference: <https://z3prover.github.io/api/html/group__capi.html#gac4f8342eed2de1c1caaa2fbf492439a9>
foreign import ccall unsafe "Z3_apply_result_get_subgoal"
    z3_apply_result_get_subgoal :: Ptr Z3_context -> Ptr Z3_apply_result -> CUInt -> IO (Ptr Z3_goal)

---------------------------------------------------------------------
-- * Solvers

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#ga5735499ef0b46846c5d45982eaa0e74c>
foreign import ccall unsafe "Z3_mk_solver"
    z3_mk_solver :: Ptr Z3_context -> IO (Ptr Z3_solver)

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#ga5735499ef0b46846c5d45982eaa0e74c>
foreign import ccall unsafe "Z3_mk_simple_solver"
    z3_mk_simple_solver :: Ptr Z3_context -> IO (Ptr Z3_solver)

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#ga54244cfc9d9cd2ca8f08c3909d700628>
foreign import ccall unsafe "Z3_mk_solver_for_logic"
    z3_mk_solver_for_logic :: Ptr Z3_context -> Ptr Z3_symbol -> IO (Ptr Z3_solver)

foreign import ccall unsafe "Z3_mk_solver_from_tactic"
    z3_mk_solver_from_tactic :: Ptr Z3_context -> Ptr Z3_tactic -> IO (Ptr Z3_solver)

foreign import ccall unsafe "Z3_solver_translate"
    z3_solver_translate :: Ptr Z3_context -> Ptr Z3_solver -> Ptr Z3_context -> IO (Ptr Z3_solver)

foreign import ccall unsafe "Z3_solver_import_model_converter"
    z3_solver_import_model_converter :: Ptr Z3_context -> Ptr Z3_solver -> Ptr Z3_solver -> IO ()

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#ga047bb9dff9d57c7d3a71b7af4555956b>
foreign import ccall unsafe "Z3_solver_get_help"
    z3_solver_get_help :: Ptr Z3_context -> Ptr Z3_solver -> IO Z3_string

foreign import ccall unsafe "Z3_solver_get_param_descrs"
    z3_solver_get_param_descrs :: Ptr Z3_context -> Ptr Z3_solver -> IO (Ptr Z3_param_descrs)

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#ga887441b3468a1bc605bbf564ddebf2ae>
foreign import ccall unsafe "Z3_solver_set_params"
    z3_solver_set_params :: Ptr Z3_context -> Ptr Z3_solver -> Ptr Z3_params ->
                            IO ()

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#ga388e25a8b477abbd49f08c6c29dfa12d>
foreign import ccall unsafe "Z3_solver_inc_ref"
    z3_solver_inc_ref :: Ptr Z3_context -> Ptr Z3_solver -> IO ()

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#ga2362dcef4e9b8ede41298a50428902ff>
foreign import ccall unsafe "Z3_solver_dec_ref"
    z3_solver_dec_ref :: Ptr Z3_context -> Ptr Z3_solver -> IO ()

foreign import ccall unsafe "Z3_solver_interrupt"
    z3_solver_interrupt :: Ptr Z3_context -> Ptr Z3_solver -> IO ()

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#gae41bebe15b1b1105f9abb8690188d1e2>
foreign import ccall unsafe "Z3_solver_push"
    z3_solver_push :: Ptr Z3_context -> Ptr Z3_solver -> IO ()

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#ga40aa98e15aceffa5be3afad2e065478a>
foreign import ccall unsafe "Z3_solver_pop"
    z3_solver_pop :: Ptr Z3_context -> Ptr Z3_solver -> CUInt -> IO ()

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#ga4a4a215b9130d7980e3c393fe857335f>
foreign import ccall unsafe "Z3_solver_reset"
    z3_solver_reset :: Ptr Z3_context -> Ptr Z3_solver -> IO ()

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#gafd4b4a6465601835341b477b75725b28>
foreign import ccall unsafe "Z3_solver_get_num_scopes"
    z3_solver_get_num_scopes :: Ptr Z3_context -> Ptr Z3_solver -> IO CUInt

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#ga72afadf5e8b216f2c6ae675e872b8be4>
foreign import ccall unsafe "Z3_solver_assert"
    z3_solver_assert :: Ptr Z3_context -> Ptr Z3_solver -> Ptr Z3_ast -> IO ()

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#gaf46fb6f3aa3ef451d6be01a737697810>
foreign import ccall unsafe "Z3_solver_assert_and_track"
    z3_solver_assert_and_track :: Ptr Z3_context -> Ptr Z3_solver ->
                                  Ptr Z3_ast -> Ptr Z3_ast -> IO ()

foreign import ccall unsafe "Z3_solver_from_file"
    z3_solver_from_file :: Ptr Z3_context -> Ptr Z3_solver -> Z3_string -> IO ()

foreign import ccall unsafe "Z3_solver_from_string"
    z3_solver_from_string :: Ptr Z3_context -> Ptr Z3_solver -> Z3_string -> IO ()

-- | Reference <https://z3prover.github.io/api/html/group__capi.html#ga3b3d6d8c5bafd5be707cda2d144073db>
foreign import ccall unsafe "Z3_solver_get_assertions"
    z3_solver_get_assertions :: Ptr Z3_context -> Ptr Z3_solver -> IO (Ptr Z3_ast_vector)

foreign import ccall unsafe "Z3_solver_get_units"
    z3_solver_get_units :: Ptr Z3_context -> Ptr Z3_solver -> IO (Ptr Z3_ast_vector)

foreign import ccall unsafe "Z3_solver_get_trail"
    z3_solver_get_trail :: Ptr Z3_context -> Ptr Z3_solver -> IO (Ptr Z3_ast_vector)

foreign import ccall unsafe "Z3_solver_get_non_units"
    z3_solver_get_non_units :: Ptr Z3_context -> Ptr Z3_solver -> IO (Ptr Z3_ast_vector)

foreign import ccall unsafe "Z3_solver_get_levels"
    z3_solver_get_levels :: Ptr Z3_context -> Ptr Z3_solver -> Ptr Z3_ast_vector -> CUInt -> Ptr CUInt -> IO ()

-- TODO Z3_solver_propagate_init

-- TODO Z3_solver_propagate_fixed

-- TODO Z3_solver_propagate_final

-- TODO Z3_solver_propagate_eq

-- TODO Z3_solver_propagate_diseq

-- TODO Z3_solver_propagate_register

-- TODO Z3_solver_propagate_consequence

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#ga000e369de7b71caa4ee701089709c526>
foreign import ccall unsafe "Z3_solver_check"
    z3_solver_check :: Ptr Z3_context -> Ptr Z3_solver -> IO Z3_lbool

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#ga45b40829aaa382bbf427a744911452f9>
foreign import ccall unsafe "Z3_solver_check_assumptions"
    z3_solver_check_assumptions :: Ptr Z3_context -> Ptr Z3_solver -> CUInt -> Ptr (Ptr Z3_ast) -> IO Z3_lbool

foreign import ccall unsafe "Z3_get_implied_equalities"
    z3_get_implied_equalities :: Ptr Z3_context -> Ptr Z3_solver -> CUInt -> Ptr Z3_ast_vector -> Ptr (CUInt) -> IO Z3_lbool

foreign import ccall unsafe "Z3_solver_get_consequences"
    z3_solver_get_consequences :: Ptr Z3_context -> Ptr Z3_solver -> Ptr Z3_ast_vector -> Ptr Z3_ast_vector -> Ptr Z3_ast_vector -> IO Z3_lbool

foreign import ccall unsafe "Z3_solver_cube"
    z3_solver_cube :: Ptr Z3_context -> Ptr Z3_solver -> Ptr Z3_ast_vector -> CUInt -> IO (Ptr Z3_ast_vector)

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#gaf14a54d904a7e45eecc00c5fb8a9d5c9>
foreign import ccall unsafe "Z3_solver_get_model"
    z3_solver_get_model :: Ptr Z3_context -> Ptr Z3_solver -> IO (Ptr Z3_model)

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#gaba0fc4849eb0d1538d52aaa08f86a7c0>
foreign import ccall unsafe "Z3_solver_get_proof"
    z3_solver_get_proof :: Ptr Z3_context -> Ptr Z3_solver -> IO (Ptr Z3_ast)

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#gabb4f8ed6a09873f5aeefe9cc01010864>
foreign import ccall unsafe "Z3_solver_get_unsat_core"
    z3_solver_get_unsat_core :: Ptr Z3_context -> Ptr Z3_solver -> IO (Ptr Z3_ast_vector)

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#gaed5d19000004b43dd75e487682e91b55>
foreign import ccall unsafe "Z3_solver_get_reason_unknown"
    z3_solver_get_reason_unknown :: Ptr Z3_context -> Ptr Z3_solver ->
                                    IO Z3_string

foreign import ccall unsafe "Z3_solver_get_statistics"
    z3_solver_get_statistics :: Ptr Z3_context -> Ptr Z3_solver -> IO (Ptr Z3_stats)

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#gaf52e41db4b12a84188b80255454d3abb>
foreign import ccall unsafe "Z3_solver_to_string"
    z3_solver_to_string :: Ptr Z3_context -> Ptr Z3_solver -> IO Z3_string

foreign import ccall unsafe "Z3_solver_to_dimacs_string"
    z3_solver_to_dimacs_string :: Ptr Z3_context -> Ptr Z3_solver -> IO Z3_string

---------------------------------------------------------------------
-- * Statistics

foreign import ccall unsafe "Z3_stats_to_string"
    z3_stats_to_string :: Ptr Z3_context -> Ptr Z3_stats -> IO Z3_string

foreign import ccall unsafe "Z3_stats_inc_ref"
    z3_stats_inc_ref :: Ptr Z3_context -> Ptr Z3_stats -> IO ()

foreign import ccall unsafe "Z3_stats_dec_ref"
    z3_stats_dec_ref :: Ptr Z3_context -> Ptr Z3_stats -> IO ()

foreign import ccall unsafe "Z3_stats_size"
    z3_stats_size :: Ptr Z3_context -> Ptr Z3_stats -> IO CUInt

foreign import ccall unsafe "Z3_stats_get_key"
    z3_stats_get_key :: Ptr Z3_context -> Ptr Z3_stats -> CUInt -> IO Z3_string

foreign import ccall unsafe "Z3_stats_is_uint"
    z3_stats_is_uint :: Ptr Z3_context -> Ptr Z3_stats -> CUInt -> IO Z3_bool

foreign import ccall unsafe "Z3_stats_is_double"
    z3_stats_is_double :: Ptr Z3_context -> Ptr Z3_stats -> CUInt -> IO Z3_bool

foreign import ccall unsafe "Z3_stats_get_uint_value"
    z3_stats_get_uint_value :: Ptr Z3_context -> Ptr Z3_stats -> CUInt -> IO CUInt

foreign import ccall unsafe "Z3_stats_get_double_value"
    z3_stats_get_double_value :: Ptr Z3_context -> Ptr Z3_stats -> CUInt -> IO CDouble

-- TODO is CULong correct?
foreign import ccall unsafe "Z3_get_estimated_alloc_size"
    z3_get_estimated_alloc_size:: IO CULong

---------------------------------------------------------------------
-- * AST vectors

foreign import ccall unsafe "Z3_mk_ast_vector"
    z3_mk_ast_vector :: Ptr Z3_context -> IO (Ptr Z3_ast_vector)

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#gaea0024e05e6f82434ff31e6ec6fab432>
foreign import ccall unsafe "Z3_ast_vector_inc_ref"
    z3_ast_vector_inc_ref :: Ptr Z3_context -> Ptr Z3_ast_vector -> IO ()

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#gab0e22d719f55f93fb8788fa4534cc342>
foreign import ccall unsafe "Z3_ast_vector_dec_ref"
    z3_ast_vector_dec_ref :: Ptr Z3_context -> Ptr Z3_ast_vector -> IO ()

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#ga99d6a99e914fcb11e5dcf9fcc3584425>
foreign import ccall unsafe "Z3_ast_vector_size"
    z3_ast_vector_size :: Ptr Z3_context -> Ptr Z3_ast_vector -> IO CUInt

-- | Reference: <http://z3prover.github.io/api/html/group__capi.html#ga3a90216036017ce16db63fb3aa5f6047>
foreign import ccall unsafe "Z3_ast_vector_get"
    z3_ast_vector_get :: Ptr Z3_context -> Ptr Z3_ast_vector -> CUInt -> IO (Ptr Z3_ast)

foreign import ccall unsafe "Z3_ast_vector_set"
    z3_ast_vector_set :: Ptr Z3_context -> Ptr Z3_ast_vector -> CUInt -> Ptr Z3_ast -> IO ()

foreign import ccall unsafe "Z3_ast_vector_resize"
    z3_ast_vector_resize :: Ptr Z3_context -> Ptr Z3_ast_vector -> CUInt -> IO ()

foreign import ccall unsafe "Z3_ast_vector_push"
    z3_ast_vector_push :: Ptr Z3_context -> Ptr Z3_ast_vector -> Ptr Z3_ast -> IO ()

foreign import ccall unsafe "Z3_ast_vector_translate"
    z3_ast_vector_translate :: Ptr Z3_context -> Ptr Z3_ast_vector -> Ptr Z3_context -> IO (Ptr Z3_ast_vector)

foreign import ccall unsafe "Z3_ast_vector_to_string"
    z3_ast_vector_to_string :: Ptr Z3_context -> Ptr Z3_ast_vector -> IO Z3_string

---------------------------------------------------------------------
-- * AST maps

foreign import ccall unsafe "Z3_mk_ast_map"
    z3_mk_ast_map :: Ptr Z3_context -> IO (Ptr Z3_ast_map)

foreign import ccall unsafe "Z3_ast_map_inc_ref"
    z3_ast_map_inc_ref :: Ptr Z3_context -> Ptr Z3_ast_map -> IO ()

foreign import ccall unsafe "Z3_ast_map_dec_ref"
    z3_ast_map_dec_ref :: Ptr Z3_context -> Ptr Z3_ast_map -> IO ()

foreign import ccall unsafe "Z3_ast_map_contains"
    z3_ast_map_contains :: Ptr Z3_context -> Ptr Z3_ast_map -> Ptr Z3_ast -> IO Z3_bool

foreign import ccall unsafe "Z3_ast_map_find"
    z3_ast_map_find :: Ptr Z3_context -> Ptr Z3_ast_map -> Ptr Z3_ast -> IO (Ptr Z3_ast)

foreign import ccall unsafe "Z3_ast_map_insert"
    z3_ast_map_insert :: Ptr Z3_context -> Ptr Z3_ast_map -> Ptr Z3_ast -> Ptr Z3_ast -> IO ()

foreign import ccall unsafe "Z3_ast_map_erase"
    z3_ast_map_erase :: Ptr Z3_context -> Ptr Z3_ast_map -> Ptr Z3_ast -> IO ()

foreign import ccall unsafe "Z3_ast_map_reset"
    z3_ast_map_reset :: Ptr Z3_context -> Ptr Z3_ast_map -> IO ()

foreign import ccall unsafe "Z3_ast_map_size"
    z3_ast_map_size :: Ptr Z3_context -> Ptr Z3_ast_map -> IO CUInt

foreign import ccall unsafe "Z3_ast_map_keys"
    z3_ast_map_keys :: Ptr Z3_context -> Ptr Z3_ast_map -> IO (Ptr Z3_ast_vector)

foreign import ccall unsafe "Z3_ast_map_to_string"
    z3_ast_map_to_string :: Ptr Z3_context -> Ptr Z3_ast_map -> IO Z3_string

---------------------------------------------------------------------
-- * Fixedpoint facilities

-- TODO Z3_fixedpoint_reduce_assign_callback_fptr

-- TODO Z3_fixedpoint_reduce_app_callback_fptr

-- TODO Z3_fixedpoint_new_lemma_eh

-- TODO Z3_fixedpoint_predecessor_eh

-- TODO Z3_fixedpoint_unfold_eh

foreign import ccall unsafe "Z3_mk_fixedpoint"
    z3_mk_fixedpoint :: Ptr Z3_context -> IO (Ptr Z3_fixedpoint)

foreign import ccall unsafe "Z3_fixedpoint_inc_ref"
    z3_fixedpoint_inc_ref :: Ptr Z3_context -> Ptr Z3_fixedpoint -> IO ()

foreign import ccall unsafe "Z3_fixedpoint_dec_ref"
    z3_fixedpoint_dec_ref :: Ptr Z3_context -> Ptr Z3_fixedpoint -> IO ()

foreign import ccall unsafe "Z3_fixedpoint_add_rule"
    z3_fixedpoint_add_rule :: Ptr Z3_context -> Ptr Z3_fixedpoint -> Ptr Z3_ast -> Ptr Z3_symbol -> IO ()

foreign import ccall unsafe "Z3_fixedpoint_add_fact"
    z3_fixedpoint_add_fact :: Ptr Z3_context -> Ptr Z3_fixedpoint -> Ptr Z3_func_decl -> CUInt -> Ptr CUInt -> IO ()

foreign import ccall unsafe "Z3_fixedpoint_assert"
    z3_fixedpoint_assert :: Ptr Z3_context -> Ptr Z3_fixedpoint -> Ptr Z3_ast -> IO ()

foreign import ccall unsafe "Z3_fixedpoint_query"
    z3_fixedpoint_query :: Ptr Z3_context -> Ptr Z3_fixedpoint -> Ptr Z3_ast -> IO Z3_bool

foreign import ccall unsafe "Z3_fixedpoint_query_relations"
    z3_fixedpoint_query_relations :: Ptr Z3_context
                                  -> Ptr Z3_fixedpoint
                                  -> CUInt
                                  -> Ptr (Ptr Z3_func_decl)
                                  -> IO Z3_lbool

foreign import ccall unsafe "Z3_fixedpoint_get_answer"
    z3_fixedpoint_get_answer :: Ptr Z3_context -> Ptr Z3_fixedpoint -> IO (Ptr Z3_ast)

foreign import ccall unsafe "Z3_fixedpoint_get_reason_unknown"
    z3_fixedpoint_get_reason_unknown :: Ptr Z3_context -> Ptr Z3_fixedpoint -> IO Z3_string

foreign import ccall unsafe "Z3_fixedpoint_update_rule"
    z3_fixedpoint_update_rule :: Ptr Z3_context -> Ptr Z3_fixedpoint -> Ptr Z3_ast -> Ptr Z3_symbol -> IO ()

foreign import ccall unsafe "Z3_fixedpoint_get_num_levels"
    z3_fixedpoint_get_num_levels :: Ptr Z3_context -> Ptr Z3_fixedpoint -> Ptr Z3_func_decl -> IO CUInt

foreign import ccall unsafe "Z3_fixedpoint_get_cover_delta"
    z3_fixedpoint_get_cover_delta :: Ptr Z3_context -> Ptr Z3_fixedpoint -> CInt -> Ptr Z3_func_decl -> IO (Ptr Z3_ast)

foreign import ccall unsafe "Z3_fixedpoint_add_cover"
    z3_fixedpoint_add_cover :: Ptr Z3_context -> Ptr Z3_fixedpoint -> CInt -> Ptr Z3_func_decl -> Ptr Z3_ast -> IO ()

foreign import ccall unsafe "Z3_fixedpoint_get_statistics"
    z3_fixedpoint_get_statistics :: Ptr Z3_context -> Ptr Z3_fixedpoint -> IO (Ptr Z3_stats)

foreign import ccall unsafe "Z3_fixedpoint_register_relation"
    z3_fixedpoint_register_relation :: Ptr Z3_context -> Ptr Z3_fixedpoint -> Ptr Z3_func_decl -> IO ()

foreign import ccall unsafe "Z3_fixedpoint_set_predicate_representation"
    z3_fixedpoint_set_predicate_representation :: Ptr Z3_context -> Ptr Z3_fixedpoint -> Ptr Z3_func_decl -> CUInt -> Ptr (Ptr Z3_symbol) -> IO ()

foreign import ccall unsafe "Z3_fixedpoint_get_rules"
    z3_fixedpoint_get_rules :: Ptr Z3_context -> Ptr Z3_fixedpoint -> IO (Ptr Z3_ast_vector)

foreign import ccall unsafe "Z3_fixedpoint_get_assertions"
    z3_fixedpoint_get_assertions :: Ptr Z3_context -> Ptr Z3_fixedpoint -> IO (Ptr Z3_ast_vector)

foreign import ccall unsafe "Z3_fixedpoint_set_params"
    z3_fixedpoint_set_params :: Ptr Z3_context -> Ptr Z3_fixedpoint -> Ptr Z3_params -> IO ()

foreign import ccall unsafe "Z3_fixedpoint_get_help"
    z3_fixedpoint_get_help :: Ptr Z3_context -> Ptr Z3_fixedpoint -> IO Z3_string

foreign import ccall unsafe "Z3_fixedpoint_get_param_descrs"
    z3_fixedpoint_get_param_descrs :: Ptr Z3_context -> Ptr Z3_fixedpoint -> IO (Ptr Z3_param_descrs)

foreign import ccall unsafe "Z3_fixedpoint_to_string"
    z3_fixedpoint_to_string :: Ptr Z3_context -> Ptr Z3_fixedpoint -> CUInt -> Ptr Z3_ast_vector -> IO Z3_string

foreign import ccall unsafe "Z3_fixedpoint_from_string"
    z3_fixedpoint_from_string :: Ptr Z3_context -> Ptr Z3_fixedpoint -> Z3_string -> IO (Ptr Z3_ast_vector)

foreign import ccall unsafe "Z3_fixedpoint_from_file"
    z3_fixedpoint_from_file :: Ptr Z3_context -> Ptr Z3_fixedpoint -> Z3_string -> IO (Ptr Z3_ast_vector)

-- TODO Z3_fixedpoint_init

-- TODO Z3_fixedpoint_set_reduce_assign_callback

-- TODO Z3_fixedpoint_set_reduce_app_callback

-- TODO Z3_fixedpoint_add_callback

foreign import ccall unsafe "Z3_fixedpoint_add_constraint"
    z3_fixedpoint_add_constraint :: Ptr Z3_context -> Ptr Z3_fixedpoint -> Ptr Z3_ast -> CUInt -> IO ()

---------------------------------------------------------------------
-- * Floating-Point Arithmetic

foreign import ccall unsafe "Z3_mk_fpa_rounding_mode_sort"
    z3_mk_fpa_rounding_mode_sort :: Ptr Z3_context -> IO (Ptr Z3_sort)

foreign import ccall unsafe "Z3_mk_fpa_round_nearest_ties_to_even"
    z3_mk_fpa_round_nearest_ties_to_even :: Ptr Z3_context -> IO (Ptr Z3_ast)

foreign import ccall unsafe "Z3_mk_fpa_rne"
    z3_mk_fpa_rne :: Ptr Z3_context -> IO (Ptr Z3_ast)

foreign import ccall unsafe "Z3_mk_fpa_round_nearest_ties_to_away"
    z3_mk_fpa_round_nearest_ties_to_away :: Ptr Z3_context -> IO (Ptr Z3_ast)

foreign import ccall unsafe "Z3_mk_fpa_rna"
    z3_mk_fpa_rna :: Ptr Z3_context -> IO (Ptr Z3_ast)

foreign import ccall unsafe "Z3_mk_fpa_round_toward_positive"
    z3_mk_fpa_round_toward_positive :: Ptr Z3_context -> IO (Ptr Z3_ast)

foreign import ccall unsafe "Z3_mk_fpa_rtp"
    z3_mk_fpa_rtp :: Ptr Z3_context -> IO (Ptr Z3_ast)

foreign import ccall unsafe "Z3_mk_fpa_round_toward_negative"
    z3_mk_fpa_round_toward_negative :: Ptr Z3_context -> IO (Ptr Z3_ast)

foreign import ccall unsafe "Z3_mk_fpa_rtn"
    z3_mk_fpa_rtn :: Ptr Z3_context -> IO (Ptr Z3_ast)

foreign import ccall unsafe "Z3_mk_fpa_round_toward_zero"
    z3_mk_fpa_round_toward_zero :: Ptr Z3_context -> IO (Ptr Z3_ast)

foreign import ccall unsafe "Z3_mk_fpa_rtz"
    z3_mk_fpa_rtz :: Ptr Z3_context -> IO (Ptr Z3_ast)

foreign import ccall unsafe "Z3_mk_fpa_sort"
    z3_mk_fpa_sort :: Ptr Z3_context -> CUInt -> CUInt -> IO (Ptr Z3_sort)

foreign import ccall unsafe "Z3_mk_fpa_sort_half"
    z3_mk_fpa_sort_half :: Ptr Z3_context -> IO (Ptr Z3_sort)

foreign import ccall unsafe "Z3_mk_fpa_sort_16"
    z3_mk_fpa_sort_16 :: Ptr Z3_context -> IO (Ptr Z3_sort)

foreign import ccall unsafe "Z3_mk_fpa_sort_single"
    z3_mk_fpa_sort_single :: Ptr Z3_context -> IO (Ptr Z3_sort)

foreign import ccall unsafe "Z3_mk_fpa_sort_32"
    z3_mk_fpa_sort_32 :: Ptr Z3_context -> IO (Ptr Z3_sort)

foreign import ccall unsafe "Z3_mk_fpa_sort_double"
    z3_mk_fpa_sort_double :: Ptr Z3_context -> IO (Ptr Z3_sort)

foreign import ccall unsafe "Z3_mk_fpa_sort_64"
    z3_mk_fpa_sort_64 :: Ptr Z3_context -> IO (Ptr Z3_sort)

foreign import ccall unsafe "Z3_mk_fpa_sort_quadruple"
    z3_mk_fpa_sort_quadruple :: Ptr Z3_context -> IO (Ptr Z3_sort)

foreign import ccall unsafe "Z3_mk_fpa_sort_128"
    z3_mk_fpa_sort_128 :: Ptr Z3_context -> IO (Ptr Z3_sort)

foreign import ccall unsafe "Z3_mk_fpa_nan"
    z3_mk_fpa_nan :: Ptr Z3_context -> Ptr Z3_sort -> IO (Ptr Z3_ast)

foreign import ccall unsafe "Z3_mk_fpa_inf"
    z3_mk_fpa_inf :: Ptr Z3_context -> Ptr Z3_sort -> Z3_bool -> IO (Ptr Z3_ast)

foreign import ccall unsafe "Z3_mk_fpa_zero"
    z3_mk_fpa_zero :: Ptr Z3_context -> Ptr Z3_sort -> Z3_bool -> IO (Ptr Z3_ast)

foreign import ccall unsafe "Z3_mk_fpa_fp"
    z3_mk_fpa_fp :: Ptr Z3_context -> Ptr Z3_ast -> Ptr Z3_ast -> Ptr Z3_ast -> IO (Ptr Z3_ast)

foreign import ccall unsafe "Z3_mk_fpa_numeral_float"
    z3_mk_fpa_numeral_float :: Ptr Z3_context -> CFloat -> Ptr Z3_sort -> IO (Ptr Z3_ast)

foreign import ccall unsafe "Z3_mk_fpa_numeral_double"
    z3_mk_fpa_numeral_double :: Ptr Z3_context -> CDouble -> Ptr Z3_sort -> IO (Ptr Z3_ast)

foreign import ccall unsafe "Z3_mk_fpa_numeral_int"
    z3_mk_fpa_numeral_int :: Ptr Z3_context -> CInt -> Ptr Z3_sort -> IO (Ptr Z3_ast)

foreign import ccall unsafe "Z3_mk_fpa_numeral_int_uint"
    z3_mk_fpa_numeral_int_uint :: Ptr Z3_context -> Z3_bool -> CInt -> CUInt -> Ptr Z3_sort -> IO (Ptr Z3_ast)

foreign import ccall unsafe "Z3_mk_fpa_numeral_int64_uint64"
    z3_mk_fpa_numeral_int64_uint64 :: Ptr Z3_context -> Z3_bool -> CLong -> CULong -> Ptr Z3_sort -> IO (Ptr Z3_ast)

foreign import ccall unsafe "Z3_mk_fpa_abs"
    z3_mk_fpa_abs :: Ptr Z3_context -> Ptr Z3_ast -> IO (Ptr Z3_ast)

foreign import ccall unsafe "Z3_mk_fpa_neg"
    z3_mk_fpa_neg :: Ptr Z3_context -> Ptr Z3_ast -> IO (Ptr Z3_ast)

foreign import ccall unsafe "Z3_mk_fpa_add"
    z3_mk_fpa_add :: Ptr Z3_context -> Ptr Z3_ast -> Ptr Z3_ast -> Ptr Z3_ast -> IO (Ptr Z3_ast)

foreign import ccall unsafe "Z3_mk_fpa_sub"
    z3_mk_fpa_sub :: Ptr Z3_context -> Ptr Z3_ast -> Ptr Z3_ast -> Ptr Z3_ast -> IO (Ptr Z3_ast)

foreign import ccall unsafe "Z3_mk_fpa_mul"
    z3_mk_fpa_mul :: Ptr Z3_context -> Ptr Z3_ast -> Ptr Z3_ast -> Ptr Z3_ast -> IO (Ptr Z3_ast)

foreign import ccall unsafe "Z3_mk_fpa_div"
    z3_mk_fpa_div :: Ptr Z3_context -> Ptr Z3_ast -> Ptr Z3_ast -> Ptr Z3_ast -> IO (Ptr Z3_ast)

foreign import ccall unsafe "Z3_mk_fpa_fma"
    z3_mk_fpa_fma :: Ptr Z3_context -> Ptr Z3_ast -> Ptr Z3_ast -> Ptr Z3_ast -> Ptr Z3_ast -> IO (Ptr Z3_ast)

foreign import ccall unsafe "Z3_mk_fpa_sqrt"
    z3_mk_fpa_sqrt :: Ptr Z3_context -> Ptr Z3_ast -> Ptr Z3_ast -> IO (Ptr Z3_ast)

foreign import ccall unsafe "Z3_mk_fpa_rem"
    z3_mk_fpa_rem :: Ptr Z3_context -> Ptr Z3_ast -> Ptr Z3_ast -> IO (Ptr Z3_ast)

foreign import ccall unsafe "Z3_mk_fpa_round_to_integral"
    z3_mk_fpa_round_to_integral :: Ptr Z3_context -> Ptr Z3_ast -> Ptr Z3_ast -> IO (Ptr Z3_ast)

foreign import ccall unsafe "Z3_mk_fpa_min"
    z3_mk_fpa_min :: Ptr Z3_context -> Ptr Z3_ast -> Ptr Z3_ast -> IO (Ptr Z3_ast)

foreign import ccall unsafe "Z3_mk_fpa_max"
    z3_mk_fpa_max :: Ptr Z3_context -> Ptr Z3_ast -> Ptr Z3_ast -> IO (Ptr Z3_ast)

foreign import ccall unsafe "Z3_mk_fpa_leq"
    z3_mk_fpa_leq :: Ptr Z3_context -> Ptr Z3_ast -> Ptr Z3_ast -> IO (Ptr Z3_ast)

foreign import ccall unsafe "Z3_mk_fpa_lt"
    z3_mk_fpa_lt :: Ptr Z3_context -> Ptr Z3_ast -> Ptr Z3_ast -> IO (Ptr Z3_ast)

foreign import ccall unsafe "Z3_mk_fpa_geq"
    z3_mk_fpa_geq :: Ptr Z3_context -> Ptr Z3_ast -> Ptr Z3_ast -> IO (Ptr Z3_ast)

foreign import ccall unsafe "Z3_mk_fpa_gt"
    z3_mk_fpa_gt :: Ptr Z3_context -> Ptr Z3_ast -> Ptr Z3_ast -> IO (Ptr Z3_ast)

foreign import ccall unsafe "Z3_mk_fpa_eq"
    z3_mk_fpa_eq :: Ptr Z3_context -> Ptr Z3_ast -> Ptr Z3_ast -> IO (Ptr Z3_ast)

foreign import ccall unsafe "Z3_mk_fpa_is_normal"
    z3_mk_fpa_is_normal :: Ptr Z3_context -> Ptr Z3_ast -> IO (Ptr Z3_ast)

foreign import ccall unsafe "Z3_mk_fpa_is_subnormal"
    z3_mk_fpa_is_subnormal :: Ptr Z3_context -> Ptr Z3_ast -> IO (Ptr Z3_ast)

foreign import ccall unsafe "Z3_mk_fpa_is_zero"
    z3_mk_fpa_is_zero :: Ptr Z3_context -> Ptr Z3_ast -> IO (Ptr Z3_ast)

foreign import ccall unsafe "Z3_mk_fpa_is_infinite"
    z3_mk_fpa_is_infinite :: Ptr Z3_context -> Ptr Z3_ast -> IO (Ptr Z3_ast)

foreign import ccall unsafe "Z3_mk_fpa_is_nan"
    z3_mk_fpa_is_nan :: Ptr Z3_context -> Ptr Z3_ast -> IO (Ptr Z3_ast)

foreign import ccall unsafe "Z3_mk_fpa_is_negative"
    z3_mk_fpa_is_negative :: Ptr Z3_context -> Ptr Z3_ast -> IO (Ptr Z3_ast)

foreign import ccall unsafe "Z3_mk_fpa_is_positive"
    z3_mk_fpa_is_positive :: Ptr Z3_context -> Ptr Z3_ast -> IO (Ptr Z3_ast)

foreign import ccall unsafe "Z3_mk_fpa_to_fp_bv"
    z3_mk_fpa_to_fp_bv :: Ptr Z3_context -> Ptr Z3_ast -> Ptr Z3_sort -> IO (Ptr Z3_ast)

foreign import ccall unsafe "Z3_mk_fpa_to_fp_float"
    z3_mk_fpa_to_fp_float :: Ptr Z3_context -> Ptr Z3_ast -> Ptr Z3_ast -> Ptr Z3_sort -> IO (Ptr Z3_ast)

foreign import ccall unsafe "Z3_mk_fpa_to_fp_real"
    z3_mk_fpa_to_fp_real :: Ptr Z3_context -> Ptr Z3_ast -> Ptr Z3_ast -> Ptr Z3_sort -> IO (Ptr Z3_ast)

foreign import ccall unsafe "Z3_mk_fpa_to_fp_signed"
    z3_mk_fpa_to_fp_signed :: Ptr Z3_context -> Ptr Z3_ast -> Ptr Z3_ast -> Ptr Z3_sort -> IO (Ptr Z3_ast)

foreign import ccall unsafe "Z3_mk_fpa_to_fp_unsigned"
    z3_mk_fpa_to_fp_unsigned :: Ptr Z3_context -> Ptr Z3_ast -> Ptr Z3_ast -> Ptr Z3_sort -> IO (Ptr Z3_ast)

foreign import ccall unsafe "Z3_mk_fpa_to_ubv"
    z3_mk_fpa_to_ubv :: Ptr Z3_context -> Ptr Z3_ast -> Ptr Z3_ast -> CUInt -> IO (Ptr Z3_ast)

foreign import ccall unsafe "Z3_mk_fpa_to_sbv"
    z3_mk_fpa_to_sbv :: Ptr Z3_context -> Ptr Z3_ast -> Ptr Z3_ast -> CUInt -> IO (Ptr Z3_ast)

foreign import ccall unsafe "Z3_mk_fpa_to_real"
    z3_mk_fpa_to_real :: Ptr Z3_context -> Ptr Z3_ast -> IO (Ptr Z3_ast)

---------------------------------------------------------------------
-- * Z3-specific floating-point extensions

foreign import ccall unsafe "Z3_fpa_get_ebits"
    z3_fpa_get_ebits :: Ptr Z3_context -> Ptr Z3_sort -> IO CUInt

foreign import ccall unsafe "Z3_fpa_get_sbits"
    z3_fpa_get_sbits :: Ptr Z3_context -> Ptr Z3_sort -> IO CUInt

foreign import ccall unsafe "Z3_fpa_is_numeral_nan"
    z3_fpa_is_numeral_nan :: Ptr Z3_context -> Ptr Z3_ast -> IO Z3_bool

foreign import ccall unsafe "Z3_fpa_is_numeral_inf"
    z3_fpa_is_numeral_inf :: Ptr Z3_context -> Ptr Z3_ast -> IO Z3_bool

foreign import ccall unsafe "Z3_fpa_is_numeral_zero"
    z3_fpa_is_numeral_zero :: Ptr Z3_context -> Ptr Z3_ast -> IO Z3_bool

foreign import ccall unsafe "Z3_fpa_is_numeral_normal"
    z3_fpa_is_numeral_normal :: Ptr Z3_context -> Ptr Z3_ast -> IO Z3_bool

foreign import ccall unsafe "Z3_fpa_is_numeral_subnormal"
    z3_fpa_is_numeral_subnormal :: Ptr Z3_context -> Ptr Z3_ast -> IO Z3_bool

foreign import ccall unsafe "Z3_fpa_is_numeral_positive"
    z3_fpa_is_numeral_positive :: Ptr Z3_context -> Ptr Z3_ast -> IO Z3_bool

foreign import ccall unsafe "Z3_fpa_is_numeral_negative"
    z3_fpa_is_numeral_negative :: Ptr Z3_context -> Ptr Z3_ast -> IO Z3_bool

foreign import ccall unsafe "Z3_fpa_get_numeral_sign_bv"
    z3_fpa_get_numeral_sign_bv :: Ptr Z3_context -> Ptr Z3_ast -> IO (Ptr Z3_ast)

foreign import ccall unsafe "Z3_fpa_get_numeral_significand_bv"
    z3_fpa_get_numeral_significand_bv :: Ptr Z3_context -> Ptr Z3_ast -> IO (Ptr Z3_ast)

foreign import ccall unsafe "Z3_fpa_get_numeral_sign"
    z3_fpa_get_numeral_sign :: Ptr Z3_context -> Ptr Z3_ast -> Ptr CInt -> IO Z3_bool

foreign import ccall unsafe "Z3_fpa_get_numeral_significand_string"
    z3_fpa_get_numeral_significand_string :: Ptr Z3_context -> Ptr Z3_ast -> IO Z3_string

foreign import ccall unsafe "Z3_fpa_get_numeral_significand_uint64"
    z3_fpa_get_numeral_significand_uint64 :: Ptr Z3_context -> Ptr Z3_ast -> Ptr CULong -> IO Z3_bool

foreign import ccall unsafe "Z3_fpa_get_numeral_exponent_string"
    z3_fpa_get_numeral_exponent_string :: Ptr Z3_context -> Ptr Z3_ast -> Z3_bool -> IO Z3_string

foreign import ccall unsafe "Z3_fpa_get_numeral_exponent_int64"
    z3_fpa_get_numeral_exponent_int64 :: Ptr Z3_context -> Ptr Z3_ast -> Ptr CLong -> Z3_bool -> IO Z3_bool

foreign import ccall unsafe "Z3_fpa_get_numeral_exponent_bv"
    z3_fpa_get_numeral_exponent_bv :: Ptr Z3_context -> Ptr Z3_ast -> Z3_bool -> IO (Ptr Z3_ast)

foreign import ccall unsafe "Z3_mk_fpa_to_ieee_bv"
    z3_mk_fpa_to_ieee_bv :: Ptr Z3_context -> Ptr Z3_ast -> IO (Ptr Z3_ast)

foreign import ccall unsafe "Z3_mk_fpa_to_fp_int_real"
    z3_mk_fpa_to_fp_int_real :: Ptr Z3_context -> Ptr Z3_ast -> Ptr Z3_ast -> Ptr Z3_ast -> Ptr Z3_sort -> IO (Ptr Z3_ast)

---------------------------------------------------------------------
-- * Optimization facilities

foreign import ccall unsafe "Z3_mk_optimize"
    z3_mk_optimize :: Ptr Z3_context -> IO (Ptr Z3_optimize)

foreign import ccall unsafe "Z3_optimize_inc_ref"
    z3_optimize_inc_ref :: Ptr Z3_context -> Ptr Z3_optimize -> IO ()

foreign import ccall unsafe "Z3_optimize_dec_ref"
    z3_optimize_dec_ref :: Ptr Z3_context -> Ptr Z3_optimize -> IO ()

foreign import ccall unsafe "Z3_optimize_assert"
    z3_optimize_assert :: Ptr Z3_context -> Ptr Z3_optimize -> Ptr Z3_ast -> IO ()

foreign import ccall unsafe "Z3_optimize_assert_and_track"
    z3_optimize_assert_and_track :: Ptr Z3_context
                                 -> Ptr Z3_optimize
                                 -> Ptr Z3_ast
                                 -> Ptr Z3_ast
                                 -> IO ()

foreign import ccall unsafe "Z3_optimize_assert_soft"
    z3_optimize_assert_soft :: Ptr Z3_context
                            -> Ptr Z3_optimize
                            -> Ptr Z3_ast
                            -> Z3_string
                            -> Ptr Z3_symbol
                            -> IO CUInt

foreign import ccall unsafe "Z3_optimize_maximize"
    z3_optimize_maximize :: Ptr Z3_context
                         -> Ptr Z3_optimize
                         -> Ptr Z3_ast
                         -> IO CUInt

foreign import ccall unsafe "Z3_optimize_minimize"
    z3_optimize_minimize :: Ptr Z3_context
                         -> Ptr Z3_optimize
                         -> Ptr Z3_ast
                         -> IO CUInt

foreign import ccall unsafe "Z3_optimize_push"
    z3_optimize_push :: Ptr Z3_context
                     -> Ptr Z3_optimize
                     -> IO ()

foreign import ccall unsafe "Z3_optimize_pop"
    z3_optimize_pop :: Ptr Z3_context
                    -> Ptr Z3_optimize
                    -> IO ()

foreign import ccall unsafe "Z3_optimize_check"
    z3_optimize_check :: Ptr Z3_context
                      -> Ptr Z3_optimize
                      -> CUInt
                      -> Ptr (Ptr Z3_ast)
                      -> IO Z3_lbool

foreign import ccall unsafe "Z3_optimize_get_reason_unknown"
    z3_optimize_get_reason_unknown :: Ptr Z3_context
                                   -> Ptr Z3_optimize
                                   -> IO Z3_string

foreign import ccall unsafe "Z3_optimize_get_model"
    z3_optimize_get_model :: Ptr Z3_context
                          -> Ptr Z3_optimize
                          -> IO (Ptr Z3_model)

foreign import ccall unsafe "Z3_optimize_get_unsat_core"
    z3_optimize_get_unsat_core :: Ptr Z3_context
                               -> Ptr Z3_optimize
                               -> IO (Ptr Z3_ast_vector)

foreign import ccall unsafe "Z3_optimize_set_params"
    z3_optimize_set_params :: Ptr Z3_context
                           -> Ptr Z3_optimize
                           -> Ptr Z3_params
                           -> IO ()

foreign import ccall unsafe "Z3_optimize_get_param_descrs"
    z3_optimize_get_param_descrs :: Ptr Z3_context
                                 -> Ptr Z3_optimize
                                 -> IO (Ptr Z3_param_descrs)

foreign import ccall unsafe "Z3_optimize_get_lower"
    z3_optimize_get_lower :: Ptr Z3_context
                          -> Ptr Z3_optimize
                          -> CUInt
                          -> IO (Ptr Z3_ast)

foreign import ccall unsafe "Z3_optimize_get_upper"
    z3_optimize_get_upper :: Ptr Z3_context
                          -> Ptr Z3_optimize
                          -> CUInt
                          -> IO (Ptr Z3_ast)

foreign import ccall unsafe "Z3_optimize_get_lower_as_vector"
    z3_optimize_get_lower_as_vector :: Ptr Z3_context
                                    -> Ptr Z3_optimize
                                    -> CUInt
                                    -> IO (Ptr Z3_ast_vector)

foreign import ccall unsafe "Z3_optimize_get_upper_as_vector"
    z3_optimize_get_upper_as_vector :: Ptr Z3_context
                                    -> Ptr Z3_optimize
                                    -> CUInt
                                    -> IO (Ptr Z3_ast_vector)

foreign import ccall unsafe "Z3_optimize_to_string"
    z3_optimize_to_string :: Ptr Z3_context
                          -> Ptr Z3_optimize
                          -> IO Z3_string

foreign import ccall unsafe "Z3_optimize_from_string"
    z3_optimize_from_string :: Ptr Z3_context
                            -> Ptr Z3_optimize
                            -> Z3_string
                            -> IO ()

foreign import ccall unsafe "Z3_optimize_from_file"
    z3_optimize_from_file :: Ptr Z3_context
                          -> Ptr Z3_optimize
                          -> Z3_string
                          -> IO ()

foreign import ccall unsafe "Z3_optimize_get_help"
    z3_optimize_get_help :: Ptr Z3_context
                         -> Ptr Z3_optimize
                         -> IO Z3_string

foreign import ccall unsafe "Z3_optimize_get_statistics"
    z3_optimize_get_statistics :: Ptr Z3_context
                               -> Ptr Z3_optimize
                               -> IO (Ptr Z3_stats)

foreign import ccall unsafe "Z3_optimize_get_assertions"
    z3_optimize_get_assertions :: Ptr Z3_context
                               -> Ptr Z3_optimize
                               -> IO (Ptr Z3_ast_vector)

foreign import ccall unsafe "Z3_optimize_get_objectives"
    z3_optimize_get_objectives :: Ptr Z3_context
                               -> Ptr Z3_optimize
                               -> IO (Ptr Z3_ast_vector)

---------------------------------------------------------------------
-- * Polynomials

foreign import ccall unsafe "Z3_polynomial_subresultants"
    z3_polynomial_subresultants :: Ptr Z3_context
                                -> Ptr Z3_ast
                                -> Ptr Z3_ast
                                -> Ptr Z3_ast
                                -> IO (Ptr Z3_ast_vector)

---------------------------------------------------------------------
-- * Real Closed Fields

foreign import ccall unsafe "Z3_rcf_del"
    z3_rcf_del :: Ptr Z3_context
               -> Ptr Z3_rcf_num
               -> IO ()

foreign import ccall unsafe "Z3_rcf_mk_rational"
    z3_rcf_mk_rational :: Ptr Z3_context
                       -> Z3_string
                       -> IO (Ptr Z3_rcf_num)

foreign import ccall unsafe "Z3_rcf_mk_small_int"
    z3_rcf_mk_small_int :: Ptr Z3_context
                        -> CInt
                        -> IO (Ptr Z3_rcf_num)

foreign import ccall unsafe "Z3_rcf_mk_pi"
    z3_rcf_mk_pi :: Ptr Z3_context
                 -> IO (Ptr Z3_rcf_num)

foreign import ccall unsafe "Z3_rcf_mk_e"
    z3_rcf_mk_e :: Ptr Z3_context
                -> IO (Ptr Z3_rcf_num)

foreign import ccall unsafe "Z3_rcf_mk_infinitesimal"
    z3_rcf_mk_infinitesimal :: Ptr Z3_context
                            -> IO (Ptr Z3_rcf_num)

foreign import ccall unsafe "Z3_rcf_mk_roots"
    z3_rcf_mk_roots :: Ptr Z3_context
                    -> CUInt
                    -> Ptr (Ptr Z3_rcf_num)
                    -> Ptr (Ptr Z3_rcf_num)
                    -> IO CUInt

foreign import ccall unsafe "Z3_rcf_add"
    z3_rcf_add :: Ptr Z3_context
               -> Ptr Z3_rcf_num
               -> Ptr Z3_rcf_num
               -> IO (Ptr Z3_rcf_num)

foreign import ccall unsafe "Z3_rcf_sub"
    z3_rcf_sub :: Ptr Z3_context
               -> Ptr Z3_rcf_num
               -> Ptr Z3_rcf_num
               -> IO (Ptr Z3_rcf_num)

foreign import ccall unsafe "Z3_rcf_mul"
    z3_rcf_mul :: Ptr Z3_context
               -> Ptr Z3_rcf_num
               -> Ptr Z3_rcf_num
               -> IO (Ptr Z3_rcf_num)

foreign import ccall unsafe "Z3_rcf_div"
    z3_rcf_div :: Ptr Z3_context
               -> Ptr Z3_rcf_num
               -> Ptr Z3_rcf_num
               -> IO (Ptr Z3_rcf_num)

foreign import ccall unsafe "Z3_rcf_neg"
    z3_rcf_neg :: Ptr Z3_context
               -> Ptr Z3_rcf_num
               -> IO (Ptr Z3_rcf_num)

foreign import ccall unsafe "Z3_rcf_inv"
    z3_rcf_inv :: Ptr Z3_context
               -> Ptr Z3_rcf_num
               -> IO (Ptr Z3_rcf_num)

foreign import ccall unsafe "Z3_rcf_power"
    z3_rcf_power :: Ptr Z3_context
                 -> Ptr Z3_rcf_num
                 -> CUInt
                 -> IO (Ptr Z3_rcf_num)

foreign import ccall unsafe "Z3_rcf_lt"
    z3_rcf_lt :: Ptr Z3_context
              -> Ptr Z3_rcf_num
              -> Ptr Z3_rcf_num
              -> IO Z3_bool

foreign import ccall unsafe "Z3_rcf_gt"
    z3_rcf_gt :: Ptr Z3_context
              -> Ptr Z3_rcf_num
              -> Ptr Z3_rcf_num
              -> IO Z3_bool

foreign import ccall unsafe "Z3_rcf_le"
    z3_rcf_le :: Ptr Z3_context
              -> Ptr Z3_rcf_num
              -> Ptr Z3_rcf_num
              -> IO Z3_bool

foreign import ccall unsafe "Z3_rcf_ge"
    z3_rcf_ge :: Ptr Z3_context
              -> Ptr Z3_rcf_num
              -> Ptr Z3_rcf_num
              -> IO Z3_bool

foreign import ccall unsafe "Z3_rcf_eq"
    z3_rcf_eq :: Ptr Z3_context
              -> Ptr Z3_rcf_num
              -> Ptr Z3_rcf_num
              -> IO Z3_bool

foreign import ccall unsafe "Z3_rcf_neq"
    z3_rcf_neq :: Ptr Z3_context
               -> Ptr Z3_rcf_num
               -> Ptr Z3_rcf_num
               -> IO Z3_bool

foreign import ccall unsafe "Z3_rcf_num_to_string"
    z3_rcf_num_to_string :: Ptr Z3_context
                         -> Ptr Z3_rcf_num
                         -> IO Z3_string

foreign import ccall unsafe "Z3_rcf_num_to_decimal_string"
    z3_rcf_num_to_decimal_string :: Ptr Z3_context
                                 -> Ptr Z3_rcf_num
                                 -> CUInt
                                 -> IO Z3_string

foreign import ccall unsafe "Z3_rcf_get_numerator_denominator"
    z3_rcf_get_numerator_denominator :: Ptr Z3_context
                                     -> Ptr Z3_rcf_num
                                     -> Ptr (Ptr Z3_rcf_num)
                                     -> Ptr (Ptr Z3_rcf_num)
                                     -> IO ()
