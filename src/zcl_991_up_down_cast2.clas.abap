CLASS zcl_991_up_down_cast2 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_991_up_down_cast2 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    "------------ Object reference variables ------------

    "Static and dynamic types
    "Defining an object reference variable with a static type
    DATA tdo TYPE REF TO cl_abap_typedescr.

    "Retrieving type information
    "The reference the reference variable points to is either cl_abap_elemdescr,
    "cl_abap_enumdescr, cl_abap_refdescr, cl_abap_structdescr, or cl_abap_tabledescr.
    "So, it points to one of the subclasses. The static type of tdo refers to
    "cl_abap_typedescr, however, the dynamic type is one of the subclasses mentioned.
    "in the case of the example, it is cl_abap_elemdescr. Check in the debugger.
    DATA some_string TYPE string.
    tdo = cl_abap_typedescr=>describe_by_data( some_string ).

    "Some more object reference variables
    DATA tdo_super TYPE REF TO cl_abap_typedescr.
    DATA tdo_elem TYPE REF TO cl_abap_elemdescr.
    DATA tdo_data TYPE REF TO cl_abap_datadescr.
    DATA tdo_gen_obj TYPE REF TO object.

    "------------ Upcasts ------------

    "Moving up the inheritance tree
    "Assignments:
    "- If the static type of target variable is less specific or the same, an assignment works.
    "- The target variable inherits the dynamic type of the source variable.

    "Static type of target variable is the same
    tdo_super = tdo.

    "Examples for static types of target variables that are less specific
    "Target variable has the generic type object
    tdo_gen_obj = tdo.

    "Target variable is less specific because the direct superclass of cl_abap_elemdescr
    "is cl_abap_datadescr
    "Note: In the following three assignments, the target variable remains initial
    "since the source variables do not (yet) point to any object.
    tdo_data = tdo_elem.

    "Target variable is less specific because the direct superclass of cl_abap_datadescr
    "is cl_abap_typedescr
    tdo_super = tdo_data.

    "Target variable is less specific because the class cl_abap_typedescr is higher up in
    "the inheritance tree than cl_abap_elemdescr
    tdo_super = tdo_elem.

    "The casting happens implicitly. You can also excplicitly cast and use
    "casting operators, but it is usually not required.
    tdo_super = CAST #( tdo ).
    tdo_super ?= tdo.

    "In combination with inline declarations, the CAST operator can be used to provide a
    "reference variable with a more general type.
    DATA(tdo_inl_cast) = CAST cl_abap_typedescr( tdo_elem ).

    CLEAR: tdo_super, tdo_elem, tdo_data, tdo_gen_obj.

    "------------ Downcasts ------------

    "Moving down the inheritance tree
    "Assignments:
    "- If the static type of the target variable is more specific than the static type
    "  of the source variable, performing a check whether it is less specific or the same
    "  as the dynamic type of the source variable is required at runtime before the assignment
    "- The target variable inherits the dynamic type of the source variable, however, the target
    "  variable can accept fewer dynamic types than the source variable
    "- Downcasts are always performed explicitly using casting operators

    "Static type of the target is more specific
    "object -> cl_abap_typedescr
    tdo_super = CAST #( tdo_gen_obj ).
    "cl_abap_typedescr -> cl_abap_datadescr
    "Note: Here, the dynamic type of the source variable is cl_abap_elemdescr.
    tdo_data = CAST #( tdo ).
    "cl_abap_datadescr -> cl_abap_elemdescr
    tdo_elem = CAST #( tdo_data ).
    "cl_abap_typedescr -> cl_abap_elemdescr
    tdo_elem = CAST #( tdo_super ).

    "------------ Error prevention in downcasts ------------

    "In the examples above, the assignments work. The following code snippets
    "deal with examples in which a downcast is not possible. An exception is
    "raised.
    DATA str_table TYPE string_table.
    DATA tdo_table TYPE REF TO cl_abap_tabledescr.

    "With the following method call, tdo points to an object with
    "reference to cl_abap_tabledescr.
    tdo = cl_abap_typedescr=>describe_by_data( str_table ).

    "Therefore, the following downcast works.
    tdo_table = CAST #( tdo ).

    "You could also achieve the same in one statement and with inline
    "declaration.
    DATA(tdo_table_2) = CAST cl_abap_tabledescr( cl_abap_typedescr=>describe_by_data( str_table ) ).

    "Example for an impossible downcast
    "The generic object reference variable points to cl_abap_elemdescr after the following
    "assignment.
    tdo_gen_obj = cl_abap_typedescr=>describe_by_data( some_string ).

    "Without catching the exception, the runtime error MOVE_CAST_ERROR
    "occurs. There is no syntax error at compile time. The static type of
    "tdo_gen_obj is more general than the static type of the target variable.
    "The error occurs when trying to downcast, and the dynamic type is used.
    TRY.
        tdo_table = CAST #( tdo_gen_obj ).
      CATCH cx_sy_move_cast_error.
    ENDTRY.
    "Note: tdo_table still points to the reference as assigned above after trying
    "to downcast in the TRY control structure.

    "Using CASE TYPE OF and IS INSTANCE OF statements, you can check if downcasts
    "are possible.
    "Note: In case of ...
    "- non-initial object reference variables, the dynamic type is checked.
    "- initial object reference variables, the static type is checked.

    "------------ IS INSTANCE OF ------------
    DATA some_tdo TYPE REF TO cl_abap_typedescr.
    some_tdo = cl_abap_typedescr=>describe_by_data( str_table ).

    IF some_tdo IS INSTANCE OF cl_abap_elemdescr.
      DATA(tdo_a) = CAST cl_abap_elemdescr( some_tdo ).
    ELSE.
      "This branch is executed. The downcast is not possible.
      ...
    ENDIF.

    IF some_tdo IS INSTANCE OF cl_abap_elemdescr.
      DATA(tdo_b) = CAST cl_abap_elemdescr( some_tdo ).
    ELSEIF some_tdo IS INSTANCE OF cl_abap_refdescr.
      DATA(tdo_c) = CAST cl_abap_refdescr( some_tdo ).
    ELSEIF some_tdo IS INSTANCE OF cl_abap_structdescr.
      DATA(tdo_d) = CAST cl_abap_structdescr( some_tdo ).
    ELSEIF some_tdo IS INSTANCE OF cl_abap_tabledescr.
      "In this example, this branch is executed. With the check,
      "you can make sure that the downcast is indeed possible.
      DATA(tdo_e) = CAST cl_abap_tabledescr( some_tdo ).
    ELSE.
      ...
    ENDIF.

    DATA initial_tdo TYPE REF TO cl_abap_typedescr.

    IF initial_tdo IS INSTANCE OF cl_abap_elemdescr.
      DATA(tdo_f) = CAST cl_abap_elemdescr( some_tdo ).
    ELSEIF initial_tdo IS INSTANCE OF cl_abap_refdescr.
      DATA(tdo_g) = CAST cl_abap_refdescr( some_tdo ).
    ELSEIF initial_tdo IS INSTANCE OF cl_abap_structdescr.
      DATA(tdo_h) = CAST cl_abap_structdescr( some_tdo ).
    ELSEIF initial_tdo IS INSTANCE OF cl_abap_tabledescr.
      DATA(tdo_i) = CAST cl_abap_tabledescr( some_tdo ).
    ELSE.
      "In this example, this branch is executed. The static
      "type of the initial object reference variable is used,
      "which is cl_abap_typedescr here.
      ...
    ENDIF.

    "------------ CASE TYPE OF ------------
    "The examples are desinged similarly to the IS INSTANCE OF examples.

    DATA(dref) = REF #( str_table ).
    some_tdo = cl_abap_typedescr=>describe_by_data( dref ).

    CASE TYPE OF some_tdo.
      WHEN TYPE cl_abap_elemdescr.
        DATA(tdo_j) = CAST cl_abap_elemdescr( some_tdo ).
      WHEN TYPE cl_abap_refdescr.
        "In this example, this branch is executed. With the check,
        "you can make sure that the downcast is indeed possible.
        DATA(tdo_k) = CAST cl_abap_refdescr( some_tdo ).
      WHEN TYPE cl_abap_structdescr.
        DATA(tdo_l) = CAST cl_abap_structdescr( some_tdo ).
      WHEN TYPE cl_abap_tabledescr.
        DATA(tdo_m) = CAST cl_abap_tabledescr( some_tdo ).
      WHEN OTHERS.
        ...
    ENDCASE.

    "Example with initial object reference variable
    CASE TYPE OF initial_tdo.
      WHEN TYPE cl_abap_elemdescr.
        DATA(tdo_n) = CAST cl_abap_elemdescr( some_tdo ).
      WHEN TYPE cl_abap_refdescr.
        DATA(tdo_o) = CAST cl_abap_refdescr( some_tdo ).
      WHEN TYPE cl_abap_structdescr.
        DATA(tdo_p) = CAST cl_abap_structdescr( some_tdo ).
      WHEN TYPE cl_abap_tabledescr.
        DATA(tdo_q) = CAST cl_abap_tabledescr( some_tdo ).
      WHEN OTHERS.
        "In this example, this branch is executed. The static
        "type of the initial object reference variable is used,
        "which is cl_abap_typedescr here.
        ...
    ENDCASE.

**********************************************************************

    "------------ Data reference variables ------------

    "Declaring data reference variables
    DATA ref1 TYPE REF TO i.
    DATA ref2 TYPE REF TO i.

    ref1 = NEW #( 789 ).

    "Assignments
    ref2 = ref1.

    "Casting

    "Complete type
    DATA(ref3) = NEW i( 321 ).

    "Generic type
    DATA ref4 TYPE REF TO data.

    "Upcast
    ref4 = ref3.

    "Downcasts
    DATA ref5 TYPE REF TO i.

    "Generic type
    DATA ref6 TYPE REF TO data.

    ref6 = NEW i( 654 ).
    ref5 = CAST #( ref6 ).

    "Casting operator in older syntax
    ref5 ?= ref6.

    "Note: The cast operators can also but need not be specified for upcasts.
    ref4 = CAST #( ref3 ).

  ENDMETHOD.
ENDCLASS.
