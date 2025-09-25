import 'package:flutter/material.dart';
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
              decoration: boxDecoration(colorScheme),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 40),

                    // Profile Image
                    profileImage(contact.imageUrl, colorScheme),

                    const SizedBox(height: 16),
                    // Name
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

                      // Contact Information Cards
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
        decoration: BoxDecoration(
          color: colorScheme.surface.withOpacity(0.9),
          borderRadius: BorderRadius.circular(12),
        ),
        child: IconButton(
          icon: Icon(Icons.arrow_back, color: colorScheme.onSurface),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
    );
  }

  Widget profileImage(String imageUrl, ColorScheme colorScheme) {
    return Container(
      decoration: imageBoxDecoration(colorScheme),
      child: CircleAvatar(
        radius: 60,
        backgroundImage: NetworkImage(imageUrl),
        backgroundColor: Colors.grey[200],
      ),
    );
  }

  BoxDecoration boxDecoration(ColorScheme colorScheme) {
    return BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          colorScheme.shadow.withOpacity(0.3),
          colorScheme.secondaryContainer,
        ],
      ),
    );
  }

  BoxDecoration imageBoxDecoration(ColorScheme colorScheme) => BoxDecoration(
    shape: BoxShape.circle,
    boxShadow: [
      BoxShadow(
        color: colorScheme.shadow.withOpacity(0.3),
        spreadRadius: 2,
        blurRadius: 15,
        offset: const Offset(0, 8),
      ),
    ],
  );
}
