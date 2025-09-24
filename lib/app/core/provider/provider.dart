import 'package:provider/provider.dart';
import 'package:ticket/app/presentation/contact/contact_viewmodel.dart';
import 'package:ticket/app/presentation/profile/profile_provider.dart';
import 'package:ticket/app/presentation/view_model/ticket_provider.dart';

class ProviderPath {
  static dynamic providersList = [
    ChangeNotifierProvider(create: (_) => TicketProvider(), lazy: true),
    ChangeNotifierProvider(create: (_) => ContactViewModel(), lazy: true),
    ChangeNotifierProvider(create: (_) => ProfileProvider(), lazy: true),

    // ChangeNotifierProvider(create: (_) => BottomNavController(), lazy: true),
    // ChangeNotifierProvider(create: (_) => ThemeController(), lazy: true),
  ];
}
