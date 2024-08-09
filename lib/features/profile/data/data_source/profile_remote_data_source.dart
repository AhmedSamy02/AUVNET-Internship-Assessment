import 'package:dio/dio.dart';
import 'package:simple_ecommerce/core/constants/values.dart';

abstract class ProfileRemoteDataSource {
  Future<void>changePassword(String oldPassword, String newPassword);
  Future<void>updateProfile(String firstName, String lastName);
}
class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final Dio dio;

  ProfileRemoteDataSourceImpl({required this.dio});
  final changePasswordEndpoint = '/change-password';
  final updateProfileEndpoint = '/profile';
  @override
  Future<void> changePassword(String oldPassword, String newPassword) async {
    await dio.post(kMainLink + changePasswordEndpoint, data: {
      'old_password': oldPassword,
      'new_password': newPassword
    });
  }

  @override
  Future<void> updateProfile(String firstName, String lastName) async {
    await dio.post(kMainLink + updateProfileEndpoint, data: {
      'first_name': firstName,
      'last_name': lastName
    });
  }
}