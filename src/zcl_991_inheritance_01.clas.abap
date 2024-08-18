CLASS zcl_991_inheritance_01 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_991_INHERITANCE_01 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    "Creating object references
    DATA(orefSuper) = NEW lclSuper( ).
    DATA(orefSuper2) = NEW lclSuper( ).

    DATA(orefSub) = NEW lclSub( ).

    "Upcast
    orefSuper = orefSub.

    "Downcast
    "This not work
    TRY.
*        orefSub ?= orefSuper2.
        orefSub = cast lclsub( orefSuper2 ).
      CATCH cx_sy_move_cast_error .
        out->write( |Ocorreu um erro na operação cast| ).
    ENDTRY.
    "The casting might be done when creating the object.
    DATA superRef TYPE REF TO lclSuper.

    superRef = NEW lclSub( ).
**********************************************************************
*    Downcast
    DATA(oref_super) = NEW lclSuper( ).
    DATA(oref_sub) = NEW lclSub( ).
    DATA(oref_sub2) = NEW lclSub2( ).

    "Downcast impossible (oref_sub is more specific than oref_super);
    "the exception is caught here

    TRY.
        oref_sub = CAST #( oref_super ).
      CATCH cx_sy_move_cast_error INTO DATA(e).
        ...
    ENDTRY.

    "Working downcast with a prior upcast

    oref_super = oref_sub2.

    "Due to the prior upcast, the following check is actually not necessary.

    IF oref_super IS INSTANCE OF lclSub.
      oref_sub = CAST #( oref_super ).
      ...
    ENDIF.

    "Excursion RTTI: Downcasts, CAST and method chaining
    "Downcasts particularly play, for example, a role in the context of
    "retrieving type information using RTTI. Method chaining is handy
    "because it reduces the lines of code in this case.
    "The example below shows the retrieval of type information
    "regarding the components of a structure.
    "Due to the method chaining in the second example, the three
    "statements in the first example are reduced to one statement.

    DATA struct4cast TYPE zdemo_abap_carr.

    DATA(rtti_a) = cl_abap_typedescr=>describe_by_data( struct4cast ).
    DATA(rtti_b) = CAST cl_abap_structdescr( rtti_a ).
    DATA(rtti_c) = rtti_b->components.

    DATA(rtti_d) = CAST cl_abap_structdescr(
      cl_abap_typedescr=>describe_by_data( struct4cast )
          )->components.

  ENDMETHOD.
ENDCLASS.
