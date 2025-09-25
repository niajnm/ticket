import 'package:flutter/material.dart';
import 'package:ticket/app/core/base/styles.dart';
import 'package:ticket/app/model/contact.dart';
import 'package:ticket/app/presentation/contacts/widgets/info_card.dart';

class ContactProfilePage extends StatelessWidget {
  final Contact contact;

  const ContactProfilePage({super.key, required this.contact});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: buildAppBar(context, colorScheme),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header section
            Container(
              height: 300,
              decoration: contactHeaderDecoration(colorScheme),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 40),
                    profileImage(contact.imageUrl, colorScheme),
                    const SizedBox(height: 16),
                    Text(contact.name, style: textTheme.headlineMedium),
                  ],
                ),
              ),
            ),

            // Content section
            Transform.translate(
              offset: const Offset(0, -30),
              child: Container(
                decoration: BoxDecoration(
                  color: colorScheme.surface,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 20),

                      InfoCard(
                        icon: Icons.email_outlined,
                        label: 'Email',
                        value: contact.email,
                        color: Colors.blue,
                      ),
                      const SizedBox(height: 16),

                      InfoCard(
                        icon: Icons.phone_outlined,
                        label: 'Phone',
                        value: contact.phone,
                        color: Colors.green,
                      ),
                      const SizedBox(height: 16),

                      InfoCard(
                        icon: Icons.location_on_outlined,
                        label: 'Address',
                        value: contact.address,
                        color: Colors.orange,
                      ),

                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context, ColorScheme colorScheme) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: Container(
        margin: const EdgeInsets.all(8),
        decoration: contactAppBarButtonDecoration(colorScheme),
        child: IconButton(
          icon: Icon(Icons.arrow_back, color: colorScheme.onSurface),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
    );
  }

  Widget profileImage(String imageUrl, ColorScheme colorScheme) {
    return Container(
      decoration: contactImageDecoration(colorScheme),
      child: CircleAvatar(
        radius: 60,
        backgroundImage: NetworkImage(imageUrl),
        backgroundColor: Colors.grey[200],
      ),
    );
  }
}
