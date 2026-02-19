import 'package:dartz/dartz.dart';
import 'package:flutter_fic23pos_responsive/core/constants/variables.dart';
import 'package:flutter_fic23pos_responsive/data/models/response/auth_response_model.dart';
import 'package:http/http.dart' as http;

class AuthRemoteDataSource {
  Future<Either<String, AuthResponseModel>> login(
    String email,
    String password,
  ) async {
    final response = await http.post(
      Uri.parse('${Variables.baseUrl}/api/login'),
      body: {'email': email, 'password': password},
    );

    if (response.statusCode == 200) {
      final authResponse = AuthResponseModel.fromJson(response.body);
      return Right(authResponse);
    } else {
      return Left('Login failed: ${response.reasonPhrase}');
    }
  }
}
