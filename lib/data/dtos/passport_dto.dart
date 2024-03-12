class PassportDTO {
  int? passportId;
  int? gender;
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  String? birthday;
  int? bookId;
  DateTime? createdAt;
  int? isDeleted;

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

  factory PassportDTO.fromJson(Map<String, dynamic> json) => PassportDTO(
    passportId: json['passport_id'] as int?,
    gender: json['gender'] as int?,
    firstName: json['first_name'] as String?,
    lastName: json['last_name'] as String?,
    email: json['email'] as String?,
    phone: json['phone'] as String?,
    birthday: json['birthday'] as String?,
    bookId: json['book_id'] as int?,
    createdAt: json['created_at'] == null ? null : DateTime.parse(json['created_at']),
    isDeleted: json['is_deleted'] as int?,
  );

  Map<String, dynamic> toJson() => {
    'passport_id': passportId,
    'gender': gender,
    'first_name': firstName,
    'last_name': lastName,
    'email': email,
    'phone': phone,
    'birthday': birthday,
    'book_id': bookId,
    'created_at': createdAt?.toIso8601String(),
    'is_deleted': isDeleted,
  };
}
