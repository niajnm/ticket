import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ticket/app/presentation/tickets/view_model/ticket_viewmodel.dart';

class TagsSelection extends StatelessWidget {
  const TagsSelection({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TicketViewModel>(
      builder: (context, provider, _) {
        return Wrap(
          spacing: 8,
          children: provider.availableTags
              .map(
                (tag) => FilterChip(
                  label: Text(tag),
                  selected: provider.selectedTags.contains(tag),
                  onSelected: (_) => provider.toggleTag(tag),
                ),
              )
              .toList(),
        );
      },
    );
  }
}
