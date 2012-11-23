open Common

open Ast_pic
module Ast = Ast_pic
module Flag = Flag_parsing_pic

open OUnit

(*****************************************************************************)
(* Subsystem testing *)
(*****************************************************************************)

let test_tokens_pic file = 
  if not (file =~ ".*\\.pic") 
  then pr2 "warning: seems not a .pic file";

  Flag.verbose_lexing := true;
  Flag.verbose_parsing := true;

  let toks = Parse_pic.tokens file in
  toks +> List.iter (fun x -> pr2_gen x);
  ()


let test_parse_pic xs  =
  let ext = ".*\\.\\(pic\\|javascript\\)$" in

  (* could now use Lib_parsing_php.find_php_files_of_dir_or_files *)
  let fullxs = Common.files_of_dir_or_files_no_vcs_post_filter ext xs in

  let stat_list = ref [] in

  Common.check_stack_nbfiles (List.length fullxs);

  fullxs +> List.iter (fun file -> 
    pr2 ("PARSING: " ^ file);

    if file =~ ".*/third_party" || file =~ ".*/wiki/extensions"
    then pr2 "IGNORING third party directory, bad unicode chars"
    else begin

      let (xs, stat) = Parse_pic.parse file in
      Common.push2 stat stat_list;
    end
  );
  Parse_info.print_parsing_stat_list !stat_list;
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

  "-parse_pic", "   <file>", 
  Common.mk_action_n_arg test_parse_pic;

]
