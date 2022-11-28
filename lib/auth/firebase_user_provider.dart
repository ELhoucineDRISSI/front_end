import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class CashAppFirebaseUser {
  CashAppFirebaseUser(this.user);
  User? user;
  bool get loggedIn => user != null;
}

CashAppFirebaseUser? currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<CashAppFirebaseUser> cashAppFirebaseUserStream() => FirebaseAuth.instance
        .authStateChanges()
        .debounce((user) => user == null && !loggedIn
            ? TimerStream(true, const Duration(seconds: 1))
            : Stream.value(user))
        .map<CashAppFirebaseUser>(
      (user) {
        currentUser = CashAppFirebaseUser(user);
        return currentUser!;
      },
    );
