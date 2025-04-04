Feature: Get a product data by an ID


  Background:
    * def responseLogin = call read('classpath:bdd/auth/loginAuth.feature@login')
    * def tokenAuth = responseLogin.token
    * print tokenAuth
    * url urlBase
    * header Accept = 'application/json'
    * header Authorization = 'Bearer ' + tokenAuth


  Scenario: TC01 - Get a product data successfully
    * def id = 499
    And path '/api/v1/producto/' + id
    When method get
    Then status 200


  Scenario: TC02 - Get a product data unsuccessfully providing a wrong id number
    * def id = 0
    And path '/api/v1/producto/' + id
    When method get
    Then status 404
    * print response.error