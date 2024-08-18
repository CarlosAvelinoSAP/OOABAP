CLASS zcl_991_addressing_data_ref DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_991_ADDRESSING_DATA_REF IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    "Creating data reference variables and assign values

    DATA(ref_i)    = NEW i( 1 ).
    DATA(ref_carr) = NEW zdemo_abap_carr( carrid = 'LH' carrname = 'Lufthansa' ).
    DATA(ref_carr2) = NEW zdemo_abap_carr( carrid = 'LH'   ).
    out->write( ref_carr2->* ).

    "Generic type

    DATA ref_gen TYPE REF TO data.
    ref_gen = ref_i.                "Copying reference

    "Accessing

    "Variable number receives the content.
    DATA(number) = ref_i->*.

    "Content of referenced data object is changed.
    ref_i->* = 10.

    "Data reference used in a logical expression.
    IF ref_i->* > 5.
      ...
    ENDIF.

    "Dereferenced generic type
    DATA(calc) = 1 + ref_gen->*.

    "Structure
    "Complete structure
    DATA(struc) = ref_carr->*.

    "When dereferencing a data reference variable that has a structured
    "data type, you can use the component selector -> to address individual components
    DATA(carrid) = ref_carr->carrid.
    ref_carr->carrid = 'UA'.

    "This longer syntax with the dereferencing operator also works.
    ref_carr->*-carrname = 'United Airlines'.

    "Checking if a data reference variable can be dereferenced.
    IF ref_carr IS BOUND.
      ...
    ENDIF.

    DATA(ref_bound) = COND #( WHEN ref_carr IS BOUND THEN ref_carr->carrid ELSE `is not bound` ).

    "Explicitly removing a reference
    "However, the garbage collector takes care of removing the references
    "automatically once the data is not used any more by a reference.
    CLEAR ref_carr.

  ENDMETHOD.
ENDCLASS.
