*"* use this source file for any type of declarations (class
*"* definitions, interfaces or type declarations) you need for
*"* components in the private section
    TYPES: BEGIN OF st_connection,
             carrier_id      TYPE /dmo/carrier_id,
             connection_id   TYPE /dmo/connection_id,
             airport_from_id TYPE /dmo/airport_from_id,
             airport_to_id   TYPE /dmo/airport_to_id,
             carrier_name    TYPE /dmo/carrier_name,
           END OF st_connection.
    TYPES tt_connections TYPE STANDARD TABLE OF st_connection
       WITH NON-UNIQUE KEY carrier_id connection_id.
*    DATA connections TYPE tt_connections.
    TYPES: BEGIN OF st_carrier,
             carrier_id    TYPE /dmo/carrier_id,
             carrier_name  TYPE /dmo/carrier_name,
             currency_code TYPE /dmo/currency_code,
           END OF st_carrier.
    TYPES tt_carriers TYPE STANDARD TABLE OF st_carrier
    WITH NON-UNIQUE KEY carrier_id.
*    DATA carriers TYPE tt_carriers.
* Example 1: APPEND with structured data object (work area)
********************************************************************** *
*    DATA connection TYPE st_connection. " Declare the work area with LIKE LINE OF
