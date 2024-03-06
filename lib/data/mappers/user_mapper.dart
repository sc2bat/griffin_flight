import 'package:griffin/data/dtos/user_dto.dart';
import 'package:griffin/domain/model/user/user_account_model.dart';

class UserMapper {
  static UserAccountModel mapDTOToModel(UserDTO dto) {
    return UserAccountModel(
      userId: dto.userId ?? 0,
      userName: dto.userName ?? 'guest',
      email: dto.email ?? 'guest@guest.com',
      createdAt: dto.createdAt ?? DateTime.now(),
      isDeleted: dto.isDeleted ?? 0,
    );
  }

  static UserDTO mapModelToDTO(UserAccountModel model) {
    return UserDTO(
      userId: model.userId,
      userName: model.userName,
      email: model.email,
      createdAt: model.createdAt,
      isDeleted: model.isDeleted,
    );
  }
}
