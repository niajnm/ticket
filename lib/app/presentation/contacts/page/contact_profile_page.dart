import 'package:flutter/material.dart';
import 'package:ticket/app/model/contact.dart';

class ProfilePage extends StatelessWidget {
  final Contact contact;

  const ProfilePage({super.key, required this.contact});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
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
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header section with gradient background
            Container(
              height: 300,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    colorScheme.shadow.withOpacity(0.3),
                    colorScheme.secondaryContainer,
                  ],
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 40),
                    // Profile Image with shadow and border
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: colorScheme.shadow.withOpacity(0.3),
                            spreadRadius: 2,
                            blurRadius: 15,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: CircleAvatar(
                        radius: 60,
                        backgroundColor: colorScheme.surface,
                        child: CircleAvatar(
                          radius: 55,
                          backgroundImage: NetworkImage(contact.imageUrl),
                          onBackgroundImageError: (exception, stackTrace) {},
                          child: contact.imageUrl.isEmpty
                              ? Icon(
                                  Icons.person,
                                  size: 60,
                                  color: colorScheme.onSurface.withOpacity(0.5),
                                )
                              : null,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Name with elegant typography
                    Text(
                      contact.name,
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,

                        shadows: [
                          Shadow(
                            offset: const Offset(0, 2),
                            blurRadius: 4,
                            color: colorScheme.shadow.withOpacity(0.5),
                          ),
                        ],
                      ),
                    ),
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
                      _buildInfoCard(
                        context: context,
                        icon: Icons.email_outlined,
                        label: 'Email',
                        value: contact.email,
                        color: Colors.blue,
                      ),
                      const SizedBox(height: 16),

                      _buildInfoCard(
                        context: context,
                        icon: Icons.phone_outlined,
                        label: 'Phone',
                        value: contact.phone,
                        color: Colors.green,
                      ),
                      const SizedBox(height: 16),

                      _buildInfoCard(
                        context: context,
                        icon: Icons.location_on_outlined,
                        label: 'Address',
                        value: contact.address,
                        color: Colors.orange,
                      ),

                      const SizedBox(height: 30),

                      // // Action buttons
                      // Row(
                      //   children: [
                      //     Expanded(
                      //       child: _buildActionButton(
                      //         icon: Icons.call,
                      //         label: 'Call',
                      //         color: Colors.green,
                      //         onTap: () {
                      //           // Handle call action
                      //         },
                      //       ),
                      //     ),
                      //     const SizedBox(width: 16),
                      //     Expanded(
                      //       child: _buildActionButton(
                      //         icon: Icons.message,
                      //         label: 'Message',
                      //         color: Colors.blue,
                      //         onTap: () {
                      //           // Handle message action
                      //         },
                      //       ),
                      //     ),
                      //   ],
                      // ),
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

  Widget _buildInfoCard({
    required BuildContext context,
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colorScheme.outline.withOpacity(0.5)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: colorScheme.onSurface.withOpacity(0.7),
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value.isNotEmpty ? value : 'Not provided',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: colorScheme.onSurface,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 20),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
