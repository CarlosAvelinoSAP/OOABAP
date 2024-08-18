CLASS zcl_991_sql_intersect DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
    ALIASES run FOR if_oo_adt_classrun~main.
ENDCLASS.



CLASS ZCL_991_SQL_INTERSECT IMPLEMENTATION.


  METHOD run.
    "If you have imported the cheat sheet repository and already run an example class to fill
    "the demo tables, you can check the contents of the result sets.
    SELECT zdemo_abap_flsch~carrid AS carrid, zdemo_abap_carr~carrname AS carrname
        FROM zdemo_abap_flsch
        INNER JOIN zdemo_abap_carr ON zdemo_abap_carr~carrid = zdemo_abap_flsch~carrid
        ORDER BY zdemo_abap_flsch~carrid
        INTO TABLE @DATA(itab_no_intersect).
    out->write( `Início relatório` ).
    out->write( itab_no_intersect ).
    "Using INTERSECT; the result set contains distinct rows
    SELECT zdemo_abap_flsch~carrid, zdemo_abap_carr~carrname
        FROM zdemo_abap_flsch
        INNER JOIN zdemo_abap_carr ON zdemo_abap_carr~carrid = zdemo_abap_flsch~carrid
    INTERSECT
    SELECT carrid, carrname
        FROM zdemo_abap_carr
        ORDER BY carrid
        INTO TABLE @DATA(itab_w_intersect).
    out->write( itab_w_intersect ).

    IF ( 0 < lines( itab_w_intersect ) ).
      out->write( `No rows!` ).
    ENDIF.

    DATA(teste) = COND string( WHEN 0 < lines( itab_no_intersect ) THEN `Há linhas!` ELSE `No rows!` ).
    out->write( teste ).

    out->write( COND string( WHEN 0 < lines( itab_no_intersect ) THEN `Há linhas!` ELSE `No rows!` ) ).

  ENDMETHOD.
ENDCLASS.
