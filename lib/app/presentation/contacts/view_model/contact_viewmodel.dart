import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:ticket/app/core/data/repository/contacts_repo/contacts_repository_source.dart';
import 'package:ticket/app/core/services/service_locator.dart';
import 'dart:convert';
import 'package:ticket/app/model/contact.dart';

class ContactViewModel extends ChangeNotifier {
  final ContactsRepositorySource _contactSource =
      serviceLocator<ContactsRepositorySource>();
  List<Contact> _allContacts = [];
  List<Contact> _filteredContacts = [];
  String _searchQuery = '';
  bool _isLoading = false;
  bool _isDataLoaded = false;

  List<Contact> get contacts => _filteredContacts;
  String get searchQuery => _searchQuery;
  bool get isLoading => _isLoading;
  bool get isDataLoaded => _isDataLoaded;

  Future<void> loadContacts(BuildContext context) async {
    if (_isLoading || _isDataLoaded) return;

    _isLoading = true;
    notifyListeners();

    try {
      final data = await _contactSource.fetchContactsGet(0);
      _allContacts = data;
      _filteredContacts = _allContacts;
      _isDataLoaded = true;
      log('Loaded ${_allContacts.length} contacts');
    } catch (e) {
      print('Error loading contacts: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void searchContacts(String query) {
    _searchQuery = query;
    if (query.isEmpty) {
      _filteredContacts = _allContacts;
    } else {
      _filteredContacts = _allContacts
          .where(
            (contact) =>
                contact.name.toLowerCase().contains(query.toLowerCase()) ||
                contact.email.toLowerCase().contains(query.toLowerCase()) ||
                contact.phone.toLowerCase().contains(query.toLowerCase()),
          )
          .toList();
    }
    notifyListeners();
  }

  void clearSearch() {
    _searchQuery = '';
    _filteredContacts = _allContacts;
    notifyListeners();
  }

  // Optional: Method to refresh data
  Future<void> refreshContacts(BuildContext context) async {
    _isDataLoaded = false;
    await loadContacts(context);
  }
}
