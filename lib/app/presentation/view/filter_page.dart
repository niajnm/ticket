import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ticket/app/presentation/view_model/ticket_provider.dart';

class FilterPage extends StatelessWidget {
  const FilterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("Filters"),
        actions: [
          TextButton(
            onPressed: () {
              context.read<TicketProvider>().clearFilters();
              Navigator.pop(context);
            },
            child: const Text("Clear"),
          ),
          TextButton(
            onPressed: () {
              context.read<TicketProvider>().applyFilters();
              Navigator.pop(context);
            },
            child: const Text("Apply"),
          ),
        ],
      ),
      body: Consumer<TicketProvider>(
        builder: (context, provider, _) {
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              const Text("Brand"),
              CheckboxListTile(
                value: provider.selectedBrand == "Gains",
                onChanged: (_) {
                  provider.selectedBrand = provider.selectedBrand == "Gains"
                      ? null
                      : "Gains";
                  provider.notifyListeners();
                },
                title: const Text("Gains"),
              ),
              CheckboxListTile(
                value: provider.selectedBrand == "GainSolution",
                onChanged: (_) {
                  provider.selectedBrand =
                      provider.selectedBrand == "GainSolution"
                      ? null
                      : "GainSolution";
                  provider.notifyListeners();
                },
                title: const Text("GainSolution"),
              ),
              CheckboxListTile(
                value: provider.selectedBrand == "GainHQ",
                onChanged: (_) {
                  provider.selectedBrand = provider.selectedBrand == "GainHQ"
                      ? null
                      : "GainHQ";
                  provider.notifyListeners();
                },
                title: const Text("GainHQ"),
              ),
              const SizedBox(height: 16),

              const Text("Priority"),
              DropdownButton<String>(
                isExpanded: true,
                value: provider.selectedPriority,
                hint: const Text("Select priority"),
                items: ["Low", "Medium", "Urgent"]
                    .map((p) => DropdownMenuItem(value: p, child: Text(p)))
                    .toList(),
                onChanged: (value) {
                  provider.selectedPriority = value;
                  provider.notifyListeners();
                },
              ),
              const SizedBox(height: 16),

              const Text("Tags"),
              Wrap(
                spacing: 8,
                children: [
                  for (var tag in [
                    "Tag one",
                    "Tag two",
                    "Tag three wit long text",
                    "Tag four",
                    "Tag five",
                    "Tag six with long text",
                    "Tag seven",
                  ])
                    FilterChip(
                      label: Text(tag),
                      selected: provider.selectedTags.contains(tag),
                      onSelected: (val) {
                        if (val) {
                          provider.selectedTags.add(tag);
                        } else {
                          provider.selectedTags.remove(tag);
                        }
                        provider.notifyListeners();
                      },
                    ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
