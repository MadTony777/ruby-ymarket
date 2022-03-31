@all
Feature: ymarket testing

  @1
  Scenario: checking filter return correct prices

    Given Open smartphones category
    Then Verify that it is smartphones category
    When Insert price from "1000"
    And Insert price to "5000"
    Then Verify that poduct list not empty
    And Verify that price from is set "1000"
    And Verify that price to is set "5000"
    And Verify all prices in filter range from "1000" to "5000"

  @2
  Scenario: checking filter return correct battery capacity

    Given Open smartphones category
    Then Verify that it is smartphones category
    When Insert battery capacity "1000-1999"
    Then Verify that poduct list not empty
    And Verify that battery capacity is set "1000-1999"
    And Verify all battery capacity on page in filter range "1000-1999"

  @3
  Scenario: checking that url filter for prices is saving

    Given Open smartphones category
    Then Verify that it is smartphones category
    When Insert price from "1000"
    And Insert price to "4500"
    And Verify that poduct list not empty
    And Save url and open it
    Then Verify that price from is set "1000"
    And Verify that price to is set "4500"
    And Verify all prices in filter range from "1000" to "4500"

  @4
  Scenario: checking that url filter for battery capacity is saving

    Given Open smartphones category
    Then Verify that it is smartphones category
    When Insert battery capacity "2000-2499"
    And Verify that poduct list not empty
    And Save url and open it
    Then Verify that battery capacity is set "2000-2499"
    And Verify all battery capacity on page in filter range "2000-2499"

  @5
  Scenario: checking that no products in list when price from > price to

    Given Open smartphones category
    Then Verify that it is smartphones category
    When Insert price from "2000"
    When Insert price to "1000"
    Then Verify that there is no products in list

  @6
  Scenario: checking that battery filter working correct on all pages

    Given Open smartphones category
    Then Verify that it is smartphones category
    When Insert price to "7000"
    And Insert battery capacity "2000-2499"
    Then Verify that poduct list not empty
    And Verify that battery capacity is set "2000-2499"
    And Verify all battery capacity on all pages in filter range "2000-2499"

  @7
  Scenario: checking that price filter working correct on all pages

    Given Open smartphones category
    Then Verify that it is smartphones category
    When Insert price from "1000"
    And Insert price to "5800"
    Then Verify that poduct list not empty
    And Verify that price from is set "1000"
    And Verify that price to is set "5800"
    And Verify all prices on all page in filter range from "1000" to "5800"

  @8
  Scenario: checking price and battery capacity filters at ones

    Given Open smartphones category
    Then Verify that it is smartphones category
    When Insert battery capacity "3000-3499"
    Then Verify that poduct list not empty
    When Insert price from "4000"
    When Insert price to "8000"
    Then Verify that poduct list not empty
    And Verify that battery capacity is set "3000-3499"
    And Verify that price from is set "4000"
    And Verify that price to is set "8000"
    And Verify all prices in filter range from "4000" to "8000"
    And Verify all battery capacity on page in filter range "3000-3499"

  @9
  Scenario: checking validation of field price from

    Given Open smartphones category
    Then Verify that it is smartphones category
    When Insert price from "Abc"
    Then Verify that price from is not set "Abc"
    When Insert price from "    "
    Then Verify that price from is not set "    "
    When Insert price from "?>|~_"
    Then Verify that price from is not set "?>|~_"

  @10
  Scenario: checking validation of field price to

    Given Open smartphones category
    Then Verify that it is smartphones category
    When Insert price to "Abc"
    Then Verify that price to is not set "Abc"
    When Insert price to "    "
    Then Verify that price to is not set "    "
    When Insert price to "?>|~_"
    Then Verify that price to is not set "?>|~_"

  @11
  Scenario: checking filter return correct battery capacity and price

    Given Open smartphones category
    Then Verify that it is smartphones category
    When Insert price from "3000"
    When Insert price to "8000"
    And Verify that poduct list not empty
    Then Verify that price from is set "3000"
    Then Verify that price to is set "8000"
    When Insert battery capacity "3000-3499"
    And Verify that poduct list not empty
    Then Verify that battery capacity is set "3000-3499"
    And Verify all prices in filter range from "3000" to "8000"
    And Verify all battery capacity on page in filter range "3000-3499"

  @12
  Scenario: checking that button clear filter prices from is working
    Given Open smartphones category
    Then Verify that it is smartphones category
    When Insert price from "2000"
    Then Verify that price from is set "2000"
    When Click clear button price "от"
    Then Verify that price "2000" from was cleared
    And Verify that products not in filer price from "2000" range

  @13
  Scenario: checking that button clear filter prices to is working

    Given Open smartphones category
    Then Verify that it is smartphones category
    When Insert price to "5000"
    Then Verify that price to is set "5000"
    When Click clear button price "до"
    Then Verify that price "5000" to was cleared
    And Verify that products not in filer price to "5000" range

  @14
  Scenario: checking that cancel battery filter is working correct

    Given Open smartphones category
    Then Verify that it is smartphones category
    When Insert battery capacity "2000-2499"
    Then Verify that battery capacity is set "2000-2499"
    When Insert battery capacity "2000-2499"
    And Verify all battery capacity not in filter range "2000-2499"

  @15
  Scenario: checking that previous count by price working correct

    Given Open smartphones category
    Then Verify that it is smartphones category
    When Insert price from "1000"
    And Insert price to "8000"
    And Verify that poduct list not empty
    Then Verify that previous count equal to product list count

  @16
  Scenario: checking that previous count by battery capacity working correct

    Given Open smartphones category
    Then Verify that it is smartphones category
    When Insert battery capacity "1000-1999"
    And Verify that poduct list not empty
    Then Verify that previous count equal to product list count

  @17
  Scenario: checking acceptable length of field from

    Given Open smartphones category
    Then Verify that it is smartphones category
    When Insert price from "12345678912345678"
    Then Wait
    And Verify that price from is set "12345678910000000"

  @18
  Scenario: checking acceptable length of field to

    Given Open smartphones category
    Then Verify that it is smartphones category
    When Insert price to "12345678912345678"
    Then Wait
    And Verify that price to is set "12345678910000000"

  @19
  Scenario: checking filter return correct battery capacity 2

    Given Open smartphones category
    Then Verify that it is smartphones category
    When Insert battery capacity "2500-2999"
    Then Verify that poduct list not empty
    And Verify that battery capacity is set "2500-2999"
    And Verify all battery capacity on page in filter range "2500-2999"

  @20
  Scenario: checking filter return correct battery capacity 3

    Given Open smartphones category
    Then Verify that it is smartphones category
    When Insert battery capacity "3500-4499"
    Then Verify that poduct list not empty
    And Verify that battery capacity is set "3500-4499"
    And Verify all battery capacity on page in filter range "3500-4499"