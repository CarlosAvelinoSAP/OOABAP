CLASS zcl_991_constructor_expression DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_991_CONSTRUCTOR_EXPRESSION IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.


    "-------------- Populating structures/internal tables with VALUE --------------

    "Declaring structured data type and structured data object
    TYPES: BEGIN OF struc_type,
             a TYPE i,
             b TYPE c LENGTH 3,
           END OF struc_type.

    DATA struc TYPE struc_type.

    "Using VALUE constructor expression
    "Note: The data type can be retrieved from the context. Then, # can
    "be specified.
    struc = VALUE #( a = 1 b = 'aaa' ).

    "Using an inline declaration
    "In the following example, the type cannot be retrieved from the
    "context. Therefore, an explicit specification of the type is
    "required.
    DATA(struc2) = VALUE struc_type( a = 2 b = 'bbb' ).

    "The following syntax is also possible (explicit data type
    "specification although the type can be determined).
    struc = VALUE struc_type( a = 3 b = 'ccc' ).

    "Using such a VALUE constructor expression instead of, for example,
    "assigning the component values individually using the component
    "selector (-).
    struc-a = 4.
    struc-b = 'ddd'.

    "Internal table
    "Note the extra pair of parentheses for an individual table line.
    DATA itab TYPE TABLE OF struc_type WITH EMPTY KEY.

    itab = VALUE #( ( a = 5 b = 'eee' )
                    ( a = 6 b = 'fff' ) ).

    "Using such a VALUE constructor expression instead of, for example,
    "APPEND statements (note the BASE addition for retaining existing
    "table lines further down)
    APPEND struc TO itab.
    APPEND INITIAL LINE TO itab.

    "Inline declaration, explicit table type specification after VALUE
    TYPES itab_type TYPE TABLE OF struc_type WITH EMPTY KEY.
    DATA(itab2) = VALUE itab_type( ( a = 7 b = 'ggg' )
                                   ( a = 8 b = 'hhh' ) ).

    "Internal table with an elementary line type
    "Unstructured line types work without component names.
    DATA(itab3) = VALUE string_table( ( `Hello` )
                                      ( `world` ) ).

    "-------------- Creating initial values --------------

    "Type-specific initial value for data objects by leaving the
    "VALUE constructor expression empty
    "Structure (the entire structure is initial)
    struc = VALUE #( ).

    "Internal table
    DATA(itab4) = VALUE itab_type( ).
    "This basically corresponds to the following data object declarations
    "DATA itab5 TYPE itab_type.
    "DATA itab6 TYPE itab_type VALUE IS INITIAL.

    "Not specifying individual components means these components
    "remain initial
    "Component b not specified, i.e. b remains initial
    struc = VALUE #( a = 2 ).
    "Explicitly setting an initial value for a component
    struc = VALUE #( a = 1 b = VALUE #( ) ).
    "All component values of the first line added are initial
    itab4 = VALUE #( ( ) ( a = 1 b = 'aaa' ) ).

    "Initial values can be created for all types, e.g. also for elementary types.
    "VALUE cannot be used to create elementary data objects and provide concrete
    "values, however, an empty VALUE expression can be used to create elementary
    "data objects with type-specific initial values.
    DATA(int) = VALUE i( ).
    DATA int2 TYPE i.
    int2 = VALUE #( ).
    DATA(xstr) = VALUE xstring( ).

    "-------------- VALUE constructor used for nested/deep data objects  --------------

    "Creating a nested structure
    DATA: BEGIN OF nested_struc,
            a TYPE i,
            BEGIN OF struct,
              b TYPE i,
              c TYPE c LENGTH 3,
            END OF struct,
          END OF nested_struc.

    "Populating a nested structure
    nested_struc = VALUE #( a = 1 struct = VALUE #( b = 1 c = 'aaa' ) ).

    "Instead of, for example, using the component selector
    nested_struc-a = 2.
    nested_struc-struct-b = 3.
    nested_struc-struct-c = 'bbb'.

    "Deep table
    TYPES deep_itab_type LIKE TABLE OF nested_struc WITH EMPTY KEY.
    DATA(deep_itab) = VALUE deep_itab_type( ( nested_struc ) "Adding an existing structure
                                            ( a = 3 struct = VALUE #( b = 3 c = 'ccc' ) )
                                            ( a = 4 struct = VALUE #( b = 4 c = 'ddd' ) ) ).

    "-------------- Additions to VALUE constructor expressions --------------
    "Note: LET and FOR expressions can be added to VALUE constructor expressions.
    "Find more information further down.

    "-------------- BASE addition --------------

    "A constructor expression without the BASE addition initializes the target variable.
    "Therefore, you can use the addition if you do not want to construct a structure or
    "internal table from scratch but keep existing content.

    "Populating a structure
    struc = VALUE #( a = 1 b = 'aaa' ).

    "struc is not initialized, only component b is modified, value of a is kept
    struc = VALUE #( BASE struc b = 'bbb' ).

    "Populating an internal table
    itab = VALUE #( ( a = 1 b = 'aaa' )
                    ( a = 2 b = 'bbb' ) ).

    "Two more lines are added, existing content is preserved, the internal table is not
    "initialized
    itab = VALUE #( BASE itab
                    ( a = 3 b = 'ccc' )
                    ( a = 4 b = 'ddd' ) ).

    "-------------- LINES OF addition -------------

    "All or some lines of another table can be included in the target internal table
    "(provided that they have appropriate line types).
    "With the LINES OF addition, more additions can be specified.

    DATA(itab5) = itab.
    DATA(itab6) = itab.
    itab = VALUE #( ( a = 1 b = 'aaa' )
                    ( a = 2 b = 'bbb' )
                    ( LINES OF itab5 )                 "All lines of itab5
                    ( LINES OF itab6 FROM 2 TO 4 ) ).  "Specific lines of itab6

    itab = VALUE #( ( LINES OF itab5 STEP 2 ) "Adding every second line
                    ( LINES OF itab6 USING KEY primary_key ) ). "Specifying a table key


    "-------------- Short form for internal tables with structured line types --------------
    "- Assignments of values to individual structure components are possible outside of inner
    "  parentheses
    "- In that case, all of the following components in the inner parentheses are assigned that
    "  value.
    "- The assignment is made up to the next explicit assignment for the corresponding component.

    TYPES: BEGIN OF structype,
             a TYPE i,
             b TYPE c LENGTH 3,
             c TYPE string,
           END OF structype.
    TYPES tabtype TYPE TABLE OF structype WITH EMPTY KEY.

    DATA(itab7) = VALUE tabtype( b = 'aaa'           ( a = 1 c = `xxx` )
                                                     ( a = 2 c = `yyy` )
                                 b = 'bbb' c = `zzz` ( a = 3 )
                                                     ( a = 4 ) ).

*A    B      C
*1    aaa    xxx
*2    aaa    yyy
*3    bbb    zzz
*4    bbb    zzz

    "This option can be handy in various contexts, for example, in a
    "ranges table.
    TYPES int_tab_type TYPE TABLE OF i WITH EMPTY KEY.
    "Populating an integer table with values from 1 to 20 (see iteration
    "expressions with FOR further down)
    DATA(inttab) = VALUE int_tab_type( FOR x = 1 WHILE x <= 20 ( x ) ).

    DATA rangetab TYPE RANGE OF i.

    "Populating a range table using VALUE and the short form
    rangetab = VALUE #( sign   = 'I'
                        option = 'BT' ( low = 1  high = 3 )
                                      ( low = 6  high = 8 )
                                      ( low = 12 high = 15 )
                        option = 'GE' ( low = 18 ) ).

    "Using a SELECT statement to retrieve internal table content
    "based on the range table specifications
    SELECT * FROM @inttab AS tab
        WHERE table_line IN @rangetab
        INTO TABLE @DATA(result).
    "result: 1, 2, 3, 6, 7, 8, 12, 13, 14, 15, 18, 19, 20

    "The following EML statement creates RAP BO instances. The BDEF derived
    "type is created inline. With the CREATE FROM addition, the %control values
    "must be specified explicitly. You can provide the corresponding values
    "for all table lines using the short form instead of individually
    "specifying the values for each instance.
    MODIFY ENTITIES OF zdemo_abap_rap_ro_m
        ENTITY root
        CREATE FROM VALUE #(
            %control-key_field = if_abap_behv=>mk-on
            %control-field1    = if_abap_behv=>mk-on
            %control-field2    = if_abap_behv=>mk-on
            %control-field3    = if_abap_behv=>mk-on
            %control-field4    = if_abap_behv=>mk-off
            ( %cid      = 'cid1'
              key_field = 1
              field1    = 'aaa'
              field2    = 'bbb'
              field3    = 10
              field4    = 100 )
            ( %cid      = 'cid2'
              key_field = 2
              field1    = 'ccc'
              field2    = 'ddd'
              field3    = 20
              field4    = 200 ) )
        MAPPED DATA(m)
        FAILED DATA(f)
        REPORTED DATA(r).

  ENDMETHOD.
ENDCLASS.
