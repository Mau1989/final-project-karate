Feature: Update data of an existing product


  Background:
    * def responseLogin = call read('classpath:bdd/auth/loginAuth.feature@login')
    * def tokenAuth = responseLogin.token
    * print tokenAuth
    * url urlBase
    * header Accept = 'application/json'
    * header Authorization = 'Bearer ' + tokenAuth


  Scenario: TC01 - Update product data successfully
    * def bodyUpdateProduct = read('classpath:resources/csv/auth/updateProductData.json')
    * def id = 3
    * print bodyUpdateProduct
    And path '/api/v1/producto/' + id
    And request bodyUpdateProduct
    When method put
    Then status 200

  Scenario: TC02 - Update product data unsuccessfully, wrong product id provided
    * def bodyUpdateProduct = read('classpath:resources/csv/auth/updateProductData.json')
    * def id = 0
    * print bodyUpdateProduct
    And path '/api/v1/producto/' + id
    And request bodyUpdateProduct
    When method put
    Then status 500
    * print response.error