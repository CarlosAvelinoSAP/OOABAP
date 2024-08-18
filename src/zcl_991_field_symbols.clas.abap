CLASS zcl_991_field_symbols DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_991_FIELD_SYMBOLS IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    "Assignments
    DATA num TYPE i VALUE 1.
    FIELD-SYMBOLS <fs_i> TYPE i.
    ASSIGN num TO <fs_i>.

    <fs_i> = 2.
    "The data object 'num' has now the value 2.

    "Loops
    "Here, field symbols are handy since you can avoid an
    "actual copying of the table line.
    SELECT *
      FROM zdemo_abap_fli
      INTO TABLE @DATA(itab).

    FIELD-SYMBOLS <fs1> LIKE LINE OF itab.

    LOOP AT itab ASSIGNING <fs1>.
*      <fs1>-carrid = ... "The field symbol represents a line of the table.
*      <fs1>-connid = ... "Components are accessed with the component selector.
      "Here, it is assumed that a new value is assigned.
      ...
    ENDLOOP.

    "Inline declaration of a field symbol. The field symbol is implcitly typed
    "with the generic type data.
    LOOP AT itab ASSIGNING FIELD-SYMBOL(<fs2>).
*      <fs2>-carrid = ...
*      <fs2>-connid = ...
      ...
    ENDLOOP.

    "READ TABLE statements
    READ TABLE itab INDEX 1 ASSIGNING FIELD-SYMBOL(<rt>).


  ENDMETHOD.
ENDCLASS.
