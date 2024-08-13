*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations
CLASS lclRaiseException DEFINITION CREATE PUBLIC.

  PUBLIC SECTION.
    METHODS:
      setPower IMPORTING base         TYPE i
                         exponent     TYPE i
               RETURNING VALUE(power) TYPE i
               RAISING   cx_sy_arithmetic_overflow,
      inst_meth8 IMPORTING ip1        TYPE i
                 RETURNING VALUE(ret) TYPE string
                 RAISING   cx_uuid_error.


  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA:
     power TYPE i.

ENDCLASS.

CLASS lclRaiseException IMPLEMENTATION.

  METHOD setPower.
    IF base >= 100.
      RAISE EXCEPTION TYPE cx_sy_arithmetic_overflow.
    ELSE.
      me->power = base ** exponent.
    ENDIF.
    power = me->power.
  ENDMETHOD.

  METHOD inst_meth8.
    IF ip1 = 1.
      RAISE EXCEPTION TYPE cx_uuid_error.
    ELSE.
      ret = `No exception was raised.`.
    ENDIF.
  ENDMETHOD.

ENDCLASS.
