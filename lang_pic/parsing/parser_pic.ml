type token =
  | TComment of (Ast_pic.info)
  | TCommentSpace of (Ast_pic.info)
  | TCommentNewline of (Ast_pic.info)

  | TNumber of (string * Ast_pic.info)
  | TOParen of (Ast_pic.info)
  | TCParen of (Ast_pic.info)

  | TUnknown of (Ast_pic.info)
  | EOF of (Ast_pic.info)
