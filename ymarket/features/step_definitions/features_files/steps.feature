@all
Feature: ymarket testing
@1
  Scenario: checking filter return correct prices

    Given Open smartphones category
    Then Verify that it is smartphones category
    When Insert price from "1000"
    Then Verify that price from is set "1000"
    When Insert price to "2000"
    Then Verify that price to is set "2000"
    And Verify all prices in filter range from "1000" to "2000"

  Scenario: checking filter return correct battery capacity

    Given Open smartphones category
    Then Verify that it is smartphones category
    When Insert battery capacity "1000-1999"
    Then Verify that battery capacity is set "1000-1999"
    And Verify all battery capacity on page in filter range "1000-1999"

  Scenario: checking that url filter for prices is saving

    Given Open smartphones category
    Then Verify that it is smartphones category
    When Insert price from "1000"
    And Insert price to "2000"
    And Save url and open it
    Then Verify that price from is set "1000"
    And Verify that price to is set "2000"
    And Verify all prices in filter range from "1000" to "2000"

  Scenario: checking that url filter for battery capacity is saving

    Given Open smartphones category
    Then Verify that it is smartphones category
    When Insert battery capacity "2000-2499"
    And Save url and open it
    Then Verify that battery capacity is set "2000-2499"
    And Verify all battery capacity on page in filter range "2000-2499"

  Scenario: checking that no products in list when price from > price to

    Given Open smartphones category
    Then Verify that it is smartphones category
    When Insert price from "2000"
    When Insert price to "1000"
    Then Verify that there is no products in list

  Scenario: checking that battery filter working correct on all pages

    Given Open smartphones category
    Then Verify that it is smartphones category
    When Insert battery capacity "3500-4499"
    Then Verify that battery capacity is set "3500-4499"
    And Verify all battery capacity on all pages in filter range "3500-4499"

  Scenario: checking that price filter working correct on all pages

    Given Open smartphones category
    Then Verify that it is smartphones category
    When Insert price from "1000"
    And Insert price to "2000"
    Then Verify that price from is set "1000"
    And Verify that price to is set "2000"
    And Verify all prices on all page in filter range from "1000" to "2000"

  Scenario: checking price and battery capacity filters at ones

    Given Open smartphones category
    Then Verify that it is smartphones category
    When Insert battery capacity "2000-2499"
    Then Verify that battery capacity is set "2000-2499"
    When Insert price from "1000"
    Then Verify that price from is set "1000"
    When Insert price to "2000"
    Then Verify that price to is set "2000"
    And Verify all battery capacity on page in filter range "2000-2499"
    And Verify all prices in filter range from "1000" to "2000"


  Scenario: checking validation of field price from

    Given Open smartphones category
    Then Verify that it is smartphones category
    When Insert price from "Abc"
    Then Verify that price from is not set "Abc"
    And Verify that there is no products in list
    When Insert price from "    "
    Then Verify that price from is not set "    "
    And Verify that there is no products in list
    When Insert price from "?>|~_"
    Then Verify that price from is not set "?>|~_"
    And Verify that there is no products in list

  Scenario: checking validation of field price to

    Given Open smartphones category
    Then Verify that it is smartphones category
    When Insert price to "Abc"
    Then Verify that price to is not set "Abc"
    And Verify that there is no products in list
    When Insert price to "    "
    Then Verify that price to is not set "    "
    And Verify that there is no products in list
    When Insert price to "?>|~_"
    Then Verify that price to is not set "?>|~_"
    And Verify that there is no products in list

  Scenario: checking filter return correct battery capacity and price

    Given Open smartphones category
    Then Verify that it is smartphones category
    When Insert price from "3000"
    Then Verify that price from is set "3000"
    When Insert price to "4000"
    Then Verify that price to is set "4000"
    When Insert battery capacity "3000-3499"
    Then Verify that battery capacity is set "3000-3499"
    And Verify all prices in filter range from "3000" to "4000"
    And Verify all battery capacity on page in filter range "3000-3499"

  Scenario: checking that button clear filter prices from is working
    Given Open smartphones category
    Then Verify that it is smartphones category
    When Insert price from "2000"
    Then Verify that price from is set "2000"
    When Click clear button price "от"
    Then Verify that price "2000" from was cleared
    And Verify that products not in filer price from "2000" range

  Scenario: checking that button clear filter prices to is working

    Given Open smartphones category
    Then Verify that it is smartphones category
    When Insert price to "5000"
    Then Verify that price to is set "5000"
    When Click clear button price "до"
    Then Verify that price "5000" to was cleared
    And Verify that products not in filer price to "5000" range

  Scenario: checking that cancel battery filter is working correct

    Given Open smartphones category
    Then Verify that it is smartphones category
    When Insert battery capacity "2500-2999"
    Then Verify that battery capacity is set "2500-2999"
    When Insert battery capacity "2500-2999"
    And Verify all battery capacity not in filter range "2500-2999"

  Scenario: checking that previous count by price working correct

    Given Open smartphones category
    Then Verify that it is smartphones category
    When Insert price from "1700"
    And Insert price to "2000"
    Then Verify that previous count equal to product list count

  Scenario: checking that previous count by battery capacity working correct

    Given Open smartphones category
    Then Verify that it is smartphones category
    When Insert battery capacity "2000-2499"
    Then Verify that previous count equal to product list count