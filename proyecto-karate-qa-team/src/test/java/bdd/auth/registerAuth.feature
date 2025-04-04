Feature: Creates a new user and get the auth token to use for access the final project features


  Scenario: TC01 - User register successfully
    Given url urlBase
    And path '/api/register'
    And header Content-Type = 'application/json'
    And header Accept = 'application/json'
    And request {"email" : "maufinal@gmail.com" , "password" : "20252025", "nombre" : "Mauricio" , "tipo_usuario_id" : 1 , "estado" : 1 }
    When method post
    Then status 200
    * def token = response.access_token
    * print token

  Scenario: TC02 - User already registered error
    Given url urlBase
    And path '/api/register'
    And header Content-Type = 'application/json'
    And header Accept = 'application/json'
    And request {"email" : "maufinal@gmail.com" , "password" : "20252025", "nombre" : "Mauricio" , "tipo_usuario_id" : 1 , "estado" : 1 }
    When method post
    Then status 500
    * def message = response.email
    * print message
