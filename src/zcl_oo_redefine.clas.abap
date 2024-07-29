CLASS zcl_oo_redefine DEFINITION INHERITING FROM zcl_oo_abstract
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
    METHODS meth REDEFINITION.
  PRIVATE SECTION.
    CLASS-DATA intG type i.
ENDCLASS.



CLASS zcl_oo_redefine IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
  me->meth(  ).
  out->write( | intG = {  intG } | ).
  ENDMETHOD.
  METHOD meth.
    intG += 1.
  ENDMETHOD.

ENDCLASS.
