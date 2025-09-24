import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ticket/app/presentation/component/app_bar.dart';
import 'package:ticket/app/presentation/tickets/widgets/ticket_card.dart';
import 'package:ticket/app/presentation/tickets/view_model/ticket_viewmodel.dart';
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
      context.read<TicketViewModel>().loadTickets();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Gain Solutions", notificationCount: 3),
      body: Column(
        children: const [
          _HeaderRow(),
          Expanded(child: _TicketList()),
        ],
      ),
    );
  }
}

class _HeaderRow extends StatelessWidget {
  const _HeaderRow();

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TicketViewModel>();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "${provider.tickets.length} tickets",
            style: TextStyle(fontSize: 14, color: Colors.grey[700]),
          ),
          IconButton(
            icon: const Icon(Icons.filter_alt_outlined, color: Colors.black),
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const FilterPage()),
              );
              context.read<TicketViewModel>().applyFilters();
            },
          ),
        ],
      ),
    );
  }
}

class _TicketList extends StatelessWidget {
  const _TicketList();

  @override
  Widget build(BuildContext context) {
    return Consumer<TicketViewModel>(
      builder: (context, provider, child) {
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
    );
  }
}
