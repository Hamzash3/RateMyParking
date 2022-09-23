import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user_account_entity.dart';

class Session{
  setAccount(UserAccountData? userAccountData) async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final jsonObject=jsonEncode(userAccountData);
    prefs.setString("account", jsonObject);
  }
  setPassword(String password) async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("password", password);
  }
  Future<UserAccountData?> getAccount() async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? account = prefs.getString('account');
    if (account != null) {
      final jsonObject = jsonDecode(account);
      final userAccount = UserAccountData.fromJson(jsonObject);
      return userAccount;
    }
    else{
      return null;
    }
  }

  getPassword() async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? password = prefs.getString('password');
    if (password != null) {
      return password;
    }
    else{
      return "";
    }
  }
  logout() async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('account');
    await prefs.remove('password');
  }
  getAuthToken() async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? account = prefs.getString('account');
    if (account != null) {

      final jsonObject = jsonDecode(account);
      final userAccount = UserAccountData.fromJson(jsonObject);
      return userAccount.accessToken;
    }
    else{
      return null;
    }
  }
}