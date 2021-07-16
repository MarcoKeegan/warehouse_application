class FirebaseUserModels {
  final String uid;
  final String? name;
  final String? email;
  final int? role;

  const FirebaseUserModels({required this.uid, this.name, this.email, this.role});

  static const empty = FirebaseUserModels(email: '', uid: '', name: null, role: null);
}
