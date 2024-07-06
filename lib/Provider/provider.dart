import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
 
class UiProvider extends ChangeNotifier{

bool _isDark = false;
bool get isDark => _isDark;
late SharedPreferences storage;


//custom theme settings
final darkTheme = ThemeData(
  primaryColor: Colors.black12,
  brightness: Brightness.dark,
  primaryColorDark: Colors.black12,

);
//custom light theme
final lightTheme=ThemeData(
  primaryColor: Colors.white,
  brightness: Brightness.light,
  primaryColorDark: Colors.white,
);

// Dark mode toggle action
changeTheme(){
_isDark = !isDark;
storage.setBool("isDark",_isDark);
notifyListeners();
}

//init method of provider 
init()async{
 storage = await SharedPreferences.getInstance();
  // after we run the app
  _isDark = storage.getBool("isDark")??false;
  notifyListeners();
}
}