import 'package:get_it/get_it.dart';

final serviceLocator = GetIt.instance;

class ServiceLocator {
  static Future<void> setUpServiceLocator() async {
    // serviceLocator.registerLazySingleton<RemoteSource>(
    //   () => RemoteSourceImpl(remoteSource: serviceLocator()),
    // );

    // serviceLocator.registerLazySingleton<QuestionLocalSource>(
    //   () => QustionsLocalSourceImpl(),
    // );

    // serviceLocator.registerLazySingleton<QuestionRepositorySource>(
    //   () => QuestionRepositorySourceImpl(),
    // );

    // serviceLocator.registerLazySingleton<RemoteSource>(
    //   () => RemoteSourceImpl(),
    // );

    // final prefs = await SharedPreferences.getInstance();

    // serviceLocator.registerSingleton<SharedPreferences>(prefs);
    // serviceLocator.registerLazySingleton<ScoreLocalSource>(
    //   () => ScoreLocalSourceImpl(serviceLocator<SharedPreferences>()),
    // );
    // serviceLocator.registerFactory<DatabaseHelper>(() => DatabaseHelper());

    // serviceLocator.registerLazySingleton<PrefManager>(() => PrefManagerImpl());
  }
}
