class SignUpDTO {
  final String? email;
  final String? userName;
  final String? password1;
  final String? password2;

  SignUpDTO({
    required this.email,
    required this.userName,
    required this.password1,
    required this.password2,
  });

  factory SignUpDTO.fromJson(Map<String, dynamic> json) {
    return SignUpDTO(
      email: json['email'] as String?,
      userName: json['username'] as String?,
      password1: json['password1'] as String?,
      password2: json['password2'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'username': userName,
      'password1': password1,
      'password2': password2,
    };
  }
}
