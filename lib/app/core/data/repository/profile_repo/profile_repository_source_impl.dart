import 'package:ticket/app/core/data/local/profile_local/profile_local_source.dart';
import 'package:ticket/app/core/data/repository/profile_repo/profile_repository_source.dart';
import 'package:ticket/app/core/services/service_locator.dart';

class ProfileRepositorySourceImpl implements ProfileRepositorySource {
  final ProfileLocalSource _localSource = serviceLocator<ProfileLocalSource>();

  @override
  Future fetchProfileGet(param) {
    return _localSource.fetchProfileGet(param);
  }
}
