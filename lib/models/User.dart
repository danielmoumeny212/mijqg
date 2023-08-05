class User {
  int id;
  String name;
  String firstName;
  String email;
  bool isStaff;
  Map<String, dynamic>? profil;
  Map<String, dynamic>? church;

  User(
      {required this.id,
      required this.name,
      required this.firstName,
      required this.email,
      required this.isStaff,
      required this.profil,
      required this.church});

  String get churchName => church?['name'] ?? "";
  String get statut => profil?['statut'];
  String get image => profil?['image'];

  factory User.empty() {
    return User(
        id: 0,
        name: '',
        firstName: '',
        email: '',
        isStaff: false,
        profil: {},
        church: {});
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['id'] as int,
        name: json['last_name'] as String,
        firstName: json['first_name'] as String,
        email: json['email'] as String,
        isStaff: json['is_staff'] as bool,
        profil: json['profil'] as Map<String, dynamic>,
        church: json["church"] as Map<String, dynamic>);
  }
}
