CLASS zcl_991_sql_window_expressions DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
    ALIASES run FOR if_oo_adt_classrun~main.
ENDCLASS.



CLASS zcl_991_sql_window_expressions IMPLEMENTATION.


  METHOD run.

    SELECT
        FROM zdemo_abap_fli
        FIELDS *
        ORDER BY carrid, currency
        INTO TABLE @DATA(demo_abap_fli).

    out->write( demo_abap_fli ).

    "Example 1: A simple window is constructed in the OVER clause;
    "window functions - here aggregate functions - are applied
    SELECT DISTINCT carrid, currency,
      SUM( paymentsum ) OVER( PARTITION BY carrid ) AS sum,
      AVG( price AS DEC( 14,2 ) ) OVER( PARTITION BY carrid ) AS avg,
      MAX( price ) OVER( PARTITION BY carrid ) AS max
      FROM zdemo_abap_fli
      ORDER BY carrid
      INTO TABLE @DATA(win).

    out->write( win ).

    "Example 2:
    SELECT carrid, currency, fldate,
      "Sorts the rows by some columns and counts the number of rows from
      "the first row of the window to the current row.
      COUNT( * ) OVER( ORDER BY currency, fldate
                       ROWS BETWEEN
                       "UNBOUNDED PRECEDING: frame starts at the first row of the window
                       UNBOUNDED PRECEDING
                       "CURRENT ROW: determines starting or ending at the current row; here, it ends
                       AND CURRENT ROW ) AS count1,

      "If no window frame is used, the default window frame is
      "BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW,
      "i. e. the result of count1 equals the result of count2.
      COUNT( * ) OVER( ORDER BY currency, fldate ) AS count2,

  "Sorts the rows by some columns and counts the number of rows from
  "the current row to the last row of the window.
  "The result is reverse numbering.
  COUNT( * ) OVER( ORDER BY currency, fldate
                   ROWS BETWEEN CURRENT ROW
*                   UNBOUND FOLLOWING:
                   "Determines the ending frame boundary, this addition specifies the last row of the window
                   AND UNBOUNDED FOLLOWING ) AS count_reverse,

      "Sorts the rows by some columns and calculates the rolling averages
      "of a subset of rows from column price. The subset consists of the
      "current row plus one preceding and one following row. Another use
      "case as below example that uses prices would be that, for example,
      "you can calculate the 3-day-average temperature for every day from
      "a list of temperature data.
      AVG( price AS DEC( 14,2 ) ) OVER( ORDER BY currency, fldate
           ROWS BETWEEN
           "n PRECEDING: for both start and end of frame; frame to start/end n rows above the current row
           1 PRECEDING
           "n FOLLOWING: for both start and end of frame; frame to start/end n rows beneath the current row
           AND 1 FOLLOWING ) AS avg

      FROM zdemo_abap_fli
      INTO TABLE @DATA(result).
    out->write( result ).


  ENDMETHOD.
ENDCLASS.
