open OUnit
open Awesome

let suite = "OUnit tests..." >:::  ["test_list_length" >::
                                    (fun () -> assert_equal "1" (str_of_t (succ one_t)))]

let _ = 
  run_test_tt_main suite
