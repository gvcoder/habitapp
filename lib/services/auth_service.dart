import 'database_service.dart';

class AppUser {
  final String uid;
  final String? email;
  final String? displayName;
  final String? photoURL;

  AppUser({
    required this.uid,
    this.email,
    this.displayName,
    this.photoURL,
  });

  factory AppUser.fromMap(Map<String, dynamic> map) {
    return AppUser(
      uid: map['uid'] as String,
      email: map['email'] as String?,
      displayName: map['displayName'] as String?,
    );
  }
}

class AuthService {
  Future<AppUser?> register(String email, String password, String displayName) async {
    final res = await DatabaseService.instance.registerUser(email, password, displayName);
    if (res != -1) {
      return login(email, password);
    }
    return null;
  }

  Future<AppUser?> login(String email, String password) async {
    final map = await DatabaseService.instance.loginUser(email, password);
    if (map != null) {
      return AppUser.fromMap(map);
    }
    return null;
  }

  Future<void> signOut() async {
    // Session state cleared directly via the Notifier in the UI.
  }
}
