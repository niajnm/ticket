import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ticket/app/presentation/tickets/view_model/ticket_viewmodel.dart';

class BrandCheckbox extends StatelessWidget {
  const BrandCheckbox({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TicketViewModel>(
      builder: (context, provider, _) {
        return Column(
          children: provider.availableBrands
              .map((brand) => _BrandItem(brand: brand))
              .toList(),
        );
      },
    );
  }
}

class _BrandItem extends StatelessWidget {
  final String brand;

  const _BrandItem({required this.brand});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TicketViewModel>();
    final isSelected = provider.selectedBrand == brand;

    return InkWell(
      onTap: () => provider.toggleBrand(brand),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          children: [
            Checkbox(
              value: isSelected,
              onChanged: (_) => provider.toggleBrand(brand),
            ),
            const SizedBox(width: 8),
            const Icon(Icons.ads_click_outlined, size: 30, color: Colors.blue),
            const SizedBox(width: 8),
            Text(brand, style: const TextStyle(fontSize: 14)),
          ],
        ),
      ),
    );
  }
}
