import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefUtil{


  Future<String?> getUserId() async => await _getUserId();
  Future<Map<String,String?>> getUserData() async => await _getUserData();
  // to get user id
  Future<String?> _getUserId()async{
    final pref =await SharedPreferences.getInstance();
    return pref.getString('userId');
  }

  // to get user data
  Future<Map<String, String?>> _getUserData(
      )async{
    final pref =await SharedPreferences.getInstance();
     final String? name= pref.getString('userName') ?? 'name';
    final String? email= pref.getString('userEmail')?? 'email';
    final String? mobile= pref.getString('userMobile') ?? 'mobile';
return {
  'name':name ,
  'email': email ,
  'mobile': mobile

};

  }
  Future<void> setUserData(
      {required String id,required String name,required String email, required String phone})async{
    final pref = await SharedPreferences.getInstance();
    await pref.setString('userId', id);
    await pref.setString('userName', name);
    await pref.setString('userEmail', email);
    await pref.setString('userMobile', phone);
  }
  Future<void> deleteToken()async{
    final pref = await SharedPreferences.getInstance();
    await pref.remove('userId');
  }

}
