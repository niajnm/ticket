import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:ticket/app/model/profile_model.dart';

class ProfileProvider with ChangeNotifier {
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
      final String response = await rootBundle.loadString(
        'assets/profile.json',
      );
      final data = json.decode(response);
      _profile = Profile.fromJson(data);
    } catch (e) {
      _error = "Failed to load profile: $e";
    }

    _isLoading = false;
    notifyListeners();
  }
}
