import 'package:flutter/material.dart';
import 'package:ticket/app/core/data/repository/profile_repo/profile_repository_source.dart';
import 'package:ticket/app/core/services/service_locator.dart';
import 'package:ticket/app/model/profile_model.dart';

class ProfileViewModel with ChangeNotifier {
  final ProfileRepositorySource _profileSource =
      serviceLocator<ProfileRepositorySource>();
  Profile? _profile;
  bool _isLoading = false;
  String? _error;

  Profile? get profile => _profile;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadProfileFromJson() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _profile = await _profileSource.fetchProfileGet('');
    } catch (e) {
      _error = "Failed to load profile: $e";
    }

    _isLoading = false;
    notifyListeners();
  }
}
