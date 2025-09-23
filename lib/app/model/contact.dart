class Contact {
  final String name;
  final String email;
  final String phone;
  final String address;
  final String imageUrl;

  Contact({
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    required this.imageUrl,
  });

  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      address: json['address'],
      imageUrl: json['imageUrl'],
    );
  }
}
