import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ticket/app/presentation/contacts/page/contact_page.dart';
import 'package:ticket/app/presentation/home_bottom/view_model/home_viewmodel.dart';
import 'package:ticket/app/presentation/profile/page/profile_page.dart';
import 'package:ticket/app/presentation/tickets/page/ticket_page.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  final List<Widget> _pages = const [
    TicketsPage(),
    ContactPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeViewModel>(
      builder: (context, viewModel, child) {
        return Scaffold(
          body: _pages[viewModel.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: viewModel.currentIndex,
            onTap: viewModel.setIndex,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.confirmation_num_outlined),
                label: "Tickets",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.contacts),
                label: "Contacts",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outline),
                label: "Profile",
              ),
            ],
          ),
        );
      },
    );
  }
}
