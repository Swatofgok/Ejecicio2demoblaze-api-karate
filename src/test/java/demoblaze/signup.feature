Feature: Servicio de registro (signup) de Demoblaze
  POST https://api.demoblaze.com/signup
  Entrada: JSON { username, password (Base64) }

  Background:
    * url baseUrl
    * path 'signup'
    * def username = 'qa_user_' + java.lang.System.currentTimeMillis()
    * def password = toBase64('Test1234')

  Scenario: Caso 1 - Crear un nuevo usuario
    * def body = { username: '#(username)', password: '#(password)' }
    * print 'ENTRADA signup (usuario nuevo):', body
    Given request body
    When method post
    Then status 200
    * print 'SALIDA signup (usuario nuevo): HTTP', responseStatus, 'body:', response
    # La API responde el literal JSON "" (string vacío) cuando el registro es exitoso.
    # Karate solo parsea objetos/arreglos JSON, por eso se compara el texto crudo.
    And match response.trim() == '""'

  Scenario: Caso 2 - Intentar crear un usuario ya existente
    * def body = { username: '#(username)', password: '#(password)' }
    # Precondición: se registra el usuario por primera vez
    Given request body
    When method post
    Then status 200
    And match response.trim() == '""'
    # Segundo intento con el mismo usuario
    * print 'ENTRADA signup (usuario existente):', body
    Given path 'signup'
    And request body
    When method post
    Then status 200
    * print 'SALIDA signup (usuario existente): HTTP', responseStatus, 'body:', response
    And match response == { errorMessage: 'This user already exist.' }
