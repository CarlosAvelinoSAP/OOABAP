CLASS zcl_991_static_method DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
    CLASS-METHODS:
      static_method1.
    DATA:
        instance_data1 TYPE i VALUE 1.
ENDCLASS.



CLASS ZCL_991_STATIC_METHOD IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
  ENDMETHOD.


  METHOD static_method1.
*  Within a static method, only static attributes can be accessed without specifying further information.
*    data(localData) = instance_data1.
  ENDMETHOD.
ENDCLASS.
