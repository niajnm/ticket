import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:ticket/app/core/data/local/profile_local/profile_local_source.dart';
import 'package:ticket/app/model/profile_model.dart';

class ProfileLocalSourceImpl implements ProfileLocalSource {
  @override
  Future fetchProfileGet(param) async {
    final String response = await rootBundle.loadString('assets/profile.json');
    final data = json.decode(response);
    final profileData = Profile.fromJson(data);

    return profileData;
  }
}
