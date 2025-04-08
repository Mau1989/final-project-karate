


Feature: Creates a new user and get the auth token to use for access the final project features


  @Register
  Scenario: TC01 - User register successfully
    * def bodyRegister = read('classpath:resources/csv/auth/dataRegister.json')
    * def result = Java.type('java.lang.Math').random() * 10000 // Multiply by 10000 for a value between 0 and 9999
    * def intResult = result.toFixed(0) // Round to nearest integer
    * print intResult
    * def newEmail = "Mautest" + intResult + "@gmail.com" //Se crea un email dinamico
    * print newEmail
    * print bodyRegister
    * set bodyRegister.email = newEmail // Se actualiza el valor de la variable email del archivo JSON, con un valor dinamico.
    * print bodyRegister

    Given url urlBase
    And path '/api/register'
    And header Content-Type = 'application/json'
    And header Accept = 'application/json'
    And request bodyRegister
    When method post
    Then status 200
    * def token = response.access_token
    * print token

  Scenario: TC02 - User already registered error
    * def bodyRegister = read('classpath:resources/csv/auth/dataRegister.json') //Se lee in archivo JSON que contiene un usuario creado
    * print bodyRegister
    Given url urlBase
    And path '/api/register'
    And header Content-Type = 'application/json'
    And header Accept = 'application/json'
    And request bodyRegister
    When method post
    Then status 500
    * def message = response.email
    * print message

  Scenario: TC03 - Invalid email format error
    Given url urlBase
    And path '/api/register'
    And header Content-Type = 'application/json'
    And header Accept = 'application/json'
    And request {"email" : "invalid" , "password" : "20252025", "nombre" : "Mauricio" , "tipo_usuario_id" : 1 , "estado" : 1 }
    When method post
    Then status 500
    * def message = response.email
    * print message
