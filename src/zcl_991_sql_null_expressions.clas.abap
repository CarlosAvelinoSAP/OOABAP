CLASS zcl_991_sql_null_expressions DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
    ALIASES run FOR if_oo_adt_classrun~main.
ENDCLASS.



CLASS ZCL_991_SQL_NULL_EXPRESSIONS IMPLEMENTATION.


  METHOD run.

    SELECT
      carrid,
      carrname,
      "The type of the null value is determined by the context.
      "When the null value is passed to the internal table,
      "it is converted to the initial value. In the first case,
      "it is ' '. In the second case, it is 0..
      CASE WHEN length( carrname ) > 12 THEN char`X`
        ELSE NULL
      END AS long_name,
      CAST( NULL AS INT1 ) AS null_val

  FROM zdemo_abap_carr
  INTO TABLE @DATA(null_expr).

    out->write( null_expr ).

  ENDMETHOD.
ENDCLASS.
