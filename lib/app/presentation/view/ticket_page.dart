import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ticket/app/presentation/component/ticket_card.dart';
import 'package:ticket/app/presentation/view_model/quiz_provider.dart';
import 'filter_page.dart';

class TicketsPage extends StatelessWidget {
  const TicketsPage({super.key});

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
              context.read<TicketProvider>().applyFilters();
            },
          ),
        ],
      ),
      body: Consumer<TicketProvider>(
        builder: (context, provider, _) {
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
