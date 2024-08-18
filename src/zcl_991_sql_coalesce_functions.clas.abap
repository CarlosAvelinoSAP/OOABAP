CLASS zcl_991_sql_coalesce_functions DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
    ALIASES run FOR if_oo_adt_classrun~main.
ENDCLASS.



CLASS ZCL_991_SQL_COALESCE_FUNCTIONS IMPLEMENTATION.


  METHOD run.

    SELECT
        FROM zdemo_abap_tab1
        FIELDS *
        INTO TABLE @DATA(demo_abap_tab1).
    out->write( demo_abap_tab1 ).

    "The null value is a special value that is returned by a database. It indicates an
    "undefined value or result. Note that, in ABAP, there are no special null values. Do
    "not confuse the null value with a type-dependent initial value. When using SELECT
    "statements to read data, null values can be produced by, for example, outer joins.
    "When the null values are passed to a data object, they are transformed to the
    "type-dependent initial values. For more information, refer to the ABAP Keyword Documentation.
    "The following example uses a left outer join to intentionally create null values. For
    "this purpose, two demo database tables of the ABAP cheat sheet repository are cleared and
    "populated with specific values to visualize null values.
    DELETE FROM zdemo_abap_tab1.
    DELETE FROM zdemo_abap_tab2.
    MODIFY zdemo_abap_tab1 FROM TABLE @( VALUE #( ( key_field = 1 char1 = 'a' char2 = 'y' )
                                                  ( key_field = 2 char1 = 'b' char2 = 'z' ) ) ).
    MODIFY zdemo_abap_tab2 FROM TABLE @( VALUE #( ( key_field = 1 char1 = 'a' )
                                                  ( key_field = 2 char1 = 'a' )
                                                  ( key_field = 3 char1 = 'b' )
                                                  ( key_field = 4 ) ) ).

    "Note that for the entry 'key_field = 4' no char1 value was passed.
    "char1 is a shared column of the two database tables, and which is used in
    "the ON condition of the join. Since there is no entry in char1 for 'key_field = 4',
    "the joined values are null in that case.
    "The coalesce function is used to replace null values produced by an outer join with
    "a different value.
    SELECT tab2~key_field,
           coalesce( tab1~char1, '-' ) AS coalesced1,
           coalesce( tab1~char2, '#' ) AS coalesced2,
           "A coalesce function is a short form of a complex
           "case distinction such as the following:
           CASE WHEN tab1~char1 IS NOT NULL THEN tab1~char1
            ELSE '?'
           END AS coalesced3

        FROM zdemo_abap_tab2 AS tab2
        LEFT OUTER JOIN zdemo_abap_tab1 AS tab1 ON tab1~char1 = tab2~char1
        INTO TABLE @DATA(join_w_null).
    out->write( join_w_null ).
*Example table content
*KEY_FIELD    COALESCED1    COALESCED2    COALESCED3
*1            a             y             a
*2            a             y             a
*3            b             z             b
*4            -             #             ?


  ENDMETHOD.
ENDCLASS.
