
Feature: Add a new product


  Background:

    * def responseLogin = call read('classpath:bdd/auth/loginAuth.feature@login')
    * def tokenAuth = responseLogin.token
    * print tokenAuth
    * url urlBase
    * header Accept = 'application/json'
    * header Authorization = 'Bearer ' + tokenAuth

  @ID
  Scenario: TC01 - Create a product successfully
    * def result = Java.type('java.lang.Math').random() * 100 // Multiply by 100 for a value between 0 and 99
    * def intResult = result.toFixed(0) // Round to nearest integer
    * def bodyCreateProduct = read('classpath:resources/csv/auth/newProductData.json')
    * print bodyCreateProduct
    * def newProductId = 'MA0' + intResult
    * set bodyCreateProduct.codigo = newProductId
    And path '/api/v1/producto'
    And request bodyCreateProduct
    When method post
    Then status 200

  Scenario: TC02 - Error when try to create an existing product
    * def bodyCreateProduct = read('classpath:resources/csv/auth/newProductData.json')
    * print bodyCreateProduct
    And path '/api/v1/producto'
    And request bodyCreateProduct
    When method post
    Then status 500
    * print response.error

  Scenario: TC03 - Error when try to create a product missing the codigo variable

    * def bodyCreateProductError =
    """
    {

      "nombre": "Turbo Intercooler",
      "medida": "UND ",
      "marca": "Generico",
      "categoria": "Repuestos",
      "precio": "100.00",
      "stock": "48",
      "estado": "3",
      "descripcion": "Turbo intercooler Toyota Hilux"
    }
    """
    * print bodyCreateProductError
    And path '/api/v1/producto'
    And request bodyCreateProductError
    When method post
    Then status 500
    * print response.codigo

  Scenario: TC04 - Error when try to create a product using an un-existing value for the variable marca

    * def bodyCreateProductError =
    """
    {
      "codigo": "MA005",
      "nombre": "Turbo Intercooler",
      "medida": "UND ",
      "marca": "Generico1",
      "categoria": "Repuestos",
      "precio": "100.00",
      "stock": "48",
      "estado": "3",
      "descripcion": "Turbo intercooler Toyota Hilux"
    }
    """
    * print bodyCreateProductError
    And path '/api/v1/producto'
    And request bodyCreateProductError
    When method post
    Then status 500
    * print response.error