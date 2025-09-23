import 'package:ticket/app/core/data/local/contacts_local/contacts_local_source.dart';
import 'package:ticket/app/core/data/repository/contacts_repo/contacts_repository_source.dart';
import 'package:ticket/app/core/services/service_locator.dart';

class ContactsRepositorySourceImpl implements ContactsRepositorySource {
  final ContactsLocalSource _remoteSource =
      serviceLocator<ContactsLocalSource>();

  @override
  Future fetchContactsGet(param) {
    return _remoteSource.fetchContactsGet(param);
  }
}
