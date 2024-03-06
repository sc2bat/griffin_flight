import 'package:griffin/data/dtos/passport_dto.dart';

import '../../domain/model/passport/passport_model.dart';

class PassportMapper {
  static PassportModel fromDTO(PassportDTO dto) {
    return PassportModel (
      passportId: dto.passportId,
      gender: dto.gender,
      firstName: dto.firstName,
      lastName: dto.lastName,
      email: dto.email,
      phone: dto.phone,
      birthday: dto.birthday,
      bookId: dto.bookId,
      createdAt: dto.createdAt,
      isDeleted: dto.isDeleted,
    );
  }

  static PassportModel toDTO(PassportDTO dto) {
    return PassportModel (
      passportId: dto.passportId,
      gender: dto.gender,
      firstName: dto.firstName,
      lastName: dto.lastName,
      email: dto.email,
      phone: dto.phone,
      birthday: dto.birthday,
      bookId: dto.bookId,
      createdAt: dto.createdAt,
      isDeleted: dto.isDeleted,
    );
  }
}