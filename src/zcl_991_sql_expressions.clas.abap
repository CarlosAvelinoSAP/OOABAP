CLASS zcl_991_sql_expressions DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_991_sql_expressions IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.


    DATA itab TYPE SORTED TABLE OF demo_struc WITH UNIQUE KEY id.
    "Populating internal table with data to work with in the examples
    itab = VALUE #( ( id = 1 name = 'bear' )
                    ( id = 2 name = 'camel' )
                    ( id = 3 name = 'rabbit' )
                    ( id = 4 name = 'zebra' )
                    ( id = 5 name = 'dog' )
                    ( id = 6 name = 'deer' )
                    ( id = 7 name = 'squirrel' )
                    ( id = 8 name = 'cheetah' )
                    ( id = 9 name = 'elephant' )
                    ( id = 10 name = 'donkey' )
                    ( id = 11 name = 'fish' )
                    ( id = 12 name = 'sheep' ) ).

    "---- =, <>, >, >= (as a selection of possible comparison operators) ----
    SELECT id FROM @itab AS tab WHERE name = 'bear' INTO TABLE @DATA(it). "1
    SELECT id FROM @itab AS tab WHERE name <> 'bear' INTO TABLE @it. "2-12
    SELECT id FROM @itab AS tab WHERE id > 10 INTO TABLE @it. "11,12
    SELECT id FROM @itab AS tab WHERE id >= 10 INTO TABLE @it. "10,11,12

    "---- Combining logical expressions using AND, OR and parentheses  ----
    SELECT id FROM @itab AS tab WHERE id = 1 AND name = 'bear' INTO TABLE @it. "1
    SELECT id FROM @itab AS tab WHERE name = 'bear' OR name = 'sheep' INTO TABLE @it.

    "------------------------ [NOT] LIKE ------------------------
    "For (not) matching a specified pattern
    "Note: % (any character string), _ (any character).
    SELECT name FROM @itab AS tab
      WHERE name LIKE '%ee%'
      OR name LIKE '_o%'
      INTO TABLE @DATA(names). "dog,deer,cheetah,donkey,sheep

    "------------------------ [NOT] LIKE ------------------------
    "For (not) matching a specified pattern
    "Note: % (any character string), _ (any character).
    SELECT name FROM @itab AS tab
      WHERE name LIKE '%ee%'
      OR name LIKE '_o%'
      INTO TABLE @DATA(names1). "dog,deer,cheetah,donkey,sheep

    "ESCAPE addition for defining a single-character escape character
    "In the following example, this character is #. It is placed before
    "the % character in the specification after LIKE. In this case, %
    "is escaped and does then not stand for any character string in the
    "evaluation.
    "Adding a table entry for this syntax example.
    itab = VALUE #( BASE itab ( id = 13 name = '100%' ) ).
    "Any character sequence followed by the % character
    SELECT name FROM @itab AS tab
      WHERE name LIKE '%#%' ESCAPE '#'
      INTO TABLE @names. "100%

    "Deleting the entry because it is not relevant for the further examples.
    DELETE itab INDEX 13.


    "Single operands on the left side of IN
    SELECT id FROM @itab AS tab
      WHERE name IN ( 'camel', 'rabbit', 'dog', 'snake' )
      INTO TABLE @it. "2,3,5

    "Negation NOT IN; note to use host variables/expressions for local/global data objects
    DATA(animal) = 'sheep'.
    SELECT id FROM @itab AS tab
      WHERE name NOT IN ( 'fish', @animal )
      INTO TABLE @it. "1-10

    "Common Table Expressions (CTE)
    WITH
    +connections AS (
      SELECT zdemo_abap_flsch~carrid, carrname, connid, cityfrom, cityto
        FROM zdemo_abap_flsch
        INNER JOIN zdemo_abap_carr
        ON zdemo_abap_carr~carrid = zdemo_abap_flsch~carrid
        WHERE zdemo_abap_flsch~carrid BETWEEN 'AA' AND 'JL' ),
    +sum_seats AS (
      SELECT carrid, connid, SUM( seatsocc ) AS sum_seats
        FROM zdemo_abap_fli
        WHERE carrid BETWEEN 'AA' AND 'JL'
        GROUP BY carrid, connid ),
    +result( name, connection, departure, arrival, occupied ) AS (
      SELECT carrname, c~connid, cityfrom, cityto, sum_seats
        FROM +connections AS c
        INNER JOIN +sum_seats AS s
        ON c~carrid = s~carrid AND c~connid = s~connid )
    SELECT *
      FROM +result
      ORDER BY name, connection
      INTO TABLE @DATA(result).

    out->write( result ).

    "------------------------ [NOT] IN (using a ranges table) ------------------------
    "[NOT] IN for checking whether the operands on the left side match a ranges condition in a ranges table

    "Declaring a ranges table
    DATA rangestab TYPE RANGE OF i.
    "Populating a ranges table using the VALUE operator
    rangestab = VALUE #( ( sign   = 'I' option = 'BT' low = 1 high = 3 )
                         ( sign   = 'I' option = 'GE' low = 10  ) ).

    SELECT id FROM @itab AS tab WHERE id IN @rangestab INTO TABLE @it. "1,2,3,10,11,12


    "You cannot use logical operators such as CP (conforms to pattern) in the WHERE clause.
    "In a ranges table, they are possible.
    "Note:
    "- Regarding CP: * (any character sequence), + (any character), # (escape character)
    "- An equivalent example above uses the LIKE addition.
    DATA rt TYPE RANGE OF demo_struc-name.
    rt = VALUE #( ( sign   = 'I' option = 'CP' low = '*ee*' ) "ee in a string
                  ( sign   = 'I' option = 'CP' low = '+o*' ) ). "o in second position
    SELECT name FROM @itab AS tab
      WHERE name IN @rt
      INTO TABLE @names. "dog,deer,cheetah,donkey,sheep

    "------------------------ EXISTS ------------------------
    "For checking the result set of a subquery.
    "The following example reads all entries from the internal table if entries having
    "the same key also exist in the database table.
    "Note: The SELECT list in the subquery only contains a literal to determine that
    "the entry exists. Specifying explicit column names is not relevant.
    SELECT id FROM @itab AS tab WHERE
      EXISTS ( SELECT @abap_true FROM zdemo_abap_tab1 WHERE key_field = tab~id )
      INTO TABLE @it. "11,12
    out->write( it ).

    "Example demonstrating possible operands:
    DATA number TYPE i VALUE 3.

    SELECT FROM zdemo_abap_flsch
      FIELDS
      "Specifies a column of a data source directly using its name
      cityfrom,

      "Column selector ~ can be used to prefix every specified column.
      "Here, it is optional. It is non-optional, e. g., if multiple data
      "sources in an ABAP SQL statement are edited and the column name
      "is not unique.
      zdemo_abap_flsch~cityto,

      'Lufthansa' AS name, "Untyped literal

      char`X` AS flag, "Typed literal

      @number AS num, "Host variable

      @( cl_abap_context_info=>get_system_date( ) ) AS date "Host expression

      WHERE carrid = 'LH'          "Untyped literal
        AND countryfr = char`DE`   "Typed literal

      "Data object created inline and escaped with @
      INTO TABLE @DATA(it1)

      "The following clause shows all options having the same effect
      UP TO 3 ROWS.             "Untyped numeric literal
    "UP TO int4`3` ROWS.      "Typed numeric literal
    "UP TO @number ROWS.        "Host variable
    "UP TO @( 10 - 7 ) ROWS.  "Host expression
    out->write( it1 ).

    "Cast Expressions
    SELECT SINGLE
    carrid,

    "A cast expression converts the value of the operands to the
    "specified dictionary type. The result is a representation of the
    "source value in the specified type.
    CAST( 1 AS D34N ) / CAST( 2 AS D34N ) AS ratio,
    CAST( connid AS INT4 ) AS connidnum,
    CAST( @( cl_abap_context_info=>get_system_date( ) ) AS CHAR ) AS dat

    FROM zdemo_abap_fli
    WHERE carrid = 'AA'
    INTO @DATA(cast_expr).
    out->write( cast_expr ).

    "String Expressions
    SELECT SINGLE
    carrid,

    "String expression using && to concatenate two character strings;
    "the result of the concatenation must not be longer than
    "255 characters.
    carrid && char`_` && carrname AS concat

    FROM zdemo_abap_carr
    WHERE carrid = 'AA'
    INTO @DATA(string_expr).
    out->write( string_expr ).

    "Case Expressions
    SELECT SINGLE
  carrid,

      "Simple case distinction
      "The expression compares the values of an operand with other
      "operands. Result: The first operand after THEN for which the
      "comparison is true. If no matches are found, the result specified
      "after ELSE is selected.
      CASE currcode
        WHEN 'EUR' THEN 'A'
        WHEN 'USD' THEN 'B'
        ELSE 'C'
      END AS case_simple,

      "Complex case distinction
      "The expression evaluates logical expressions. Result: The first
      "operand after THEN for which the logical expression is true. If no
      "logical expressions are true, the result specified after ELSE is
      "selected.
      CASE WHEN length( carrname ) <= 5 THEN 'small'
           WHEN length( carrname ) BETWEEN 6 AND 10 THEN 'mid'
           WHEN length( carrname ) BETWEEN 11 AND 15 THEN 'large'
           ELSE 'huge'
      END AS case_complex

      FROM zdemo_abap_carr
      WHERE carrid = 'AA'
      INTO @DATA(case_expr).

    out->write( case_expr ).

  ENDMETHOD.
ENDCLASS.
