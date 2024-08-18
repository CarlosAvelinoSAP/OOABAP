CLASS zcl_991_examples_data_ref DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_991_examples_data_ref IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    DATA dref TYPE REF TO data.
    dref = NEW i( 1 ).

    "ref is overwritten here because a new object is created
    "with a data reference variable already pointing to a data object
    dref = NEW i( 2 ).
    "This snippet shows that three data references are created
    "with the same reference variable. Storing them in an internal table
    "using the type TYPE TABLE OF REF TO prevents the overwriting.

    DATA:
      itab TYPE TABLE OF REF TO data,
      num  TYPE i VALUE 0.

    DO 3 TIMES.
      "Adding up 1 to demonstrate a changed data object.
      num += 1.

      "Creating data reference and assigning value.
      "In the course of the loop, the variable gets overwritten.
      dref = NEW i( num ).

      "Adding the reference to itab
      itab = VALUE #( BASE itab ( dref ) ).
    ENDDO.

    "Similar use case to using field symbols: In a loop across an internal table,
    "you assign the content of the line in a data reference variable
    "instead of actually copying the content to boost performance.
    "Again, the inline declaration comes in handy.

    "Filling an internal table.
    SELECT *
      FROM zdemo_abap_fli
      INTO TABLE @DATA(fli_tab).

    LOOP AT fli_tab REFERENCE INTO DATA(ref).

      "A component of the table line may be addressed.
      "Note the object component selector; the dereferencing operator together
      "with the component selector is also possible: ->*-
      ref->carrid = 1...
      ...
    ENDLOOP.

    "More statements are available that assign content to a data reference variable,
    "for example, READ TABLE.
    READ TABLE fli_tab INDEX 1 REFERENCE INTO DATA(rt_ref).

    "Unlike field symbols, data reference variables can be used as
    "components of structures or columns in internal tables.

    "Structure
    DATA: BEGIN OF struc,
            num TYPE i,
            ref TYPE REF TO i,
          END OF struc.

    "Some value assignment

    struc = VALUE #( num = 1 ref = NEW #( 2 ) ).

    "Internal table

    DATA itab2 LIKE TABLE OF struc WITH EMPTY KEY.
    APPEND struc TO itab2.
    itab2[ 1 ]-ref->* = 123.

  ENDMETHOD.
ENDCLASS.
