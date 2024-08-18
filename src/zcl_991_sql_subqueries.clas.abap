CLASS zcl_991_sql_subqueries DEFINITION  INHERITING FROM cl_demo_classrun
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS main REDEFINITION.
*    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
  ALIASES run for if_oo_adt_classrun~main.
ENDCLASS.



CLASS ZCL_991_SQL_SUBQUERIES IMPLEMENTATION.


  METHOD main.

*    SELECT
*           FROM  sflights2
*           FIELDS *
**           GROUP BY carrid, connid, planetype, seatsmax
*           ORDER BY carrid, connid
*           INTO TABLE @FINAL(flights).

*    SELECT carrid, connid, planetype, seatsmax,
*           MAX( seatsocc ) AS seatsocc
*           FROM  sflight as sf
*           GROUP BY carrid, connid, planetype, seatsmax
*           ORDER BY carrid, connid
*           INTO TABLE @FINAL(flights).
*
*    LOOP AT flights INTO FINAL(wa).
*      out->next_section(  |{ wa-carrid } { wa-connid }|
*        )->begin_section( |{ wa-planetype }, {
*                             wa-seatsmax  }, { wa-seatsocc  }| ).
*      SELECT planetype, seatsmax
*             FROM  saplane AS plane
*             WHERE seatsmax < @wa-seatsmax AND
*                   seatsmax >= ALL
*                     ( SELECT seatsocc
*                              FROM  sflight
*                              WHERE carrid = @wa-carrid AND
*                              connid = @wa-connid )
*             ORDER BY seatsmax
*             INTO (@FINAL(plane), @FINAL(seats)).
*        out->write( |{ plane }, { seats }| )->end_section( ).
*      ENDSELECT.
*      IF sy-subrc <> 0.
*        out->write( 'No alternative plane types found'
*          )->end_section( ).
*      ENDIF.
*    ENDLOOP.

  ENDMETHOD.
ENDCLASS.
