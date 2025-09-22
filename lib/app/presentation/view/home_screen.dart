import 'package:flutter/material.dart';

class Ticket {
  final String id;
  final String subject;
  final String status;
  final String priority;
  final String customerName;
  final DateTime date;
  final String tag;

  Ticket({
    required this.id,
    required this.subject,
    required this.status,
    required this.priority,
    required this.customerName,
    required this.date,
    required this.tag,
  });
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tickets = [
      Ticket(
        id: "132198423",
        subject:
            "Search view, which can display dynamic suggestions, is the focused state of...",
        status: "Open",
        priority: "Low",
        customerName: "Michale",
        date: DateTime(2023, 12, 23, 15, 43),
        tag: "New",
      ),
      Ticket(
        id: "132198423",
        subject: "Ticket subject small",
        status: "Spam",
        priority: "Urgent",
        customerName: "Noah",
        date: DateTime(2023, 12, 23, 15, 43),
        tag: "First response overdue",
      ),
      Ticket(
        id: "132198423",
        subject:
            "Search view, which can display dynamic suggestions, is the focused state of...",
        status: "Open",
        priority: "Medium",
        customerName: "Jonus",
        date: DateTime(2023, 12, 23, 15, 43),
        tag: "Customer responded",
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Gain Solutions"),
        actions: [
          Stack(
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.notifications_none),
              ),
              Positioned(
                right: 8,
                top: 8,
                child: Container(
                  padding: const EdgeInsets.all(3),
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: const Text(
                    "3",
                    style: TextStyle(color: Colors.white, fontSize: 10),
                  ),
                ),
              ),
            ],
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.filter_alt_outlined),
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: tickets.length,
        itemBuilder: (context, index) {
          return TicketCard(ticket: tickets[index]);
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        onTap: (index) {},
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.confirmation_number_outlined),
            label: "Tickets",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.contacts_outlined),
            label: "Contacts",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}

class TicketCard extends StatelessWidget {
  final Ticket ticket;

  const TicketCard({super.key, required this.ticket});

  Color _getPriorityColor(String priority) {
    switch (priority.toLowerCase()) {
      case "urgent":
        return Colors.red;
      case "low":
        return Colors.green;
      case "medium":
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  Color _getTagColor(String tag) {
    if (tag.contains("overdue")) return Colors.orange;
    if (tag.contains("responded")) return Colors.purple;
    return Colors.blue;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (ticket.tag.isNotEmpty)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: _getTagColor(ticket.tag).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  ticket.tag,
                  style: TextStyle(
                    color: _getTagColor(ticket.tag),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            const SizedBox(height: 6),
            Text(
              "#ID ${ticket.id}",
              style: const TextStyle(color: Colors.grey, fontSize: 12),
            ),
            const SizedBox(height: 4),
            Text(
              ticket.subject,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 6),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  ticket.customerName,
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
                Text(
                  "${ticket.date.day} ${_monthName(ticket.date.month)} ${ticket.date.year} ${ticket.date.hour}:${ticket.date.minute.toString().padLeft(2, '0')} pm",
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
            const Divider(),
            Wrap(
              spacing: 8,
              children: [
                Chip(
                  label: Text(ticket.priority),
                  labelStyle: const TextStyle(fontSize: 12),
                  backgroundColor: _getPriorityColor(
                    ticket.priority,
                  ).withOpacity(0.1),
                  side: BorderSide.none,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                Chip(
                  label: Text(ticket.status),
                  labelStyle: const TextStyle(fontSize: 12),
                  backgroundColor: Colors.grey.shade200,
                  side: BorderSide.none,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _monthName(int month) {
    const months = [
      "Jan",
      "Feb",
      "Mar",
      "Apr",
      "May",
      "Jun",
      "Jul",
      "Aug",
      "Sep",
      "Oct",
      "Nov",
      "Dec",
    ];
    return months[month - 1];
  }
}
