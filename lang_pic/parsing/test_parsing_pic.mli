(* Print the set of tokens in a .pic file *)
val test_tokens_pic : Common.filename -> unit

(* This makes accessible the different test_xxx functions above from 
 * the command line, e.g. '$ pfff -parse_pic foo.pic will call the 
 * test_parse_pic function.
 *)
val actions : unit -> Common.cmdline_actions
