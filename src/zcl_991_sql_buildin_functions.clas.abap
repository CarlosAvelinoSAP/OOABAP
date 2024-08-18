CLASS zcl_991_sql_buildin_functions DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_991_SQL_BUILDIN_FUNCTIONS IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    SELECT SINGLE
      carrname,

      "Division, result rounded to an integer
      "Result: 2
      div( 4, 2 ) AS div,

      "Division, 3rd argument: result is rounded to the specified
      "number of decimals
      "Result: 0.33
      division( 1, 3, 2 ) AS division,

      "Result is rounded to first greater integer
      "Result: 2
      ceil( decfloat34`1.333` ) AS ceil,

      "Result is the remainder of division
      "Result: 1
      mod( 3, 2 ) AS mod,

      "Result: Largest integer value not greater than the specified value
      "Result: 1
      floor( decfloat34`1.333` ) AS floor,

      "Returns the absolute number
      "Result: 2
      abs( int4`-2` ) AS abs,

      "Result is rounded to the specified position after the decimal separator
      "Result: 1.34
      round( decfloat34`1.337`, 2 ) AS round

      FROM zdemo_abap_carr
      WHERE carrid = 'AA'
      INTO @DATA(numeric_functions).
    out->write( numeric_functions ).

  ENDMETHOD.
ENDCLASS.
