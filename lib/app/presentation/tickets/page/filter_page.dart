import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ticket/app/presentation/tickets/view_model/ticket_viewmodel.dart';
import 'package:ticket/app/presentation/tickets/widgets/brand_checkbox.dart';
import 'package:ticket/app/presentation/tickets/widgets/priority_dropdown.dart';
import 'package:ticket/app/presentation/tickets/widgets/section_title.dart';
import 'package:ticket/app/presentation/tickets/widgets/tag_selection.dart';

class FilterPage extends StatelessWidget {
  const FilterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: const Padding(padding: EdgeInsets.all(16), child: _FilterBody()),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.close),
        onPressed: () => Navigator.pop(context),
      ),
      title: const Text("Filters"),
      actions: [
        TextButton(
          onPressed: () {
            context.read<TicketViewModel>().clearFilters();
            Navigator.pop(context);
          },
          child: const Text("Clear"),
        ),
        TextButton(
          onPressed: () {
            context.read<TicketViewModel>().applyFilters();
            Navigator.pop(context);
          },
          child: const Text("Apply"),
        ),
      ],
    );
  }
}

class _FilterBody extends StatelessWidget {
  const _FilterBody();

  @override
  Widget build(BuildContext context) {
    return Consumer<TicketViewModel>(
      builder: (context, provider, _) {
        return ListView(
          children: const [
            SectionTitle("Brand"),
            BrandCheckbox(),
            SectionTitle("Priority"),
            PriorityDropdown(),
            SectionTitle("Tags"),
            TagsSelection(),
          ],
        );
      },
    );
  }
}
