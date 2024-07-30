CLASS zcl_991_cond_switch DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_991_cond_switch IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    DO 4 TIMES.
      DATA(value_cond) =
            COND string(
            WHEN sy-index = 1 THEN |One|
            WHEN sy-index = 2 THEN |Two|
            ELSE |GREATER than 2!| ).

      out->write( |/ value_cond = { value_cond }| ).
    ENDDO.


    " Extended Expressions : SWITCH expression variation
    DO 4 TIMES.
      DATA(value_switch) =
            SWITCH string( sy-index
            WHEN  1 THEN |One|
            WHEN  2 THEN |Two|
            ELSE |GREATER than 2!| ).

      out->write( |/ value_switch =  { value_switch } | )..
    ENDDO.


  ENDMETHOD.
ENDCLASS.
