import 'package:flutter/material.dart';

class ThemeService extends ChangeNotifier {
  
  Brightness brightness;

  ThemeService.instance() {
    brightness = Brightness.light;
  }

  changeTheme(){
    if(brightness == Brightness.dark){
      brightness = Brightness.light;
    }else{
      brightness = Brightness.dark;
    }
    notifyListeners();
  }

}