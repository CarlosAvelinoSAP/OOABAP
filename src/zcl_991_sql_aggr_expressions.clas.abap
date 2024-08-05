CLASS zcl_991_sql_aggr_expressions DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
    ALIASES run FOR if_oo_adt_classrun~main.
ENDCLASS.



CLASS zcl_991_sql_aggr_expressions IMPLEMENTATION.


  METHOD run.
    "The example shows a selection of available functions
    SELECT
      carrid,

      "Average value of the content of a column in a row set
      AVG( fltime ) AS fltime1,

      "AVG with data type specification for the result
      AVG( fltime AS DEC( 14,4 ) ) AS fltime2,

      "Maximum value of the results in a row set
      MAX( fltime ) AS max,

      "Minimum value
      MIN( fltime ) AS min,

      "Sum of the results in a row set.
      SUM( fltime ) AS sum,

      "Returns the number of rows in a row set.
      "The following two have the same meaning.
      COUNT( * ) AS count2,
      COUNT(*) AS count3,

      "Chains the results in a row set.
      "An optional separator can be specified
      STRING_AGG( airpfrom, ', ' ) AS string_agg

    FROM zdemo_abap_flsch
    WHERE carrid = 'LH'
    GROUP BY carrid
    INTO TABLE @DATA(agg_exp).
    out->write( agg_exp ).
  ENDMETHOD.
ENDCLASS.
