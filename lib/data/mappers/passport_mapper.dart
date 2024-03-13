import 'package:griffin/data/dtos/passport_dto.dart';

import '../../domain/model/passport/passport_model.dart';

class PassportMapper {
  static PassportModel fromDTO(PassportDTO dto) {
    return PassportModel (
      passportId: dto.passportId ?? 0,
      gender: dto.gender ?? 0,
      firstName: dto.firstName ?? '',
      lastName: dto.lastName ?? '',
      email: dto.email ?? '',
      phone: dto.phone ?? '',
      birthday: dto.birthday ?? '',
      bookId: dto.bookId ?? 0,
      createdAt: dto.createdAt,
      isDeleted: dto.isDeleted,
    );
  }

  static PassportDTO passportModelToDTO(PassportModel model) {
    return PassportDTO (
      passportId: model.passportId,
      gender: model.gender,
      firstName: model.firstName,
      lastName: model.lastName,
      email: model.email,
      phone: model.phone,
      birthday: model.birthday,
      bookId: model.bookId,
      createdAt: model.createdAt,
      isDeleted: model.isDeleted,
    );
  }
}