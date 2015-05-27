(*
  An example project that uses merlin
*)
module A = Awesome

let _ = 
  Printf.printf "hello\nConverted to string we get: %s\n" 
    (A.str_of_t (A.succ A.one_t));
