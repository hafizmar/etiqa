import 'package:get/get.dart';

class HomeController extends GetxController {
  // loading bool to switch between loading screen to home screen.
  RxBool isLoading = true.obs;

  // loading string
  RxString isLoadingString = 'Loading...'.obs;
}
