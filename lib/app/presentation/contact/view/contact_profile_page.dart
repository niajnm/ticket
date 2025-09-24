import 'package:flutter/material.dart';
import 'package:ticket/app/model/contact.dart';

class ProfilePage extends StatelessWidget {
  final Contact contact;

  ProfilePage({required this.contact});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile - ${contact.name}')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(contact.imageUrl),
            ),
            SizedBox(height: 20),
            Text(
              'Name: ${contact.name}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text('Email: ${contact.email}'),
            SizedBox(height: 10),
            Text('Phone: ${contact.phone}'),
            SizedBox(height: 10),
            Text('Address: ${contact.address}'),
          ],
        ),
      ),
    );
  }
}
