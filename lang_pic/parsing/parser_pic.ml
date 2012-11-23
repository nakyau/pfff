(* Yoann Padioleau
 *
 * Copyright (C) 2010 Facebook
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public License
 * version 2.1 as published by the Free Software Foundation, with the
 * special exception on linking described in file license.txt.
 * 
 * This library is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the file
 * license.txt for more details.
 *)

open Common

(*****************************************************************************)
(* Types *)
(*****************************************************************************)

type token =
  | TComment of (Ast_pic.info)
  | TCommentSpace of (Ast_pic.info)
  | TCommentNewline of (Ast_pic.info)

  | TNumber of (string * Ast_pic.info)
  | TIdent of (string * Ast_pic.info)
  | TString of (string * Ast_pic.info)

  | TOParen of (Ast_pic.info)
  | TCParen of (Ast_pic.info)
  | TOBracket of (Ast_pic.info)
  | TCBracket of (Ast_pic.info)

  | TQuote of (Ast_pic.info)
  (* anti-quote expressions tokens, as in `(foo ,v ,@xs) *)
  | TBackQuote of (Ast_pic.info)
  | TComma  of (Ast_pic.info)
  | TAt  of (Ast_pic.info)

  | TUnknown of (Ast_pic.info)
  | EOF of (Ast_pic.info)

(*****************************************************************************)
(* Token Helpers *)
(*****************************************************************************)

let is_eof = function
  | EOF _ -> true
  | _ -> false

(* PIC has not token of comment *)
let is_comment = false

let is_just_comment = false

(*****************************************************************************)
(* Visitors *)
(*****************************************************************************)
let visitor_info_of_tok f = function
  | TComment ii -> TComment (f ii)
  | TCommentSpace ii -> TCommentSpace (f ii)
  | TCommentNewline ii -> TCommentNewline (f ii)

  | TNumber (s, ii) -> TNumber (s, f ii)
  | TIdent (s, ii) -> TIdent (s, f ii)
  | TString (s, ii) -> TString (s, f ii)

  | TOParen ii -> TOParen (f ii)
  | TCParen ii -> TCParen (f ii)
  | TOBracket ii -> TOBracket (f ii)
  | TCBracket ii -> TCBracket (f ii)

  | TQuote ii -> TQuote (f ii)
  | TBackQuote ii -> TBackQuote (f ii)
  | TComma ii -> TComma (f ii)
  | TAt ii -> TAt (f ii)

  | TUnknown ii -> TUnknown (f ii)
  | EOF ii -> EOF (f ii)

let info_of_tok tok = 
  let res = ref None in
  visitor_info_of_tok (fun ii -> res := Some ii; ii) tok +> ignore;
  Common.some !res
