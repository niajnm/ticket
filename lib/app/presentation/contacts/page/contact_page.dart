import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ticket/app/presentation/component/app_bar.dart';
import 'package:ticket/app/presentation/contacts/widgets/contact_item.dart';
import 'package:ticket/app/presentation/component/search_bar.dart';
import 'package:ticket/app/presentation/contacts/view_model/contact_viewmodel.dart';
import 'contact_profile_page.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        final viewModel = context.read<ContactViewModel>();
        viewModel.clearSearch();
        _searchController.clear();

        if (!viewModel.isDataLoaded) {
          viewModel.loadContacts(context);
        }
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ContactViewModel>(
      builder: (context, viewModel, child) {
        if (!viewModel.isDataLoaded && viewModel.isLoading) {
          return Scaffold(
            appBar: _buildAppBar(),
            body: const Center(child: CircularProgressIndicator()),
          );
        }

        return Scaffold(
          appBar: _buildAppBar(),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _searchBar(viewModel),

              // Contacts Header
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Text('${viewModel.contacts.length} Contacts'),
              ),

              // Contacts List
              Expanded(
                child:
                    viewModel.contacts.isEmpty &&
                        viewModel.searchQuery.isNotEmpty
                    ? _buildEmptyState()
                    : ListView.builder(
                        padding: const EdgeInsets.all(15.0),
                        itemCount: viewModel.contacts.length,
                        itemBuilder: (context, index) {
                          final contact = viewModel.contacts[index];
                          return ContactItem(
                            contact: contact,
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ProfilePage(contact: contact),
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        );
      },
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return CustomAppBar(title: "Gain Solutions", notificationCount: 3);
  }

  Widget _searchBar(ContactViewModel viewModel) {
    return ModernSearchBar(
      controller: _searchController,
      hintText: 'Search contacts',
      onChanged: (query) => viewModel.searchContacts(query),
      onClear: () {
        _searchController.clear();
        viewModel.clearSearch();
      },
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_off, size: 64, color: Colors.grey),
          const SizedBox(height: 16),
          Text(
            'No contacts found',
            style: TextStyle(fontSize: 18, color: Colors.grey),
          ),
          const SizedBox(height: 8),
          Text(
            'Try searching with different keywords',
            style: TextStyle(color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }
}
