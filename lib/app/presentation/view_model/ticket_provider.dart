import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:ticket/app/model/ticket.dart';

class TicketProvider with ChangeNotifier {
  List<Ticket> _tickets = [];
  List<Ticket> _filteredTickets = [];
  bool _isLoading = false;

  // filters
  String? selectedBrand;
  String? selectedPriority;
  List<String> selectedTags = [];

  List<Ticket> get tickets => _filteredTickets;
  bool get isLoading => _isLoading;

  Future<void> loadTickets() async {
    _isLoading = true;
    notifyListeners();

    final String response = await rootBundle.loadString('assets/tickets.json');
    final List data = json.decode(response);
    _tickets = data.map((e) => Ticket.fromJson(e)).toList();
    _filteredTickets = List.from(_tickets);

    _isLoading = false;
    notifyListeners();
  }

  void applyFilters() {
    if (_tickets.isEmpty) return;

    _filteredTickets = _tickets.where((ticket) {
      final brandMatch = selectedBrand == null || ticket.brand == selectedBrand;
      final priorityMatch =
          selectedPriority == null || ticket.priority == selectedPriority;
      final tagMatch =
          selectedTags.isEmpty ||
          selectedTags.any((tag) => ticket.tags.contains(tag));
      return brandMatch && priorityMatch && tagMatch;
    }).toList();

    notifyListeners();
  }

  void clearFilters() {
    selectedBrand = null;
    selectedPriority = null;
    selectedTags.clear();
    _filteredTickets = List.from(_tickets);
    notifyListeners();
  }
}
