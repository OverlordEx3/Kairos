import 'dart:async';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

enum AuthState{not_logged, authorizing, authorized}

class AuthService {
	final AuthState _logState;
	AuthService(this._logState);

	static Future<AuthService> initialize() async {
		final storage = FlutterSecureStorage();
		final password = await storage.read(key: 'pass');
		final username = await storage.read(key: 'user');

		/* TODO perform authentication with server */
		return AuthService(AuthState.authorized);
	}

	/* Getters */
	AuthState get authState => this._logState;
}