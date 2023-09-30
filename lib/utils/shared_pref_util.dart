import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefUtil{

  Future<String?> getToken()async{
    final pref =await SharedPreferences.getInstance();
    return pref.getString('token');
  }

  Future<void> setToken(String token)async{
    final pref = await SharedPreferences.getInstance();
    await pref.setString('token', token);
  }
  Future<void> deleteToken()async{
    final pref = await SharedPreferences.getInstance();
    await pref.remove('token');
  }

}
