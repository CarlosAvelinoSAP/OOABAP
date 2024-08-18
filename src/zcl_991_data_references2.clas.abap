CLASS zcl_991_data_references2 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_991_DATA_REFERENCES2 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    "CREATE DATA statements
    "Note that there are many additions available. The examples
    "show a selection. Behind TYPE and LIKE, the syntax offers
    "the same possibilities as the DATA statement.

    "Creating an anonymous data object with an implicit type.
    "If neither of the additions TYPE or LIKE are specified, the
    "data reference variable must be completely typed.
    DATA dref_1 TYPE REF TO string.
    CREATE DATA dref_1.

    "Creating anonymous data objects with explicit data type
    "specification.
    "Data reference variable with a generic type to be used in
    "the following examples for the anonymous data object.
    DATA dref_2 TYPE REF TO data.

    "Elementary, built-in ABAP type
    CREATE DATA dref_2 TYPE p LENGTH 8 DECIMALS 3.

    "Anomyous internal table ...
    "using the LIKE addition to refer to an existing internal table
    DATA itab TYPE TABLE OF zdemo_abap_carr.
    CREATE DATA dref_2 LIKE itab.

    "by specifying the entire table type
    CREATE DATA dref_2 TYPE HASHED TABLE OF zdemo_abap_carr
      WITH UNIQUE KEY carrid.

    "Anonymous structures
    CREATE DATA dref_2 LIKE LINE OF itab.
    CREATE DATA dref_2 TYPE zdemo_abap_carr.

    "Creating reference variable
*    CREATE DATA dref_2 TYPE REF TO itab.

    "NEW operator
    "- Works like CREATE DATA dref TYPE type statements and can
    "  be used in general expression positions.
    "- Allows to assign values to the new anonymous data objects
    "  in parentheses

    "Creating data reference variables
    DATA: dref_3 TYPE REF TO i,
          dref_4 TYPE REF TO data.

    "# character after NEW if the data type can be identified
    "completely instead of the explicit type specification (only
    "non-generic types possible)
    dref_3 = NEW #( 123 ).
    dref_3 = NEW i( 456 ).
    dref_4 = NEW zdemo_abap_carr( ). "not assigning any values
    dref_4 = NEW string( `hi` ).

    "Creating anonymous data objects inline
    "In doing so, you can omit a prior declaration of a variable.
    DATA(dref_5) = NEW i( 789 ).
    DATA(dref_6) = NEW zdemo_abap_carr( carrid   = 'AB'
                                        carrname = 'AB Airlines' ).

    "ABAP SQL SELECT statements
    "Using the NEW addition in the INTO clause, an anonymous data
    "object can be created in place.
    SELECT *
      FROM zdemo_abap_carr
      INTO TABLE NEW @DATA(dref_7). "internal table

    SELECT SINGLE *
      FROM zdemo_abap_carr
      INTO NEW @DATA(dref_8). "structure

  ENDMETHOD.
ENDCLASS.
