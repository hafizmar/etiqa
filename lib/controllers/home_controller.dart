import 'package:get/get.dart';

class HomeController extends GetxController {
  RxBool isLoading = true.obs;
  RxString isLoadingString = 'Loading...'.obs;
  RxBool isRefresh = false.obs;
}
