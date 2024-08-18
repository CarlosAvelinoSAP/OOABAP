CLASS zcl_991_singleton_class_test DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
    ALIASES run FOR if_oo_adt_classrun~main.
    CLASS-DATA inst1 TYPE REF TO zcl_991_singleton_class.
    CLASS-DATA inst2 TYPE REF TO zcl_991_singleton_class.
ENDCLASS.



CLASS ZCL_991_SINGLETON_CLASS_TEST IMPLEMENTATION.


  METHOD run.

    inst1 = NEW #(  ).
    inst2 = NEW #(  ).

    out->write( COND String( WHEN inst1 = inst2 THEN |iguais| ELSE |diferentes|  ) ).

  ENDMETHOD.
ENDCLASS.
