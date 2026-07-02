import 'package:isar_community/isar.dart';
import 'package:latihan1/features/auth/domain/entities/auth_entity.dart';

part 'auth_entity_isar.g.dart';

@collection
class AuthEntityIsar extends AuthEntity {
  final Id idIsar;
  AuthEntityIsar({
    this.idIsar = Isar.autoIncrement,
    required super.code,
    required super.login,
    required super.accessToken,
    required super.expiredAt,
  });
}
