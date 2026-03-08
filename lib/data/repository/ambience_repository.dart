import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/ambience_model.dart';

class AmbienceRepository {
  Future<List<AmbienceModel>> loadAmbiences() async {
    final String response = await rootBundle.loadString(
      'assets/data/ambiences.json',
    );

    final List data = json.decode(response);

    return data.map((e) => AmbienceModel.fromJson(e)).toList();
  }
}
