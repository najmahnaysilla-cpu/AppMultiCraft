class AccountData {
  String email;
  String password;
  String username;

  AccountData({
    required this.email,
    required this.password,
    required this.username,
  });
}

// Data akun yang sedang terdaftar.
// Untuk sementara disimpan selama aplikasi berjalan.
AccountData accountdata = AccountData(
  email: '',
  password: '',
  username: '',
);