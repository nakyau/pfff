open Common

open Ast_pic
module Ast = Ast_pic
module Flag = Flag_parsing_pic

open OUnit

(*****************************************************************************)
(* Subsystem testing *)
(*****************************************************************************)

let test_tokens_pic file = 
  (match File_type.file_type_of_file file with
  | File_type.PL (File_type.Lisp _) -> ()
  | _ -> pr2 "warning: seems not a pic file";
  );

  Flag.verbose_lexing := true;
  Flag.verbose_parsing := true;

  let toks = Parse_pic.tokens file in
  toks +> List.iter (fun x -> pr2_gen x);
  ()

(*****************************************************************************)
(* Unit tests *)
(*****************************************************************************)

(*****************************************************************************)
(* Main entry for Arg *)
(*****************************************************************************)

let actions () = [
  "-tokens_pic", "   <file>", 
  Common.mk_action_1_arg test_tokens_pic;
]
