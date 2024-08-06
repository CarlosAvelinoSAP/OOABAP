CLASS zcl_991_sql_more_functions DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
    ALIASES run FOR if_oo_adt_classrun~main.
ENDCLASS.



CLASS zcl_991_sql_more_functions IMPLEMENTATION.


  METHOD run.

    SELECT SINGLE
      carrid,

      "Conversion functions
      "When used: Special conversions that cannot be handled in a general
      "CAST expression

      "Type conversion: string of fixed length (e.g. of type c) to variable
      "length string of type string
      to_clob( carrid ) AS clob,

      "Byte string -> character string
      bintohex( raw`3599421128650F4EE00008000978B976` ) AS bintohex,

      "Character string -> byte string
      hextobin( char`3599421128650F4EE00008000978B976` ) AS hextobin,

      "Byte field of type RAW to a byte string (BLOB) of type RAWSTRING
      to_blob( raw`3599421128650F4EE00008000978B976` ) AS blob,

      "Unit and currency conversion functions
      "More parameters are available.

      "Converts miles to kilometers
      unit_conversion( quantity = d34n`1`,
                       source_unit = unit`MI`,
                       target_unit = unit`KM` ) AS miles_to_km,

*      "Converts Euro to US dollars using today's rate
*      currency_conversion(
*        amount = d34n`1`,
*        source_currency = char`EUR`,
*        target_currency = char`USD`,
*        exchange_rate_date = @( cl_abap_context_info=>get_system_date( ) )
*                         ) AS eur_to_usd,
*
      "Date and time functions
      add_days( @( cl_abap_context_info=>get_system_date( ) ), 4 ) AS add_days,
      add_months( @( cl_abap_context_info=>get_system_date( ) ), 2 ) AS add_months,
      is_valid( @( cl_abap_context_info=>get_system_date( ) ) ) AS date_is_valid,
      is_valid( @( cl_abap_context_info=>get_system_time( ) ) ) AS time_is_valid,

      "UUID
      uuid( ) AS uuid

    FROM zdemo_abap_carr
    INTO @DATA(special_functions).
    out->write( special_functions ).

  ENDMETHOD.
ENDCLASS.
