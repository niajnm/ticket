import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final int notificationCount;

  const CustomAppBar({
    super.key,
    required this.title,
    this.notificationCount = 0,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      actions: [
        if (notificationCount > 0)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Badge(
              label: Text(notificationCount.toString()),
              child: const Icon(Icons.notifications),
            ),
          ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
