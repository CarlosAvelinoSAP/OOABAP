CLASS zcl_991_generic_typing DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_991_generic_typing IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    "----------- Generic typing -----------
    "- Generic types are available with which formal parameters of methods or field symbols
    "  can be specified.
    "- At runtime, the actual data type is copied from the assigned actual parameter or
    "  memory area, i.e. they receive the complete data type only when an actual parameter
    "  is passed or a memory area is assigned.

    "The following code snippet demonstrates generic types with field symbols.
    FIELD-SYMBOLS:
      "Any data type
      <data>           TYPE data,
      <any>            TYPE any,
      "Any data type can be assigned. Restrictions for formal parameters and 'data': no
      "numeric functions, no description functions, and no arithmetic expressions can be
      "passed to these parameters. However, you can bypass the restriction by applying the
      "CONV operator for the actual parameter.

      "Character-like types
      <c>              TYPE c,         "Text field with a generic length
      <clike>          TYPE clike,     "Character-like (c, n, string, d, t and character-like flat structures)
      <csequence>      TYPE csequence, "Text-like (c, string)
      <n>              TYPE n,         "Numeric text with generic length
      <x>              TYPE x,         "Byte field with generic length
      <xsequence>      TYPE xsequence, "Byte-like (x, xstring)

      "Numeric types
      <decfloat>       TYPE decfloat, "decfloat16, decfloat34)
      <numeric>        TYPE numeric,  "Numeric ((b, s), i, int8, p, decfloat16, decfloat34, f)
      <p>              TYPE p,        "Packed number (generic length and number of decimal places)

      "Internal table types
      <any_table>      TYPE ANY TABLE,      "Internal table with any table type
      <hashed_table>   TYPE HASHED TABLE,
      <index_table>    TYPE INDEX TABLE,
      <sorted_table>   TYPE SORTED TABLE,
      <standard_table> TYPE STANDARD TABLE,
      <table>          TYPE table,          "Standard table

      "Other types
      <simple>         TYPE simple, "Elementary data type including enumerated types and
      "structured types with exclusively character-like flat components
      <object>         TYPE REF TO object. "object can only be specified after REF TO; can point to any object

    "Data objects to work with
    DATA: BEGIN OF s,
            c3        TYPE c LENGTH 3,
            c10       TYPE c LENGTH 10,
            n4        TYPE n LENGTH 4,
            str       TYPE string,
            time      TYPE t,
            date      TYPE d,
            dec16     TYPE decfloat16,
            dec34     TYPE decfloat34,
            int       TYPE i,
            pl4d2     TYPE p LENGTH 4 DECIMALS 2,
            tab_std   TYPE STANDARD TABLE OF string WITH EMPTY KEY,
            tab_so    TYPE SORTED TABLE OF string WITH NON-UNIQUE KEY table_line,
            tab_ha    TYPE HASHED TABLE OF string WITH UNIQUE KEY table_line,
            xl1       TYPE x LENGTH 1,
            xstr      TYPE xstring,
            structure TYPE zdemo_abap_carr, "character-like flat structure
            oref      TYPE REF TO object,
          END OF s.

    "The following static ASSIGN statements demonstrate various assignments
    "Note:
    "- The statements commented out show impossible assignments.
    "- If a static assignment is not successful, sy-subrc is not set and no
    "  memory area is assigned. Dynamic assignments, however, set the value.

    "----- Any data type -----
    ASSIGN s-c3 TO <data>.
    ASSIGN s-time TO <data>.
    ASSIGN s-tab_std TO <data>.
    ASSIGN s-xstr TO <any>.
    ASSIGN s-pl4d2 TO <any>.
    ASSIGN s-date TO <any>.
    ASSIGN s TO <any>.

    "----- Character-like types -----
    ASSIGN s-c3 TO <c>.
    ASSIGN s-c10 TO <c>.
    "ASSIGN s-str TO <c>.

    ASSIGN s-c10 TO <clike>.
    ASSIGN s-str TO <clike>.
    ASSIGN s-n4 TO <clike>.
    ASSIGN s-date TO <clike>.
    ASSIGN s-time TO <clike>.
    ASSIGN s-structure TO <clike>.

    ASSIGN s-c10 TO <csequence>.
    ASSIGN s-str TO <csequence>.
    "ASSIGN s-n4 TO <csequence>.

    ASSIGN s-n4 TO <n>.
    "ASSIGN s-int TO <n>.
    "ASSIGN s-time TO <n>.

    ASSIGN s-xl1 TO <x>.
    "ASSIGN s-xstr TO <x>.

    ASSIGN s-xl1 TO <xsequence>.
    ASSIGN s-xstr TO <xsequence>.

    "----- Numeric types -----
    ASSIGN s-dec16 TO <numeric>.
    ASSIGN s-dec34 TO <numeric>.
    ASSIGN s-int TO <numeric>.
    ASSIGN s-pl4d2 TO <numeric>.
    "ASSIGN s-n4 TO <numeric>.

    ASSIGN s-dec16 TO <decfloat>.
    ASSIGN s-dec34 TO <decfloat>.

    ASSIGN s-pl4d2 TO <p>.
    "ASSIGN s-dec34 TO <p>.

    "----- Internal table types -----
    ASSIGN s-tab_std TO <any_table>.
    ASSIGN s-tab_so TO <any_table>.
    ASSIGN s-tab_ha TO <any_table>.

    ASSIGN s-tab_std TO <index_table>.
    ASSIGN s-tab_so TO <index_table>.
    "ASSIGN s-tab_ha TO <index_table>.

    "ASSIGN s-tab_std TO <sorted_table>.
    ASSIGN s-tab_so TO <sorted_table>.
    "ASSIGN s-tab_ha TO <sorted_table>.

    ASSIGN s-tab_std TO <standard_table>.
    ASSIGN s-tab_std TO <table>.
    "ASSIGN s-tab_so TO <standard_table>.
    "ASSIGN s-tab_so TO <table>.
    "ASSIGN s-tab_ha TO <standard_table>.
    "ASSIGN s-tab_ha TO <table>.

    "ASSIGN s-tab_std TO <hashed_table>.
    "ASSIGN s-tab_so TO <hashed_table>.
    ASSIGN s-tab_ha TO <hashed_table>.

    "----- Other types -----
    ASSIGN s-c10 TO <simple>.
    ASSIGN s-str TO <simple>.
    ASSIGN s-dec34 TO <simple>.
    ASSIGN s-date TO <simple>.
    ASSIGN s-structure TO <simple>.
    ASSIGN s-xl1 TO <simple>.
    "ASSIGN s-tab_ha TO <simple>.

    ASSIGN s-oref TO <object>.


  ENDMETHOD.
ENDCLASS.
