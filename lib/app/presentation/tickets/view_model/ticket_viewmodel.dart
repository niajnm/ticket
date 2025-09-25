import 'package:flutter/material.dart';
import 'package:ticket/app/core/data/repository/tickets_repo/tickets_repository_source.dart';
import 'package:ticket/app/core/services/service_locator.dart';
import 'package:ticket/app/model/ticket.dart';

class TicketViewModel with ChangeNotifier {
  final TicketsRepositorySource _ticketSource =
      serviceLocator<TicketsRepositorySource>();

  List<Ticket> _tickets = [];
  List<Ticket> _filteredTickets = [];
  bool _isLoading = false;

  // Filters
  String? selectedBrand;
  String? selectedPriority;
  List<String> selectedTags = [];

  // Dynamic filter options
  List<String> availableBrands = [];
  List<String> availableTags = [];
  List<String> availablePri = [];
  late List<String> availablePriorities = [];

  // Getters
  List<Ticket> get tickets => _filteredTickets;
  bool get isLoading => _isLoading;

  /// Load tickets from repository and extract filter options
  Future<void> loadTickets() async {
    _isLoading = true;
    notifyListeners();

    final data = await _ticketSource.fetchTicketsGet(0);
    _tickets = data;
    _filteredTickets = List.from(_tickets);

    // Extract unique brands
    availableBrands = _tickets.map((t) => t.brand).toSet().toList();

    // Extract unique tags
    availableTags = _tickets.expand((t) => t.tags).toSet().toList();

    availablePriorities = _tickets.map((t) => t.priority).toSet().toList();

    _isLoading = false;
    notifyListeners();
  }

  /// Apply filters
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

  /// Clear filters
  void clearFilters() {
    selectedBrand = null;
    selectedPriority = null;
    selectedTags.clear();
    _filteredTickets = List.from(_tickets);
    notifyListeners();
  }

  /// Toggle selected brand
  void toggleBrand(String brand) {
    selectedBrand = selectedBrand == brand ? null : brand;
    notifyListeners();
  }

  /// Set selected priority
  void setPriority(String? priority) {
    selectedPriority = priority;
    notifyListeners();
  }

  /// Toggle selectedTags
  void toggleTag(String tag) {
    if (selectedTags.contains(tag)) {
      selectedTags.remove(tag);
    } else {
      selectedTags.add(tag);
    }
    notifyListeners();
  }
}
