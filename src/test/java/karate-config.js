function fn() {
  var config = {
    baseUrl: 'https://api.demoblaze.com'
  };
  // Utilidad: el frontend de demoblaze envía el password codificado en Base64
  config.toBase64 = function (s) {
    var Base64 = Java.type('java.util.Base64');
    var bytes = new java.lang.String(s).getBytes('UTF-8');
    return Base64.getEncoder().encodeToString(bytes);
  };
  karate.configure('connectTimeout', 10000);
  karate.configure('readTimeout', 10000);
  return config;
}
