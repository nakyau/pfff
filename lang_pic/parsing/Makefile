TOP=../..
##############################################################################
# Variables
##############################################################################
TARGET=lib

-include $(TOP)/Makefile.config

SRC= flag_parsing_pic.ml \
     ast_pic.ml \
     ast_scheme.ml \
     parser_pic.ml lexer_pic.ml \
     parse_pic.ml \
     test_parsing_pic.ml

#     unparse_js.ml \
#     meta_ast_js.ml \
#     export_ast_js.ml \
#     visitor_js.ml lib_parsing_js.ml \


SYSLIBS= str.cma unix.cma 

# globals.cma is used only for Config.patch in test_parse_nw
LIBS=$(TOP)/commons/commons.cma \
 $(TOP)/globals/globals.cma \
 $(TOP)/h_program-lang/lib.cma \

INCLUDEDIRS= $(TOP)/commons $(TOP)/commons/ocamlextra \
  $(TOP)/commons/lib-sexp $(TOP)/commons/lib-json \
  $(TOP)/globals \
  $(TOP)/h_program-lang \

##############################################################################
# Generic variables
##############################################################################

-include $(TOP)/Makefile.common

##############################################################################
# Top rules
##############################################################################
all:: $(TARGET).cma
all.opt:: $(TARGET).cmxa

$(TARGET).cma: $(OBJS)
	$(OCAMLC) -a -o $(TARGET).cma $(OBJS)

$(TARGET).cmxa: $(OPTOBJS) $(LIBS:.cma=.cmxa)
	$(OCAMLOPT) -a -o $(TARGET).cmxa $(OPTOBJS)

$(TARGET).top: $(OBJS) $(LIBS)
	$(OCAMLMKTOP) -o $(TARGET).top $(SYSLIBS) $(LIBS) $(OBJS)

clean::
	rm -f $(TARGET).top


lexer_pic.ml: lexer_pic.mll
	$(OCAMLLEX) $<
clean::
	rm -f lexer_pic.ml
beforedepend:: lexer_pic.ml


#parser_nw.ml parser_nw.mli: parser_nw.mly
#	$(OCAMLYACC) $<
#clean::
#	rm -f parser_nw.ml parser_nw.mli parser_nw.output
#beforedepend:: parser_nw.ml parser_nw.mli
#
#
#visitor_nw.cmo: visitor_nw.ml
#	$(OCAMLC) -w y -c $<

##############################################################################
# Generic rules
##############################################################################

##############################################################################
# Literate Programming rules
##############################################################################
