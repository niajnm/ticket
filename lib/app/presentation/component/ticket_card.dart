import 'package:flutter/material.dart';
import 'package:ticket/app/model/ticket.dart';

class TicketCard extends StatelessWidget {
  final Ticket ticket;
  final VoidCallback? onTap;

  const TicketCard({Key? key, required this.ticket, this.onTap})
    : super(key: key);

  Color _priorityColor(String priority) {
    switch (priority.toLowerCase()) {
      case 'urgent':
        return Colors.red;
      case 'high':
        return Colors.deepOrange;
      case 'low':
        return Colors.green;
      case 'medium':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  Color _tagColor(String tag) {
    final lower = tag.toLowerCase();
    if (lower.contains('overdue')) return Colors.orange;
    if (lower.contains('responded') || lower.contains('customer'))
      return Colors.purple;
    if (lower.contains('new')) return Colors.lightBlue;
    if (lower.contains('critical')) return Colors.red;
    if (lower.contains('security')) return Colors.deepPurple;
    if (lower.contains('performance')) return Colors.indigo;
    if (lower.contains('payment')) return Colors.teal;
    return Colors.blueGrey;
  }

  String _formatDate(dynamic dateInput) {
    DateTime dt;

    if (dateInput is DateTime) {
      dt = dateInput;
    } else if (dateInput is String) {
      try {
        // Handle format like "2023-12-23 15:43"
        if (dateInput.contains(' ') && !dateInput.contains('T')) {
          dt = DateTime.parse(dateInput.replaceAll(' ', 'T'));
        } else {
          dt = DateTime.parse(dateInput);
        }
      } catch (e) {
        // Fallback to current time if parsing fails
        dt = DateTime.now();
      }
    } else {
      dt = DateTime.now();
    }

    final month = _monthName(dt.month);
    final hour12 = dt.hour == 0 ? 12 : (dt.hour > 12 ? dt.hour - 12 : dt.hour);
    final minute = dt.minute.toString().padLeft(2, '0');
    final ampm = dt.hour >= 12 ? 'pm' : 'am';
    return '${dt.day} $month ${dt.year} ${hour12.toString().padLeft(2, '0')}:$minute $ampm';
  }

  String _monthName(int m) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return months[m - 1];
  }

  Widget _chip(String text, {Color? bg, Color? fg, BorderSide? border}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      margin: const EdgeInsets.only(top: 6),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(16),
        border: border == null ? null : Border.fromBorderSide(border),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: fg ?? Colors.black87,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Color _statusColor(String status) {
    switch (status.toLowerCase()) {
      case 'open':
        return Colors.blue;
      case 'closed':
        return Colors.green;
      case 'pending':
        return Colors.orange;
      case 'in progress':
        return Colors.purple;
      case 'spam':
        return Colors.red;
      case 'reopened':
        return Colors.amber;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final tagText = ticket.tags.isNotEmpty ? ticket.tags.first : '';
    final priorityColor = _priorityColor(ticket.priority);
    final tagColor = tagText.isNotEmpty ? _tagColor(tagText) : null;
    final statusColor = _statusColor(ticket.status);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header row with category and brand (only if they exist)
            if (ticket.category.isNotEmpty || ticket.brand.isNotEmpty)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (ticket.category.isNotEmpty)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        ticket.category,
                        style: const TextStyle(
                          color: Colors.blue,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  if (ticket.brand.isNotEmpty)
                    Text(
                      ticket.brand,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                ],
              ),

            if (ticket.category.isNotEmpty || ticket.brand.isNotEmpty)
              const SizedBox(height: 8),

            // Tag badge
            if (tagText.isNotEmpty)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: tagColor!.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  tagText,
                  style: TextStyle(
                    color: tagColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

            if (tagText.isNotEmpty) const SizedBox(height: 8),

            // ID
            Text(
              '#ID ${ticket.id}',
              style: TextStyle(color: Colors.grey[600], fontSize: 12),
            ),
            const SizedBox(height: 6),

            // Subject
            Text(
              ticket.subject,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                height: 1.25,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),

            const SizedBox(height: 10),

            // Customer and date
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  ticket.customerName,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                Text(
                  _formatDate(ticket.date),
                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                ),
              ],
            ),

            const SizedBox(height: 10),
            const Divider(height: 1),

            // Chips: priority, status, department, and additional tags
            Wrap(
              spacing: 8,
              runSpacing: 6,
              children: [
                // priority chip
                _chip(
                  ticket.priority,
                  bg: priorityColor.withOpacity(0.12),
                  fg: priorityColor,
                ),

                // status chip
                _chip(
                  ticket.status,
                  bg: statusColor.withOpacity(0.12),
                  fg: statusColor,
                ),

                // department chip (only if exists)
                if (ticket.department.isNotEmpty)
                  _chip(
                    ticket.department,
                    bg: Colors.grey.shade100,
                    fg: Colors.grey.shade700,
                    border: BorderSide(color: Colors.grey.shade300),
                  ),

                // extra quick tag chips (limit to first 2 additional tags)
                for (var i = 0; i < ticket.tags.length && i < 3; i++)
                  if (i != 0) // first tag shows as top badge already, so skip 0
                    _chip(
                      ticket.tags[i],
                      bg: Colors.grey.shade50,
                      border: BorderSide(color: Colors.grey.shade200),
                    ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
