
import 'package:get/get.dart';

class AuthController extends GetxController{
  bool isVisibility = false;
  bool isCheckBox = false;

  void visiblity(){
    isVisibility = !isVisibility;//for we change between them(the visible and invisible mode)


    update();//listen to this methode
  }
  void checkBox(){
    isCheckBox = !isCheckBox;//for we change between them(the visible and invisible mode)


    update();//listen to this methode
  }
}


//GetxBuilder we use this when we have alight work just small as the above

//Obx it's agianst of the GetxBuilder