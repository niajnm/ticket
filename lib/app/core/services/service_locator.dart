import 'package:get_it/get_it.dart';
import 'package:ticket/app/core/data/local/contacts_local/contacts_local_source.dart';
import 'package:ticket/app/core/data/local/contacts_local/contacts_local_source_impl.dart';
import 'package:ticket/app/core/data/local/tickets_local/tickets_local_source.dart';
import 'package:ticket/app/core/data/local/tickets_local/tickets_local_source_impl.dart';
import 'package:ticket/app/core/data/remote/fetch/remote_source.dart';
import 'package:ticket/app/core/data/remote/fetch/remote_source_impl.dart';
import 'package:ticket/app/core/data/repository/contacts_repo/contacts_repository_source.dart';
import 'package:ticket/app/core/data/repository/contacts_repo/contacts_repository_source_impl.dart';
import 'package:ticket/app/core/data/repository/tickets_repo/tickets_repository_source.dart';
import 'package:ticket/app/core/data/repository/tickets_repo/tickets_repository_source_impl.dart';

final serviceLocator = GetIt.instance;

class ServiceLocator {
  static Future<void> setUpServiceLocator() async {
    // serviceLocator.registerLazySingleton<RemoteSource>(
    //   () => RemoteSourceImpl(remoteSource: serviceLocator()),
    // );
    serviceLocator.registerLazySingleton<TicketsLocalSource>(
      () => TicketsLocalSourceImpl(),
    );

    serviceLocator.registerLazySingleton<TicketsRepositorySource>(
      () => TicketsRepositorySourceImpl(),
    );

    serviceLocator.registerLazySingleton<ContactsLocalSource>(
      () => ContactsLocalSourceImpl(),
    );

    serviceLocator.registerLazySingleton<ContactsRepositorySource>(
      () => ContactsRepositorySourceImpl(),
    );

    serviceLocator.registerLazySingleton<RemoteSource>(
      () => RemoteSourceImpl(),
    );
  }
}
