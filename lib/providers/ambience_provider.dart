import 'package:flutter/material.dart';

import '../data/models/ambience_model.dart';
import '../data/repository/ambience_repository.dart';

class AmbienceProvider extends ChangeNotifier {
  final AmbienceRepository _repository = AmbienceRepository();

  List<AmbienceModel> ambiences = [];

  bool isLoading = false;

  Future<void> loadAmbiences() async {
    isLoading = true;
    notifyListeners();

    ambiences = await _repository.loadAmbiences();

    print("Loaded ambiences: ${ambiences.length}");

    isLoading = false;
    notifyListeners();
  }
}
