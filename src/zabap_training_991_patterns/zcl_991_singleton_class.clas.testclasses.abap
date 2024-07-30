*"* use this source file for your ABAP unit test classes
CLASS ZCL_991_SINGLETON_CLASS_Test DEFINITION.
  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PRIVATE SECTION.
    ALIASES run FOR if_oo_adt_classrun~main.
    CLASS-DATA inst1 type REF TO zcl_991_singleton_class.
    CLASS-DATA inst2 type REF TO zcl_991_singleton_class.
ENDCLASS.


CLASS ZCL_991_SINGLETON_CLASS_Test IMPLEMENTATION.

  METHOD run.

    inst1 = new #(  ).
    inst2 = new #(  ).

    ASSERT inst1 = inst2.

  ENDMETHOD.

ENDCLASS.
