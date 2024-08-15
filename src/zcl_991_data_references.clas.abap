CLASS zcl_991_data_references DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_991_data_references IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    "Declaring a data object
    DATA num TYPE i VALUE 5.

    "Declaring data reference variables
    DATA ref1    TYPE REF TO i.
    DATA ref_gen TYPE REF TO data.

    "Creating data references to data objects.
    "The # character stands for a data type that is determined in the
    "following hierarchy:
    "- If the data type required in an operand position is unique and
    "  known completely, the operand type is used.
    "- If the operand type cannot be derived from the context, the
    "  data type of the data object within the parentheses is used.
    "- If the data type of the data object within the parentheses is
    "  not known statically, the generic type data is used.

    ref1    = REF #( num ).
    ref_gen = REF #( num ).

    "Creating a data reference variable inline.
    "Note: No empty parentheses can be specified after REF.
    DATA(ref2) = REF #( num ).

    "Data reference variable of type ref to data by specifying the
    "generic type data after REF
*DATA(ref3) = REF data( ... ).

    "A non-generic type can be used; only if an upcast works (see
    "upcasts below)
*DATA(ref3) = REF some_type( ... ).

    "The older syntax GET REFERENCE having the same effect should
    "not be used anymore.
    "GET REFERENCE OF num INTO ref1.
    "GET REFERENCE OF num INTO DATA(ref5).


  ENDMETHOD.
ENDCLASS.
