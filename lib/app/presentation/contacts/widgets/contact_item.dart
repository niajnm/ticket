import 'package:flutter/material.dart';
import 'package:ticket/app/model/contact.dart';

class ContactItem extends StatelessWidget {
  final Contact contact;
  final VoidCallback onTap;
  final VoidCallback? onMoreTap;

  const ContactItem({
    super.key,
    required this.contact,
    required this.onTap,
    this.onMoreTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundImage: NetworkImage(contact.imageUrl),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      contact.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.more_vert),
                    onPressed: onMoreTap,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              // Email row
              _infoRow(Icons.email, contact.email),
              const SizedBox(height: 4),
              //Phone row
              _infoRow(Icons.phone, contact.phone),
              const SizedBox(height: 4),
              //  Address row
              _infoRow(Icons.location_on, contact.address, expand: true),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoRow(IconData icon, String text, {bool expand = false}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 16, color: Colors.grey),
        const SizedBox(width: 6),
        expand ? Expanded(child: Text(text)) : Text(text),
      ],
    );
  }
}
