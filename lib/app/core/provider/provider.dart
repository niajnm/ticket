import 'package:provider/provider.dart';
import 'package:ticket/app/presentation/view_model/quiz_provider.dart';

class ProviderPath {
  static dynamic providersList = [
    // ChangeNotifierProvider(create: (_) => QuizProvider(), child: const MyApp()),
    ChangeNotifierProvider(create: (_) => TicketProvider(), lazy: true),

    // ChangeNotifierProvider(create: (_) => BottomNavController(), lazy: true),
    // ChangeNotifierProvider(create: (_) => ThemeController(), lazy: true),
  ];
}
