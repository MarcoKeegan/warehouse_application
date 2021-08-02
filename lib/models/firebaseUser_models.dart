class FirebaseUser {
  final String uid;
  final String? name;
  final String? email;

  const FirebaseUser({required this.uid, this.name, this.email});

  static const empty = FirebaseUser(email: '', uid: '', name: null);
}
