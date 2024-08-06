CLASS zcl_991_sql_string_functions DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
    ALIASES run FOR if_oo_adt_classrun~main.
ENDCLASS.



CLASS zcl_991_sql_string_functions IMPLEMENTATION.


  METHOD run.

    SELECT SINGLE
      carrid,    "LH
      carrname,  "Lufthansa
      url,       "http://www.lufthansa.com

      "Concatenates strings, ignores trailing blanks
      "Result: LHLufthansa
      concat( carrid, carrname ) AS concat,

      "Concatenates strings, number denotes the blanks that are inserted
      "Result: LH Lufthansa
      concat_with_space( carrid, carrname, 1 ) AS concat_with_space,

      "First letter of a word -> uppercase, all other letters -> lowercase;
      "note that a space and other special characters means a new word.
      "Result: Http://Www.Lufthansa.Com
      initcap( url ) AS initcap,

      "Position of the first occurrence of the substring specified
      "Result: 6
      instr( carrname,'a' ) AS instr,

      "String of length n starting from the left of an expression;
      "trailing blanks are ignored
      "Result: Luft
      left( carrname, 4 ) AS left,

      "Number of characters in an expression, trailing blanks are ignored
      "Result: 24
      length( url ) AS length,

      "Checks if expression contains a PCRE expression;
      "case-sensitive by default (case_sensitive parameter can be specified)
      "Notes on the result: 1 = found, 0 = not found
      "Result: 1
      like_regexpr( pcre  = '\..',  "Period that is followed by any character
                    value = url ) AS like_regex,

      "Returns position of a substring in an expression,
      "3rd parameter = specifies offset (optional)
      "4th parameter = determines the number of occurrences (optional)
      "Result: 9
      locate( carrname, 'a', 0, 2 ) AS locate,

      "Searches a PCRE pattern, returns offset of match;
      "many optional parameters: occurrence, case_sensitive, start, group
      "Result: 21
      locate_regexpr( pcre = '\..', "Period followed by any character
                      value = url,
                      occurrence = 2 ) "2nd occurrence in the string
                      AS locate_regexpr,

      "Searches a PCRE pattern, returns offset of match + 1;
      "many optional parameters: occurrence, case_sensitive, start, group
       "Result: 2
      locate_regexpr_after( pcre = '.',  "Any character
                            value = url,
                            occurrence = 1 ) AS locate_regexpr_after,

      "Removes leading characters as specified in the 2nd argument,
      "trailing blanks are removed
      "Result: ufthansa
      ltrim( carrname, 'L' ) AS ltrim,

      "Counts all occurrences of found PCRE patterns
      "Result: 2
      occurrences_regexpr( pcre = '\..', "Period that is followed by any character
                           value = url ) AS occ_regex,

      "Replaces the 2nd argument with the 3rd in an expression
      "Result: Lufth#ns#
      replace( carrname, 'a', '#' ) AS replace,

      "Replaces a found PCRE expression;
      "more parameters possible: occurrence, case_sensitive, start
       "Result: http://www#ufthansa#om
      replace_regexpr( pcre = '\..', "Period that is followed by any character
                       value = url,
                       with = '#' ) AS replace_regex,

      "Extracts a string with the length specified starting from the right
      "Result: hansa
      right( carrname, 5 ) AS right,

      "Expands string to length n (2nd argument); trailing blanks produced
      "are replaced by the characters from the (3rd) argument
      "Note that if n is less than the string, the expression is truncated
      "on the right.
      "Result: Lufthansa###
      rpad( carrname, 12, '#' ) AS rpad,

      "All trailing characters that match the character of the 2nd argument
      "are removed; trailing blanks are removed, too
      "Result: Lufthans
      rtrim( carrname, 'a' ) AS rtrim,

      "Returns a substring; 2nd argument = position from where to start;
      "3rd argument: length of the extracted substring
      "Result: fth
      substring( carrname, 3, 3 ) AS substring,

      "Searches for a PCRE expression and returns the matched substring
      "More parameters possible: occurrence, case_sensitive, start, group
      "Result: .lu
      substring_regexpr( pcre = '\...', "Period that is followed by any two characters
                         value = url ) AS substring_regexpr,

      "All lower case letters are transformed to upper case letters
      "Result: LUFTHANSA
      upper( carrname ) AS upper

      FROM zdemo_abap_carr
      WHERE carrid = 'LH'
      INTO @DATA(string_functions).
    out->write( string_functions ).

  ENDMETHOD.
ENDCLASS.
