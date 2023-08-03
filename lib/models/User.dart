
class User {
   int id;
   String name;
   String firstName;
   String email;
   bool isStaff;

  User({
    required this.id,
    required this.name,
    required this.firstName,
    required this.email,
    required this.isStaff,
  });

   factory User.empty() {
    return User(
      id: 0,
      name: '',
      firstName: '',
      email: '',
      isStaff: false,
    );
  }


  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      name: json['last_name'] as String,
      firstName: json['first_name'] as String,
      email: json['email'] as String,
      isStaff: json['is_staff'] as bool,
    );
  }

 
}