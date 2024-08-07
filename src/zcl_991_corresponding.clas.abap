CLASS zcl_991_corresponding DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
    ALIASES run FOR if_oo_adt_classrun~main.
ENDCLASS.



CLASS zcl_991_corresponding IMPLEMENTATION.


  METHOD run.


    "-------------- Patterns -------------

    "The following examples demonstrate simple assignments
    "with the CORRESPONDING operator using these syntax patterns.
    "Note:
    "- The examples show only a selection of possible additions.
    "- There are various combinations of additions possible.
    "- The effect of the statements is shown in lines commented out.

    "... CORRESPONDING #( z ) ...
    "... CORRESPONDING #( BASE ( x ) z ) ...
    "... CORRESPONDING #( z MAPPING a = b ) ...
    "... CORRESPONDING #( z EXCEPT b ) ...
    "... CORRESPONDING #( it DISCARDING DUPLICATES ) ...

    "-------------- Structures -------------

    "Data objects to work with in the examples
    "Two different structures; one component differs.
    DATA: BEGIN OF s1,
            a TYPE i,
            b TYPE c LENGTH 3,
            c TYPE c LENGTH 5,
          END OF s1.

    DATA: BEGIN OF s2,
            a TYPE i,
            b TYPE c LENGTH 3,
            d TYPE string,
          END OF s2.

    "Populating structures
    s1 = VALUE #( a = 1 b = 'aaa' c = 'bbbbb' ).
    s2 = VALUE #( a = 2 b = 'ccc' d = `dddd` ).

    "Non-identical components in the target are initialized
    s2 = CORRESPONDING #( s1 ).

*A    B      D
*1    aaa

    "Populating structure for the BASE example
    s2 = VALUE #( a = 3 b = 'eee' d = `ffff` ).

    "BASE addition: Retaining original content in target, no initialization
    s2 = CORRESPONDING #( BASE ( s2 ) s1 ).

*A    B      D
*1    aaa    ffff

    "MAPPING addition: Mapping of component names
    "For the assignment to work, note data convertibility.
    s2 = CORRESPONDING #( s1 MAPPING d = c ).

*A    B      D
*1    aaa    bbbbb

    "EXCEPT addition: Excluding components
    s2 = CORRESPONDING #( s1 EXCEPT b ).

*A    B      D
*1

    "As noted, there are various combinations possible for the additions.
    "The following example shows MAPPING and EXCEPT.
    s2 = CORRESPONDING #( s1 MAPPING d = c EXCEPT b ).

*A    B      D
*1           bbbbb

    "Specifying an asterisk (*) after EXCEPT in combination with specifying mappings
    "means that all non-specified components after MAPPING remain initial in the target
    s2 = CORRESPONDING #( s1 MAPPING d = c EXCEPT * ).

*A    B      D
*0           bbbbb

    "-------------- Internal tables -------------

    "Internal tables to work with in the examples
    DATA it1 LIKE TABLE OF s1 WITH EMPTY KEY.
    DATA it2 LIKE SORTED TABLE OF s2 WITH UNIQUE KEY a.
    DATA it3 LIKE TABLE OF s1 WITH EMPTY KEY.

    "Populating internal tables
    it1 = VALUE #( ( a = 1 b = 'aaa' c = 'bbbbb' )
                    ( a = 2 b = 'ccc' c = 'ddddd' ) ).
    it2 = VALUE #( ( a = 7 b = 'eee' d = 'fffff' ) ).
    it3 = VALUE #( ( a = 3 b = 'eee' c = 'fffff' ) ).

    it2 = CORRESPONDING #( it1 ).

*A    B      D
*1    aaa
*2    ccc

    it2 = CORRESPONDING #( BASE ( it2 ) it3 ).

*A    B      D
*1    aaa
*2    ccc
*3    eee

    it2 = CORRESPONDING #( it1 MAPPING d = c ).

*A    B      D
*1    aaa    bbbbb
*2    ccc    ddddd

    it2 = CORRESPONDING #( it1 EXCEPT b ).

*A    B      D
*1
*2

    "DISCARDING DUPLICATES: Handling duplicate lines and preventing exceptions
    it1 = VALUE #( ( a = 4 b = 'aaa' c = 'bbbbb' )
                   ( a = 4 b = 'ccc' c = 'ddddd' )
                   ( a = 5 b = 'eee' c = 'fffff' ) ).

    "Without the addition, the runtime error ITAB_DUPLICATE_KEY is raised.
    it2 = CORRESPONDING #( it1 DISCARDING DUPLICATES ).

*A    B      D
*4    aaa
*5    eee


  ENDMETHOD.
ENDCLASS.
