import 'package:flutter/material.dart';
import 'package:ticket/app/core/utils/app_utils.dart';
import 'package:ticket/app/model/ticket.dart';

class TicketCard extends StatelessWidget {
  final Ticket ticket;
  final VoidCallback? onTap;

  const TicketCard({super.key, required this.ticket, this.onTap});

  @override
  Widget build(BuildContext context) {
    final tagText = ticket.tags.isNotEmpty ? ticket.tags.first : '';
    final priorityColor = _priorityColor(ticket.priority);
    final statusColor = _statusColor(ticket.status);
    final tagColor = tagText.isNotEmpty ? _tagColor(tagText) : null;

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
            if (ticket.category.isNotEmpty || ticket.brand.isNotEmpty)
              _HeaderRow(ticket: ticket),

            if (tagText.isNotEmpty) _TagBadge(text: tagText, color: tagColor!),

            Text(
              '#ID ${ticket.id}',
              style: TextStyle(color: Colors.grey[600], fontSize: 12),
            ),
            const SizedBox(height: 6),

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

            Row(
              children: [
                Text(
                  ticket.customerName,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    radius: 3,
                    backgroundColor: Colors.grey[400],
                  ),
                ),
                Text(
                  AppUtils.formatDate(ticket.date),
                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                ),
              ],
            ),

            const SizedBox(height: 10),
            const Divider(height: 1),

            Wrap(
              spacing: 8,
              runSpacing: 6,
              children: [
                _ChipLabel(
                  text: ticket.priority,
                  bg: priorityColor.withOpacity(0.12),
                  fg: priorityColor,
                ),
                _ChipLabel(
                  text: ticket.status,
                  bg: statusColor.withOpacity(0.12),
                  fg: statusColor,
                ),
                if (ticket.department.isNotEmpty)
                  _ChipLabel(
                    text: ticket.department,
                    bg: Colors.grey.shade100,
                    fg: Colors.grey.shade700,
                    border: BorderSide(color: Colors.grey.shade300),
                  ),
                for (var i = 1; i < ticket.tags.length && i < 3; i++)
                  _ChipLabel(
                    text: ticket.tags[i],
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

// -----Widgets -----

class _ChipLabel extends StatelessWidget {
  final String text;
  final Color? bg;
  final Color? fg;
  final BorderSide? border;

  const _ChipLabel({required this.text, this.bg, this.fg, this.border});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      margin: const EdgeInsets.only(top: 6),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(16),
        border: border == null ? null : Border.fromBorderSide(border!),
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
}

class _TagBadge extends StatelessWidget {
  final String text;
  final Color color;

  const _TagBadge({required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _HeaderRow extends StatelessWidget {
  final Ticket ticket;

  const _HeaderRow({required this.ticket});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (ticket.category.isNotEmpty)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
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
    );
  }
}

// ----- Color helpers -----

Color _priorityColor(String priority) {
  switch (priority.toLowerCase()) {
    case 'urgent':
      return Colors.red;
    case 'high':
      return Colors.deepOrange;
    case 'medium':
      return Colors.orange;
    case 'low':
      return Colors.green;
    default:
      return Colors.grey;
  }
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

Color _tagColor(String tag) {
  final lower = tag.toLowerCase();
  if (lower.contains('overdue')) return Colors.orange;
  if (lower.contains('responded') || lower.contains('customer')) {
    return Colors.purple;
  }
  if (lower.contains('new')) return Colors.lightBlue;
  if (lower.contains('critical')) return Colors.red;
  if (lower.contains('security')) return Colors.deepPurple;
  if (lower.contains('performance')) return Colors.indigo;
  if (lower.contains('payment')) return Colors.teal;
  return Colors.blueGrey;
}
