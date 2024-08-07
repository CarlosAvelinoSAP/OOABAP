CLASS zcl_991_new_instance_operator DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
    ALIASES runClass FOR if_oo_adt_classrun~main.
ENDCLASS.



CLASS zcl_991_new_instance_operator IMPLEMENTATION.


  METHOD runClass.

    "-------------- Creating anonymous data objects -------------
    "Note that optional additions (see for VALUE expressions) when dealing
    "with anonymous data objects (e.g. BASE). They are not covered here.

    "Declaring data reference variables
    DATA dref1 TYPE REF TO i.    "Complete type
    DATA dref2 TYPE REF TO data. "Generic type

    "In the following created anonymous data objects, no parameters are
    "specified in the parentheses meaning the data objects retain their
    "initial values.
    dref1 = NEW #( ).
    dref2 = NEW string( ).

    "Such NEW expressions replace the older syntax CREATE DATA (however, in the
    "context of dynamic programming, using CREATE DATA is still required)
    CREATE DATA dref1.
    CREATE DATA dref2 TYPE string.

    "Unlike above, the following examples specify values in the parentheses,
    "this assigning single values.
    dref1 = NEW #( 123 ).
    dref2 = NEW string( `hallo` ).

    "Using inline declarations to omit a prior declaration of a variable
    "dref3 has the type TYPE REF TO i
    DATA(dref3) = NEW i( 456 ).

    "Creating an anonymous structure
    "Components are assigned values.
    DATA(dref4) = NEW zdemo_abap_carr( carrid = 'XY' carrname = 'XY Airlines' ).

    "Creating an anonymous internal table
    DATA dref5 TYPE REF TO string_table.
    dref5 = NEW string_table( ( `c` ) ( `d` ) ).
    DATA(dref6) = NEW string_table( VALUE #( ( `a` ) ( `b` ) ) ).

    "-------------- Creating objects/instances of classes -------------

    "Using a cheat sheet example class (the class does not implement constructors)
    DATA oref1 TYPE REF TO zcl_demo_abap_objects.
    DATA oref2 TYPE REF TO object.  "Generic type
    "Creating an instance of a class
    oref1 = NEW #( ).
    oref2 = NEW zcl_demo_abap_objects( ).

    "Such NEW expressions replace the older syntax CREATE OBJECT (however, in the
    "context of dynamic programming, using CREATE OBJECT is still required)
    CREATE OBJECT oref1.
    CREATE OBJECT oref2 TYPE zcl_demo_abap_objects.

    "You can then, for example, use the object reference variable to access
    "components such as attributes, or you can call methods (note: instance
    "and also static components can be addressed).
    DATA(str) = oref1->public_string. "Static attribute
    oref1->another_string = `Hello`.  "Instance attribute
    oref1->string = `Hi`.             "Static attribute
    oref1->hallo_instance_method( ).
    oref1->hallo_static_method( ).

    "Using inline declarations to create an object reference variable
    "and an instance of a class
    DATA(oref3) = NEW zcl_demo_abap_objects( ).
    "Chainings are possible (the example accesses an instance attribute)
    DATA(str2) = NEW zcl_demo_abap_objects( )->another_string.

    "Example pattern for chainings
    "... NEW some_class( ... )->meth( ... ) ...

    "Chained attribute access
    "... NEW some_class( ... )->attr ...

    "Standalone method call with a NEW expression (in the case of the example
    "method, there is no parameter available)
    NEW zcl_demo_abap_objects( )->hallo_instance_method( ).

    "Assumption in the following examples: The classes have an instance constructor
    "Listing the parameter assignments for the constructor method
    "If there is only one parameter, the explicit specification of the
    "parameter name is not needed and the value can be specified directly.
*    DATA(oref4) = NEW cl_a( p1 = ... p2 = ... ).
    "Assumption: Only one parameter (of type i)
*    DATA(oref5) = NEW cl_b( 123 ).

  ENDMETHOD.
ENDCLASS.
