CLASS zcl_991_utc_current DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_991_UTC_CURRENT IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    out->write( |A data atual utclong: { utclong_current( ) }| ).
    out->write( |A data atual utclong: { CONV string( utclong_current( ) ) }| ).
    out->write( |class abap context info: { cl_abap_context_info=>get_system_date(  ) }| ).
*  out->write( |A data atual utcshor: { utcshort_current( ) }| ).
    DATA tsl TYPE timestampl.

    GET TIME STAMP FIELD DATA(ts).
    GET TIME STAMP FIELD tsl.

    out->write( |{ ts  TIMESTAMP = ISO
                       TIMEZONE = 'UTC' }|
      )->write( |{ tsl TIMESTAMP = ISO
                       TIMEZONE = 'UTC' }|
      ).


  ENDMETHOD.
ENDCLASS.
