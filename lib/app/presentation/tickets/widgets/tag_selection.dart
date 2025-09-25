import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ticket/app/presentation/tickets/view_model/ticket_viewmodel.dart';

class TagsSelection extends StatelessWidget {
  const TagsSelection({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TicketViewModel>(
      builder: (context, provider, _) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search field
            TextField(
              decoration: InputDecoration(
                hintText: "Search tags",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.grey[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 0,
                  horizontal: 16,
                ),
              ),
              onChanged: provider.updateTagSearch,
            ),
            const SizedBox(height: 12),

            // Tag chips
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: provider.filteredTags
                  .map(
                    (tag) => FilterChip(
                      label: Text(tag),
                      selected: provider.selectedTags.contains(tag),
                      onSelected: (_) => provider.toggleTag(tag),
                    ),
                  )
                  .toList(),
            ),
          ],
        );
      },
    );
  }
}
