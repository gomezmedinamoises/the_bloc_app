class User {
  final int id;
  final String email;
  final String firstName;
  final String lastName;
  final String avatar;

  User(
      {required this.id,
      required this.email,
      required this.firstName,
      required this.lastName,
      required this.avatar});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['id'],
        email: json['email'],
        firstName: json['first_name'] ?? 'First Name',
        lastName: json['last_name'] ?? 'Last Name',
        avatar: json['avatar'] ??
            'https://img.freepik.com/premium-vector/man-realistic-icon-isolated-white-background-vector-illustration_230920-2846.jpg?w=740');
  }
}
