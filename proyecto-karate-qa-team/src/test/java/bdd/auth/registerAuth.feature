


Feature: Creates a new user and get the auth token to use for access the final project features

"""
  Scenario: TC01 - Successfully Register
    * def loginHelper = karate.call('classpath:resources/utils/loginUtils.js')
    * def loginDataList = loginHelper.createLoginData()

    * karate.forEach(loginDataList, function(loginData){
    * print loginDataList
    Given url urlBase
    And path '/api/register'
    And header Accept = 'application/json'
    And header Content-Type = 'application/json'
    And request loginDataList
    When method post
    Then status 200

    * print response
    * def token = response.access_token
    * print token})

  Scenario: TC02 - Unsuccessful register using a registered email
    Given url urlBase
    And path '/api/register'
    And header Accept = 'application/json'
    And header Content-Type = 'application/json'
    And request {"email" : "maufinal1@gmail.com" , "password" : "20252025"}
    When method post
    Then status 500
    * def message = response.message
    * print message

"""
  @Register
  Scenario: TC01 - User register successfully
    * def bodyRegister = read('classpath:resources/csv/auth/dataRegister.json')
    * def result = Java.type('java.lang.Math').random() * 10000 // Multiply by 100 for a value between 0 and 99
    * def intResult = result.toFixed(0) // Round to nearest integer
    * print intResult
    * def newEmail = "Mautest" + intResult + "@gmail.com"
    * print newEmail
    * print bodyRegister
    * set bodyRegister.email = newEmail
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
    * def bodyRegister = read('classpath:resources/csv/auth/dataRegister.json')
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
