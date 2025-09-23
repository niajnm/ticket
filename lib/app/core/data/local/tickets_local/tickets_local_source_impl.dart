import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:ticket/app/core/data/local/tickets_local/tickets_local_source.dart';
import 'package:ticket/app/model/ticket.dart';

class TicketsLocalSourceImpl implements TicketsLocalSource {
  @override
  Future fetchTicketsGet(param) async {
    final data = await rootBundle.loadString('assets/tickets.json');
    final jsonData = json.decode(data) as List;
    var tickets = jsonData.map((q) => Ticket.fromJson(q)).toList();
    return tickets;
  }
}
