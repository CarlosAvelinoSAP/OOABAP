CLASS zcl_991_sql_except DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
    ALIASES run FOR if_oo_adt_classrun~main.
ENDCLASS.



CLASS zcl_991_sql_except IMPLEMENTATION.


  METHOD run.
    "Selecting all carrier IDs from a database table that do not exist in an
    "internal table
    TYPES: ty_demo_tab TYPE TABLE OF zdemo_abap_flsch WITH EMPTY KEY.
    DATA(itab) = VALUE ty_demo_tab( ( carrid = 'LH' ) ( carrid = 'LH' ) ( carrid = 'LH' )
                                    ( carrid = 'AA' ) ( carrid = 'AA' ) ).
    out->write( `-------------itab-------------------` ).
    out->write( itab ).
    "Selecting all carrier IDs for comparison
    SELECT carrid
        FROM zdemo_abap_carr
        INTO TABLE @DATA(all_carrids).
    out->write( `----------all carrids------------------` ).
    out->write( COND #( WHEN 0 < lines( all_carrids ) THEN all_carrids ) ).
    "Using EXCEPT; the result set excludes those carrier IDs present in the
    "internal table
    SELECT carrid
        FROM zdemo_abap_carr
        EXCEPT
            SELECT it~carrid
            FROM @itab AS it
                INNER JOIN zdemo_abap_carr ON zdemo_abap_carr~carrid = it~carrid
        ORDER BY carrid ASCENDING
        INTO TABLE @DATA(itab_w_except).
    out->write( itab_w_except ).

    SELECT FROM zdemo_abap_flsch FIELDS * INTO TABLE @DATA(itab_flsch).
    out->write( `---------itab_flsch--------` ).
    out->write( itab_flsch ).

    SELECT
        FROM zdemo_abap_flsch
        FIELDS *
        WHERE EXISTS ( SELECT FROM @itab AS tabItab FIELDS carrid WHERE carrid = 'LH' )
        INTO TABLE @DATA(itabFLSCH).
    out->write( `==============itabFLSCH==============` ).
    out->write( itabFLSCH ).

  ENDMETHOD.
ENDCLASS.
