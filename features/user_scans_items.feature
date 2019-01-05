Feature: User scans items

Background:
  Given the following pricing rules
    | code    | name              | price  | discount_2for1 | discounts_bulk_minimum_quantity | discounts_bulk_price |
    | VOUCHER | Cabify Voucher    | 5.00€  | true           | 0                               | 0                    |
    | TSHIRT  | Cabify T-Shirt    | 20.00€ | false          | 3                               | 19.00€               |
    | MUG     | Cabify Coffee Mug | 7.50€  | false          | 0                               | 0                    |

Scenario: Scanned items do not apply for any discount
  When "VOUCHER" is scanned
  And "TSHIRT" is scanned
  And "MUG" is scanned
  Then total price should be "32.50€"

Scenario: There is a 2-for-1 special on some items
  When "VOUCHER" is scanned
  And "TSHIRT" is scanned
  And "VOUCHER" is scanned
  Then total price should be "25.00€"

Scenario: There is a discounts on bulk purchases if you buy 3 or more TSHIRT items
  When "TSHIRT" is scanned
  And "TSHIRT" is scanned
  And "TSHIRT" is scanned
  And "VOUCHER" is scanned
  And "TSHIRT" is scanned
  Then total price should be "81.00€"

Scenario: There is a discounts on bulk purchases if you buy 3 or more TSHIRT items
  When "VOUCHER" is scanned
  And "TSHIRT" is scanned
  And "VOUCHER" is scanned
  And "VOUCHER" is scanned
  And "MUG" is scanned
  And "TSHIRT" is scanned
  And "TSHIRT" is scanned
  Then total price should be "74.50€"
