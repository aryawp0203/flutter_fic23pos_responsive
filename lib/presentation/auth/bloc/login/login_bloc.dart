// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:flutter_fic23pos_responsive/data/datasource/auth_remote_datasource.dart';
import 'package:flutter_fic23pos_responsive/data/models/response/auth_response_model.dart';

part 'login_bloc.freezed.dart';
part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRemoteDataSource authRemoteDataSource;
  LoginBloc(this.authRemoteDataSource) : super(Initial()) {
    on<_Login>((event, emit) async {
      try {
        emit(const Loading());
        final response = await authRemoteDataSource.login(
          event.email,
          event.password,
        );

        response.fold(
          (failure) => emit(Failure(failure)),
          (data) => emit(Success(data)),
        );
      } catch (e, st) {
        // Ensure any exception doesn't leave the bloc stuck in Loading
        emit(Failure('Login error: $e'));
      }
    });
  }
}
