CLASS zcl_991_factory DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    CLASS-METHODS factory_method IMPORTING ctr        TYPE i
                                 RETURNING VALUE(obj) TYPE REF TO zcl_991_factory.
    METHODS setMsg1 IMPORTING msg1 type string.
    METHODS getMsg1 RETURNING VALUE(message) TYPE string.

  PROTECTED SECTION.
  PRIVATE SECTION.
    CLASS-DATA inst1 TYPE REF TO zcl_991_factory.
    DATA msg1 TYPE c LENGTH 12.
ENDCLASS.



CLASS ZCL_991_FACTORY IMPLEMENTATION.


  METHOD factory_method.
    IF ctr BETWEEN 0 AND 3.
      inst1 = NEW #( ).
    ENDIF.
*    msg1 = SWITCH #( ctr WHEN 1 THEN |um|
*                         WHEN 2 THEN |dois|
*                         WHEN 3 THEN |tres|
*                         ELSE |qualquer|
*                    ).
    obj = inst1.
  ENDMETHOD.


  METHOD getmsg1.
    MESSAGE = msg1 .
  ENDMETHOD.


  METHOD setMsg1.
    me->msg1 = msg1.
  ENDMETHOD.
ENDCLASS.
