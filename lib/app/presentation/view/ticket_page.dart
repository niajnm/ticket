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
    return Scaffold(
      appBar: AppBar(
        title: const Text("Gain Solutions"),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_alt_outlined),
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const FilterPage()),
              );
              // Apply filters after returning from filter page
              context.read<TicketProvider>().applyFilters();
            },
          ),
        ],
      ),
      body: Consumer<TicketProvider>(
        builder: (context, provider, _) {
          log(
            ' isLoading: ${provider.isLoading}, tickets count: ${provider.tickets.length}',
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
    );
  }
}
