import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationService {
  final _auth = FirebaseAuth.instance;
//...
}

// Future<AuthStatus> createAccount({
//     required String email,
//     required String password,
//     required String name,
//   }) async {
//     try {
//       UserCredential newUser = await _auth.createUserWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//       _auth.currentUser!.updateDisplayName(name);
//       _status = AuthStatus.successful;
//     } on FirebaseAuthException catch (e) {
//       _status = AuthExceptionHandler.handleAuthException(e);
//     }
//     return _status;
//   }



//  Future<AuthStatus> resetPassword({required String email}) async {
//     await _auth
//         .sendPasswordResetEmail(email: email)
//         .then((value) => _status = AuthStatus.successful)
//         .catchError((e) => _status = AuthExceptionHandler.handleAuthException(e));
//     return _status;
//   }