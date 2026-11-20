Feature: Servicio de autenticación (login) de Demoblaze
  POST https://api.demoblaze.com/login
  Entrada: JSON { username, password (Base64) }

  Background:
    * url baseUrl
    * def username = 'qa_login_' + java.lang.System.currentTimeMillis()
    * def password = toBase64('Test1234')
    # Precondición: crear un usuario propio para no depender de datos existentes
    Given path 'signup'
    And request { username: '#(username)', password: '#(password)' }
    When method post
    Then status 200
    And match response.trim() == '""'

  Scenario: Caso 3 - Usuario y password correctos
    * def body = { username: '#(username)', password: '#(password)' }
    * print 'ENTRADA login (credenciales correctas):', body
    Given path 'login'
    And request body
    When method post
    Then status 200
    * print 'SALIDA login (credenciales correctas): HTTP', responseStatus, 'body:', response
    # La API responde un literal JSON string: "Auth_token: <token>"
    * def token = response.trim()
    And match token == '#regex "Auth_token: .+"'

  Scenario Outline: Caso 4 - Credenciales incorrectas: <descripcion>
    # Las columnas usuario/clave son expresiones evaluadas sobre los datos del Background
    * def body = { username: '#(<usuario>)', password: '#(<clave>)' }
    * print 'ENTRADA login (<descripcion>):', body
    Given path 'login'
    And request body
    When method post
    Then status 200
    * print 'SALIDA login (<descripcion>): HTTP', responseStatus, 'body:', response
    And match response == { errorMessage: '<mensaje>' }

    Examples:
      | descripcion          | usuario         | clave               | mensaje              |
      | password incorrecto  | username        | toBase64("Mala999") | Wrong password.      |
      | usuario no existente | "no_" + username | password            | User does not exist. |
