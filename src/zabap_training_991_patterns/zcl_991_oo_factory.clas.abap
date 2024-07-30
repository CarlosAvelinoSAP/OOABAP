CLASS zcl_991_oo_factory DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_991_oo_factory IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    DATA connection TYPE REF TO lcl_connection.

*    connection = new #(  ). "error: private class prevent creation of its instance outside of it

* Debug the method to show that the class returns objects, but that there are different
* objects for the same combination of airline and flight number

    connection = lcl_connection=>get_connection( airlineid = 'LH' connectionnumber = '0400' ).

    connection = lcl_connection=>get_connection( airlineid = 'LH' connectionnumber = '0400' ).

  ENDMETHOD.
ENDCLASS.
