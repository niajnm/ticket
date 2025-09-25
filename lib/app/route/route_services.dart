import 'package:flutter/material.dart';
import 'package:ticket/app/presentation/contacts/page/contact_page.dart';
import 'package:ticket/app/presentation/home_bottom/home_screen.dart';
import 'package:ticket/app/presentation/tickets/page/filter_page.dart';

import 'package:ticket/app/route/route_paths.dart';

class RouteServices {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutePaths.home:
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
          settings: settings,
        );

      case RoutePaths.contact:
        return MaterialPageRoute(
          builder: (_) => ContactPage(),
          settings: settings,
        );

      case RoutePaths.filter:
        return MaterialPageRoute(
          builder: (_) => FilterPage(),
          settings: settings,
        );

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(title: const Text("Page Not Found")),
        body: const Center(child: Text("404 - Page Not Found")),
      ),
    );
  }
}
