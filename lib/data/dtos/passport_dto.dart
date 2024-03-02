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

  const PassportDTO({
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

  factory PassportDTO.fromJson(Map<String, dynamic> map) {
    return PassportDTO(
      passportId: map['passportId'] as int,
      gender: map['gender'] as int,
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
      email: map['email'] as String,
      phone: map['phone'] as String,
      birthday: map['birthday'] as String,
      bookId: map['bookId'] as int,
      createdAt: map['createdAt'] as DateTime,
      isDeleted: map['isDeleted'] as bool,
    );
  }
}
