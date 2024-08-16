CLASS zcl_991_data_references3 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_991_data_references3 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    DATA oref_a TYPE REF TO lclsomeclass.
    oref_a = NEW #( ).
    "Using inline declaration
    DATA(oref_b) = NEW lclsomeclass( ).
    "Generic type
    DATA oref_c TYPE REF TO object.
    oref_c = NEW lclsomeclass( ).

    "This object creation with the NEW operator corresponds to the older
    "syntax using CREATE OBJECT, and replaces it. See more examples in the
    "context of dynamic object creation that require the CREATE OBJECT
    "syntax further down.
    DATA oref_d TYPE REF TO lclsomeclass.
    CREATE OBJECT oref_d.
    DATA oref_e TYPE REF TO object.
    CREATE OBJECT oref_e TYPE lclsomeclass.


  ENDMETHOD.
ENDCLASS.
