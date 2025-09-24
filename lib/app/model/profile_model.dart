class Profile {
  final String firstName;
  final String lastName;
  final String email;
  final String fullName;
  final String designation;
  final String avatar;
  final List<Role> roles;

  Profile({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.fullName,
    required this.designation,
    required this.avatar,
    required this.roles,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      fullName: json['fullName'],
      designation: json['designation'],
      avatar: json['avatar'],
      roles: (json['roles'] as List).map((e) => Role.fromJson(e)).toList(),
    );
  }
}

class Role {
  final String title;
  final String subtitle;
  final String avatarUrl;
  final String name;
  final bool isPartial;

  Role({
    required this.title,
    required this.subtitle,
    required this.avatarUrl,
    required this.name,
    required this.isPartial,
  });

  factory Role.fromJson(Map<String, dynamic> json) {
    return Role(
      title: json['title'],
      subtitle: json['subtitle'],
      avatarUrl: json['avatarUrl'],
      name: json['name'],
      isPartial: json['isPartial'],
    );
  }
}
