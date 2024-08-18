CLASS zcl_991_singleton_class DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

   PUBLIC SECTION.
    CLASS-METHODS get_instance RETURNING VALUE(ret) TYPE REF TO zcl_991_singleton_class.

  PRIVATE SECTION.
    CLASS-DATA inst TYPE REF TO zcl_991_singleton_class.
ENDCLASS.



CLASS ZCL_991_SINGLETON_CLASS IMPLEMENTATION.


  METHOD get_instance.
    IF inst IS NOT BOUND.
      inst = NEW #( ).
    ENDIF.
    ret = inst.
  ENDMETHOD.
ENDCLASS.
