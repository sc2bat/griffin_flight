class PassportDTO {
  final int? passportId;
  final int? gender;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? phone;
  final String? birthday;
  final int? bookId;
  final DateTime? createdAt;
  final bool? isDeleted;

   PassportDTO({
    this.passportId,
    this.gender,
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.birthday,
    this.bookId,
    this.createdAt,
    this.isDeleted,
  });

  Map<String, dynamic> toJson() {
    return {
      'passportId': passportId,
      'gender': gender,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phone': phone,
      'birthday': birthday,
      'bookId': bookId,
      'createdAt': createdAt,
      'isDeleted': isDeleted,
    };
  }

  factory PassportDTO.fromJson(Map<String, dynamic> json) {
    return PassportDTO(
      passportId: json['passportId'],
      gender: json['gender'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      phone: json['phone'],
      birthday: json['birthday'],
      bookId: json['bookId'],
      createdAt: json['createdAt'],
      isDeleted: json['isDeleted'],
    );
  }
}
