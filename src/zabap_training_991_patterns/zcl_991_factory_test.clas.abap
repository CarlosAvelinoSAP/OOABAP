CLASS zcl_991_factory_test DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
    ALIASES testRun FOR if_oo_adt_classrun~main.
ENDCLASS.



CLASS zcl_991_factory_test IMPLEMENTATION.


  METHOD testrun.
    data(inst) = zcl_991_factory=>factory_method( 1 ).
    inst->setMsg1( |instancia 1| ).
    out->write( inst->getmsg1(  ) ).
    data(inst1) = zcl_991_factory=>factory_method( 3 ).
    inst1->setMsg1( |instancia 2| ).
    out->write( inst1->getmsg1(  ) ).
    out->write( inst->getmsg1(  ) ).
  ENDMETHOD.
ENDCLASS.
