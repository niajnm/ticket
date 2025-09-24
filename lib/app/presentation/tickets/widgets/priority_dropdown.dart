import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ticket/app/presentation/tickets/view_model/ticket_viewmodel.dart';

class PriorityDropdown extends StatelessWidget {
  const PriorityDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TicketViewModel>(
      builder: (context, provider, _) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8),
          ),
          child: DropdownButton<String>(
            isExpanded: true,
            value: provider.selectedPriority,
            hint: const Text("Select priority"),
            items: provider.availablePriorities
                .map((p) => DropdownMenuItem(value: p, child: Text(p)))
                .toList(),
            onChanged: provider.setPriority,
            underline: const SizedBox(), // Remove default underline
          ),
        );
      },
    );
  }
}
