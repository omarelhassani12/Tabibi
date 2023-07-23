import 'package:shared_preferences/shared_preferences.dart';

class PrefService {
  Future<void> createString(String key, String value) async { // Add return type 'void'
    SharedPreferences _pref = await SharedPreferences.getInstance();
    await _pref.setString(key, value); // Add 'await' keyword
  }

  Future<String?> readString(String key) async { // Add return type 'String?'
    SharedPreferences _pref = await SharedPreferences.getInstance();
    var cache = _pref.getString(key);
    return cache;
  }
}



// import 'package:shared_preferences/shared_preferences.dart';

// class PrefService {
//   Future createString(String key, String value) async {
//     SharedPreferences _pref = await SharedPreferences.getInstance();
//     _pref.setString(key, value);
//   }

//   Future readString(String key) async {
//     SharedPreferences _pref = await SharedPreferences.getInstance();
//     var cache = _pref.getString(key);
//     return cache;
//   }
// }
