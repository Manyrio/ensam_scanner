import 'dart:async';

import 'package:ensam_scanner/constants.dart';
import 'package:ensam_scanner/models/user.dart';
import 'package:flutter/material.dart';

class ScanState extends ChangeNotifier {

  bool isBusy = false;

  List<ScannedUser> history = [];

  ScannedUser? getLastScan() {

    if (history.isEmpty) return null;

    return history.last;

  }

  Future<UserModel?> newScan(BuildContext context, String? code) async {

    print(code.toString());

    if (code == null) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: const Duration(milliseconds: 1500),
            elevation: 3,
            content: Row(
              children: const [
                Icon(Icons.close, size: 18, color: Colors.white),
                SizedBox(width: 15),
                Expanded(child: Text('Scan échoué', style: TextStyle(color: Colors.white),)),
              ],
            ),
            backgroundColor: Colors.redAccent,
          )
      );

      return null;
    }

    isBusy = true;
    notifyListeners();

    // Ici il faudrait remplacer la ligne par un fetch parmis tous les utilisateurs de la BD et vérifier si il existe.
    // D'où la condition juste après pour vérifier si c'est un objet qui existe bel et bien.

    int index = knownUsers.indexWhere((element) => element.id == code);

    if (index == -1) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: const Duration(milliseconds: 1500),
            elevation: 3,
            content: Row(
              children: const [
                Icon(Icons.close, size: 18, color: Colors.white),
                SizedBox(width: 15),
                Expanded(child: Text('Utilisateur inconnu', style: TextStyle(color: Colors.white),)),
              ],
            ),
            backgroundColor: Colors.deepOrangeAccent,
          )
      );

      return null;
    }

    UserModel user = knownUsers[index];
    ScannedUser scannedUser = ScannedUser(date: DateTime.now(), userModel: user);

    // DEBITER L'UTILISATEUR

    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: const Duration(milliseconds: 1500),
          elevation: 3,
          content: Row(
            children: const [
              Icon(Icons.check, size: 18, color: Colors.white),
              SizedBox(width: 15),
              Expanded(child: Text('Utilisateur débité', style: TextStyle(color: Colors.white),)),
            ],
          ),
          backgroundColor: Colors.green,
        )
    );

    isBusy = false;
    notifyListeners();

    return UserModel(id: code);

  }

}
