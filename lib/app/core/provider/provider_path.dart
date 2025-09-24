import 'package:provider/provider.dart';
import 'package:ticket/app/presentation/contacts/view_model/contact_viewmodel.dart';
import 'package:ticket/app/presentation/home_bottom/view_model/home_viewmodel.dart';
import 'package:ticket/app/presentation/profile/view_model/profile_viewmodel.dart';
import 'package:ticket/app/presentation/tickets/view_model/ticket_viewmodel.dart';

class ProviderPath {
  static dynamic providersList = [
    ChangeNotifierProvider(create: (_) => TicketViewModel(), lazy: true),
    ChangeNotifierProvider(create: (_) => ContactViewModel(), lazy: true),
    ChangeNotifierProvider(create: (_) => ProfileViewModel(), lazy: true),
    ChangeNotifierProvider(create: (_) => HomeViewModel(), lazy: true),

    // ChangeNotifierProvider(create: (_) => BottomNavController(), lazy: true),
    // ChangeNotifierProvider(create: (_) => ThemeController(), lazy: true),
  ];
}
