import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ticket/app/presentation/component/ticket_card.dart';
import 'package:ticket/app/presentation/view_model/ticket_provider.dart';
import 'filter_page.dart';

class TicketsPage extends StatefulWidget {
  const TicketsPage({super.key});

  @override
  State<TicketsPage> createState() => _TicketsPageState();
}

class _TicketsPageState extends State<TicketsPage> {
  @override
  void initState() {
    super.initState();
    // Load tickets once when the page is first opened
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TicketProvider>().loadTickets();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TicketProvider>();

    return Scaffold(
      appBar: _buildCustomAppBar(),
      body: Column(
        children: [
          // 🔹 Row for ticket count & filter (always visible)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${provider.tickets.length} tickets",
                  style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.filter_alt_outlined,
                    color: Colors.black,
                  ),
                  onPressed: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const FilterPage()),
                    );
                    context.read<TicketProvider>().applyFilters();
                  },
                ),
              ],
            ),
          ),

          // 🔹 Ticket list or loader / empty state
          Expanded(
            child: Builder(
              builder: (context) {
                log(
                  'isLoading: ${provider.isLoading}, tickets count: ${provider.tickets.length}',
                );

                if (provider.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (provider.tickets.isEmpty) {
                  return const Center(child: Text("No tickets found"));
                }

                return ListView.builder(
                  itemCount: provider.tickets.length,
                  itemBuilder: (context, index) {
                    return TicketCard(ticket: provider.tickets[index]);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  AppBar _buildCustomAppBar() {
    return AppBar(
      elevation: 0,
      titleSpacing: 10,
      title: const Text(
        "Gain Solutions",
        style: TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
      actions: [
        // 🔔 Notification icon with badge
        Stack(
          clipBehavior: Clip.none,
          children: [
            IconButton(
              icon: const Icon(Icons.notifications_none, color: Colors.black),
              onPressed: () {
                // TODO: Navigate to notifications page
              },
            ),
            Positioned(
              right: 8,
              top: 8,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                child: const Text(
                  "3", // hardcoded for now
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
