class Addpasswordmodel {
  String email;
  String webLink;
  String category;
  String password;

  Addpasswordmodel({
    required this.email,
    required this.webLink,
    required this.category,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'webLink': webLink,
      'category': category,
      'password': password,
    };
  }

  factory Addpasswordmodel.fromMap(Map<String, dynamic> map) {
    return Addpasswordmodel(
      email: map['email'],
      webLink: map['webLink'],
      category: map['category'],
      password: map['password'],
    );
  }
}
