import 'package:ticket/app/core/data/local/tickets_local/tickets_local_source.dart';
import 'package:ticket/app/core/data/repository/tickets_repo/tickets_repository_source.dart';
import 'package:ticket/app/core/services/service_locator.dart';

class TicketsRepositorySourceImpl implements TicketsRepositorySource {
  final TicketsLocalSource _remoteSource = serviceLocator<TicketsLocalSource>();

  @override
  Future fetchTicketsGet(param) {
    return _remoteSource.fetchTicketsGet(param);
  }
}
