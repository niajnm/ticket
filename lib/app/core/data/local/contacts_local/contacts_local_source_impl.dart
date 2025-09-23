import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:ticket/app/core/data/local/contacts_local/contacts_local_source.dart';
import 'package:ticket/app/model/contact.dart';

class ContactsLocalSourceImpl implements ContactsLocalSource {
  @override
  Future fetchContactsGet(param) async {
    final data = await rootBundle.loadString('assets/contacts.json');
    final jsonData = json.decode(data) as List;
    var tickets = jsonData.map((q) => Contact.fromJson(q)).toList();
    return tickets;
  }
}
