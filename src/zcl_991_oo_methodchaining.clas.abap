CLASS zcl_991_oo_methodchaining DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
    ALIASES main FOR if_oo_adt_classrun~main.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_991_oo_methodchaining IMPLEMENTATION.


  METHOD main.

    out->write( cl_abap_random_int=>create( seed = cl_abap_random=>seed( )
                                                min  = 1
                                                max  = 10 )->get_next( ) ).


    out->write( cl_abap_random_int=>create( seed = cl_abap_random=>seed( )
                                                min  = 1
                                                max  = 10 )->get_next(  ) ).

    "The following example demonstrates method chaining
    "The following class creates random integers. Find more information in the
    "class documentation.
    "Both methods have returning parameters specified.
    DATA(some_int1) = cl_abap_random_int=>create( seed = cl_abap_random=>seed( )
                                                min  = 1
                                                max  = 10 )->get_next( ).

    out->write( | some_int1 = { some_int1 } | ).



  ENDMETHOD.
ENDCLASS.
