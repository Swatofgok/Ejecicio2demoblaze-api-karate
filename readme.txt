PRUEBAS API DEMOBLAZE (SIGNUP / LOGIN) CON KARATE
=================================================

Servicios bajo prueba
---------------------
  - Signup: POST https://api.demoblaze.com/signup
  - Login : POST https://api.demoblaze.com/login

Casos automatizados
-------------------
  signup.feature
    Caso 1 - Crear un nuevo usuario
    Caso 2 - Intentar crear un usuario ya existente
  login.feature
    Caso 3 - Usuario y password correctos
    Caso 4 - Usuario y password incorrectos
             (a) password incorrecto   (b) usuario no existente

Prerrequisitos
--------------
  1. Java JDK 17 o superior   (verificar: java -version)
  2. Apache Maven 3.8+        (verificar: mvn -v)
  3. Git                      (verificar: git --version)
  4. Conexion a Internet (las pruebas consumen la API publica real)

Paso a paso de ejecucion
------------------------
  1. Clonar el repositorio:
       git clone https://github.com/Swatofgok/Ejecicio2demoblaze-api-karate.git
       cd Ejecicio2demoblaze-api-karate

  2. Ejecutar todas las pruebas (cualquiera de las opciones):
       mvn clean test
       run-tests.bat        (Windows)
       ./run-tests.sh       (Linux / macOS)

  3. Ejecutar un solo feature (opcional):
       mvn clean test -Dkarate.options="classpath:demoblaze/signup.feature"
       mvn clean test -Dkarate.options="classpath:demoblaze/login.feature"

  4. Ver resultados:
       - Consola: resumen de escenarios pasados/fallidos.
       - Reporte HTML: target/karate-reports/karate-summary.html
         (abrir en el navegador; cada paso muestra request y response).
       - Log completo de request/response: target/karate.log

Datos de prueba
---------------
  - Cada ejecucion genera usuarios unicos (qa_user_<timestamp>,
    qa_login_<timestamp>), por lo que las pruebas son repetibles y no
    dependen de datos existentes.
  - El password se envia codificado en Base64 (igual que el frontend de
    demoblaze.com). Valor en claro usado: Test1234.

Estructura del proyecto
-----------------------
  pom.xml                                  Dependencias (Karate 1.5.1 + JUnit5)
  src/test/java/karate-config.js           baseUrl y utilidad toBase64
  src/test/java/logback-test.xml           Logging de request/response
  src/test/java/demoblaze/DemoblazeTest.java  Runner JUnit5
  src/test/java/demoblaze/signup.feature   Casos 1 y 2
  src/test/java/demoblaze/login.feature    Casos 3 y 4
  reportes/                                Evidencia de una ejecucion real
                                           (reporte HTML + karate.log)
  run-tests.bat / run-tests.sh             Scripts de ejecucion
  conclusiones.txt                         Hallazgos y conclusiones
