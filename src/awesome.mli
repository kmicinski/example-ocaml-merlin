(**
   An abstract type
*)
type t

(**
   An example element of type [t]
*)
val one_t : t

(**
   The successor of [t]
*)
val succ : t -> t

(** 
   Turn a [t] into a [string]
*)
val str_of_t : t -> string
