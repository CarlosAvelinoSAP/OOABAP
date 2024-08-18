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



CLASS ZCL_991_OO_METHODCHAINING IMPLEMENTATION.


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

    "Getting to the result as above - not using method chaining and inline declarations.
    DATA some_int2 TYPE i.
    DATA dref TYPE REF TO cl_abap_random_int.

    dref = cl_abap_random_int=>create( seed = cl_abap_random=>seed( )
                                       min  = 1
                                       max  = 10 ).

    some_int2 = dref->get_next( ).

    out->write( | some_int2 = { some_int2 } | ).

    "Using the RECEIVING parameter in a standalone method call
    DATA some_int3 TYPE i.
    dref->get_next( RECEIVING value = some_int3 ).
    out->write( | some_int3 = { some_int3 }| ).

    "IF statement that uses the return value in a read position
    IF cl_abap_random_int=>create( seed = cl_abap_random=>seed( )
                                   min  = 1
                                   max  = 10 )->get_next( ) < 5.
      out->write( | The random number is lower than 5 | ).
    ELSE.
      out->write( | The random number is greater than 5 | ).
    ENDIF.

    "Examples using classes of the XCO library (see more information in the
    "ABAP for Cloud Development and Misc ABAP Classes cheat sheets), in which
    "multiple chained method calls can be specified. Each of the methods
    "has a returning parameter specified.

    "In the following example, 1 hour is added to the current time.
    DATA(add1hour) = xco_cp=>sy->time( xco_cp_time=>time_zone->user )->add( iv_hour = 1 )->as( xco_cp_time=>format->iso_8601_extended )->value.
    out->write( | add1hour = { add1hour } | ).
    "In the following example, a string is converted to xstring using a codepage
    DATA(xstr) = xco_cp=>string( `Some string` )->as_xstring( xco_cp_character=>code_page->utf_8 )->value.
    out->write( | xstr = { xstr } | ).
    "In the following example, JSON data is created. First, a JSON data builder
    "is created. Then, using different methods, JSON data is added. Finally,
    "the JSON data is turned to a string.
    DATA(json) = xco_cp_json=>data->builder( )->begin_object(
      )->add_member( 'CarrierId' )->add_string( 'DL'
      )->add_member( 'ConnectionId' )->add_string( '1984'
      )->add_member( 'CityFrom' )->add_string( 'San Francisco'
      )->add_member( 'CityTo' )->add_string( 'New York'
      )->end_object( )->get_data( )->to_string( ).

    out->write( | json = { json } |  ).

  ENDMETHOD.
ENDCLASS.
