class FirebaseUserModels {
  final String uid;
  final String? name;
  final String? email;

  const FirebaseUserModels({required this.uid, this.name, this.email});

  static const empty = FirebaseUserModels(email: '', uid: '', name: null);
}
