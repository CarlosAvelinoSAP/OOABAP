CLASS zcl_991_gen_data_ref_f_symb DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_991_GEN_DATA_REF_F_SYMB IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    "Non-generic type
    DATA ref_int TYPE REF TO i.
    ref_int = NEW #( ).
    ref_int->* = 123.

    "Generic type
    DATA ref_generic TYPE REF TO data.
    ref_generic = NEW i( ). "Syntax in modern ABAP
    CREATE DATA ref_generic TYPE i. "Syntax for older ABAP releases

    "As mentioned above, the content of anonymous data objects can only be
    "accessed using dereferenced data variables and field symbols.
    "The only option to access the variable in older releases was via field symbols.
    ASSIGN ref_generic->* TO FIELD-SYMBOL(<fs_generic>).
    <fs_generic> = 123.

    "An access as the following, as it is possible in modern ABAP, was not possible.
    ref_generic->* = 123.

    "In modern ABAP, variables and field symbols of the generic types
    "'any' and 'data' can be used directly, for example, in LOOP and READ statements.
    DATA dref TYPE REF TO data.
    CREATE DATA dref TYPE TABLE OF zdemo_abap_carr.
    SELECT *
      FROM zdemo_abap_carr
      INTO TABLE @dref->*.

    "Note: In case of a fully generic type, an explicit or implicit index operation
    "is not possible (indicated by the examples commented out).
    LOOP AT dref->* ASSIGNING FIELD-SYMBOL(<loop>).
      ...
    ENDLOOP.
    "LOOP AT dref->* ASSIGNING FIELD-SYMBOL(<loop2>) FROM 1 TO 4.
    "ENDLOOP.

    "The following examples use a dynamic key specification.
    "See more syntax examples below.
    TRY.
        READ TABLE dref->* ASSIGNING FIELD-SYMBOL(<read>) WITH KEY ('CARRID') = 'AA'.
      CATCH cx_sy_itab_line_not_found .
        out->write( |Ocorreu um erro| ).
    ENDTRY.
    "READ TABLE dref->* INDEX 1 ASSIGNING FIELD-SYMBOL(<read2>).

    "Table expressions
    TRY.
        DATA(line) = CONV zdemo_abap_carr( dref->*[ ('CARRID') = 'AA' ] ).
        dref->*[ ('CARRID') = 'AA' ] = VALUE zdemo_abap_carr( BASE dref->*[ ('CARRID') = 'AA' ] carrid = 'XY' ).
        dref->*[ ('CARRID') = 'XY' ]-('CARRID') = 'ZZ'.
      CATCH cx_sy_itab_line_not_found .
        out->write( |Ocorreu um erro| ).
    ENDTRY.
    "Table functions
    DATA(num_tab_lines) = lines( dref->* ).
    DATA(idx) = line_index( dref->*[ ('CARRID') = 'LH' ] ).


  ENDMETHOD.
ENDCLASS.
