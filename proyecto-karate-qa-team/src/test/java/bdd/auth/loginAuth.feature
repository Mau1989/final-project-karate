Feature: Creates a new auth token to use for access the final project features

  @login
  Scenario: TC01 - Successfully login
    * def bodyLogin = read('classpath:resources/csv/auth/dataLogin.json')
    * print bodyLogin
    Given url urlBase
    And path '/api/login'
    And header Accept = 'application/json'
    And header Content-Type = 'application/json'
    And request bodyLogin
    When method post
    Then status 200

    * print response
    * def token = response.access_token
    * print token

  Scenario: TC02 - Unsuccessful login
    Given url urlBase
    And path '/api/login'
    And header Accept = 'application/json'
    And header Content-Type = 'application/json'
    And request {"email" : "invalid@gmail.com" , "password" : "20252025" }
    When method post
    Then status 401
    * def message = response.message
    * print message