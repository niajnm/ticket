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
              /// ---------------- Brand ----------------
              const Text("Brand"),
              for (var brand in provider.availableBrands)
                InkWell(
                  onTap: () {
                    provider.selectedBrand = provider.selectedBrand == brand
                        ? null
                        : brand;
                    provider.notifyListeners();
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      children: [
                        // Checkbox on the left
                        Checkbox(
                          value: provider.selectedBrand == brand,
                          onChanged: (_) {
                            provider.selectedBrand =
                                provider.selectedBrand == brand ? null : brand;
                            provider.notifyListeners();
                          },
                        ),
                        const SizedBox(width: 8),

                        // Icon in the middle
                        const Icon(
                          Icons.local_offer,
                          size: 20,
                          color: Colors.blue,
                        ),
                        const SizedBox(width: 8),

                        // Text
                        Text(
                          brand,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

              const SizedBox(height: 16),

              /// ---------------- Priority ----------------
              const Text("Priority"),
              DropdownButton<String>(
                isExpanded: true,
                value: provider.selectedPriority,
                hint: const Text("Select priority"),
                items: provider.availablePriorities
                    .map((p) => DropdownMenuItem(value: p, child: Text(p)))
                    .toList(),
                onChanged: (value) {
                  provider.selectedPriority = value;
                  provider.notifyListeners();
                },
              ),
              const SizedBox(height: 16),

              /// ---------------- Tags ----------------
              const Text("Tags"),
              Wrap(
                spacing: 8,
                children: [
                  for (var tag in provider.availableTags)
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
