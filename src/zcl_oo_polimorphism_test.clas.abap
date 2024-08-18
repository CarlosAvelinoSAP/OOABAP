CLASS zcl_oo_polimorphism_test DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
    ALIASES main FOR if_oo_adt_classrun~main.
ENDCLASS.



CLASS ZCL_OO_POLIMORPHISM_TEST IMPLEMENTATION.


  METHOD main.
    "Creating object references
    DATA(oref_super) = NEW zcl_oo_polimorphism_super( ).

    DATA(oref_sub) = NEW zcl_oo_polimorphism_sub( ).
    DATA(oref_sub2) = NEW zcl_oo_polimorphism_sub2( ).
    "Upcast
    oref_super = oref_sub.

    "The casting might be done when creating the object.
    DATA super_ref TYPE REF TO zcl_oo_polimorphism_super.

    super_ref = NEW zcl_oo_polimorphism_sub( ).

    "Downcast impossible (oref_sub is more specific than oref_super);
    "the exception is caught here
    TRY.
        oref_sub = CAST #( oref_super ).
      CATCH cx_sy_move_cast_error INTO DATA(e).
        out->write( |Ocorreu o erro: { e->textid } | ).
    ENDTRY.

    "Working downcast with a prior upcast
    oref_super = oref_sub2.

    "Due to the prior upcast, the following check is actually not necessary.

    IF oref_super IS INSTANCE OF zcl_oo_polimorphism_sub.
      oref_sub = CAST #( oref_super ).
      ...
    ENDIF.

  ENDMETHOD.
ENDCLASS.
