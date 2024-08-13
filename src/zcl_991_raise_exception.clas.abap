CLASS zcl_991_raise_exception DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_991_raise_exception IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    DATA(objPower) = NEW lclraiseexception(  ).
    DATA(power) = objpower->setpower( base = 10 exponent = 199 ).

    DATA(oref) = NEW lclraiseexception( ).
    DATA(test2) = oref->inst_meth8( ip1 = 1 ).

    try.
        DATA(test) = oref->inst_meth8( ip1 = 1 ).
    CATCH cx_uuid_error.
        out->write( data = test name = `test` ).
    ENDTRY.
        out->write( `cx_uuid_error was raised` ).
  ENDMETHOD.
ENDCLASS.
