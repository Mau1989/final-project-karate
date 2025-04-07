function generateRandomEmail(index) {
  return 'Mau' + index + '@example.com';
}

function generateRandomPassword() {
  var chars = '0123456789';
  var password = '';
  for (var i = 0; i < 8; i++) { // generates a 8-character long password
    password += chars.charAt(Math.floor(Math.random() * chars.length));
  }
  return password;
}

function createLoginData() {
  var logins = [];
  for (var i = 1; i <= 5; i++) { // Generate 5 logins
    logins.push({
      'email': generateRandomEmail(i),
      'password': generateRandomPassword(),
      'nombre' : "Mauricio" ,
      'tipo_usuario_id' : i ,
      'estado' : i
    });
  }
  return logins;
}

// You may also want to return something at the end if needed
return {
  generateRandomEmail: generateRandomEmail,
  generateRandomPassword: generateRandomPassword,
  createLoginData: createLoginData
};
