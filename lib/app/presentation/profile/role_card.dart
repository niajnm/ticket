import 'package:flutter/material.dart';

class RoleCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String avatarUrl;
  final String name;
  final bool isPartial;

  const RoleCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.avatarUrl,
    required this.name,
    this.isPartial = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Text(
                'Group',
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              ),
              Text(
                subtitle,
                style: const TextStyle(fontSize: 14, color: Colors.black87),
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  CircleAvatar(
                    radius: 12,
                    backgroundImage: NetworkImage(avatarUrl),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      name,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black87,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        if (!isPartial) ...[
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'Agent',
                style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Text(
                'Group',
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              ),
              Text(
                'Laravel support',
                style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
              Text(
                'Manager',
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              ),
            ],
          ),
        ],
      ],
    );
  }
}
