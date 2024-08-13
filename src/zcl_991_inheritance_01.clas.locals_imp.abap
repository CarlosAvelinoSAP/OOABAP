*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations

CLASS lclSuper DEFINITION CREATE PUBLIC.

  PUBLIC SECTION.
  PROTECTED SECTION.
    METHODS method1.
  PRIVATE SECTION.

ENDCLASS.

CLASS lclSuper IMPLEMENTATION.

  METHOD method1.

  ENDMETHOD.

ENDCLASS.

CLASS lclSub DEFINITION CREATE PUBLIC INHERITING FROM lclsuper.
  PROTECTED SECTION.
    METHODS method1 REDEFINITION.
ENDCLASS.

CLASS lclSub IMPLEMENTATION.

  METHOD method1.

  ENDMETHOD.

ENDCLASS.

CLASS lclSub2 DEFINITION CREATE PUBLIC INHERITING FROM lclSub.
  PROTECTED SECTION.
    METHODS method1 REDEFINITION.
ENDCLASS.

CLASS lclSub2 IMPLEMENTATION.

  METHOD method1.

  ENDMETHOD.

ENDCLASS.
