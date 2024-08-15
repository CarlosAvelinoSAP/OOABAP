CLASS zcl_991_assigning_data_objs DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_991_assigning_data_objs IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    "Some data object declarations to be used
    DATA: num      TYPE i,
          struc    TYPE zdemo_abap_fli,  "Demo database table
          itab_str TYPE string_table,
          itab_fli TYPE TABLE OF zdemo_abap_fli WITH EMPTY KEY.
    APPEND INITIAL LINE TO itab_fli.

    "Declaring field symbols with complete types
    FIELD-SYMBOLS: <fs_i>     TYPE i,
                   <fs_struc> TYPE zdemo_abap_fli,
                   <fs_tab>   TYPE string_table.

    "Declaring field symbols with generic type
    FIELD-SYMBOLS <fs_gen> TYPE data.

    "Assigning data objects to field symbols
    "Using field symbols with a static type
    ASSIGN num   TO <fs_i>.
    ASSIGN struc TO <fs_struc>.
    ASSIGN itab_str TO <fs_tab>.
    "Using field symbol with a generic type
    ASSIGN num   TO <fs_gen>.
    ASSIGN itab_fli TO <fs_gen>.
    ASSIGN itab_fli[ 1 ] TO <fs_gen>.
    "Assigning components
    ASSIGN struc-carrid TO <fs_gen>.
    ASSIGN itab_fli[ 1 ]-connid TO <fs_gen>.

    "Inline declaration (the field symbol has the type data)
    ASSIGN num TO FIELD-SYMBOL(<fs_inl>).

    "CASTING addition for matching types of data object and field
    "symbol when assigning memory areas
    TYPES c_len_3 TYPE c LENGTH 3.
    DATA(chars) = 'abcdefg'.

    FIELD-SYMBOLS <fs1> TYPE c_len_3.

    "Implicit casting
    ASSIGN chars TO <fs1> CASTING. "abc

    FIELD-SYMBOLS <fs2> TYPE data.

    "Explicit casting
    ASSIGN chars TO <fs2> CASTING TYPE c_len_3. "abc

    DATA chars_l4 TYPE c LENGTH 4.
    ASSIGN chars TO <fs2> CASTING LIKE chars_l4. "abcd

  ENDMETHOD.
ENDCLASS.
