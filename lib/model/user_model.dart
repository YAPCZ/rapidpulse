class User {
  final String username;
  final String email;
  final String phone;

  User({
    required this.username,
    required this.email,
    required this.phone,
  });

  factory User.guest() => User(
        username: 'Guest',
        email: '',
        phone: '',
      );

  bool get isGuest => email.isEmpty;

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'email': email,
      'phone': phone,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      username: map['username'],
      email: map['email'],
      phone: map['phone'],
    );
  }
}