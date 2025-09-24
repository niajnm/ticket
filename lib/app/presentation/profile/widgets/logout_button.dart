import 'package:flutter/material.dart';

class LogoutButton extends StatelessWidget {
  final VoidCallback? onTap;

  const LogoutButton({this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      width: double.infinity,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 15),
          decoration: BoxDecoration(
            color: const Color.fromARGB(110, 255, 235, 238),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color(0xFFFFCDD2), width: 1),
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.logout, color: Color(0xFFE91E63), size: 18),
              SizedBox(width: 8),
              Text(
                'Log out',
                style: TextStyle(
                  color: Color(0xFFE91E63),
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
