import 'package:edgiprep/utils/helper_functions.dart';
import 'package:edgiprep/utils/secure_storage.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  final secureStorage = SecureStorageService();

  // user variables
  final RxString _userKey = "".obs;
  final RxString _deviceId = "".obs;

  String get deviceId => _deviceId.value;
  String get userKey => _userKey.value;

  void changeDeviceId(String id) {
    _deviceId.value = id;
  }

  void changeUserKey(String key) {
    _userKey.value = key;
  }

  // User details
  RxString fullName = "".obs;
  RxString userName = "".obs;
  RxString xps = "".obs;
  RxString streak = "3".obs;
  RxString practiceHours = "10".obs;

  RxList userExams = [].obs;
  RxMap currentExam = {}.obs;
  RxList currentSubjects = [].obs;
  RxList unerolledSubjects = [].obs;
  RxMap subjectsTopics = {}.obs;
  RxMap topicsLessons = {}.obs;

  // check user key if logged in
  Future<void> checkUserKey() async {
    String? storedUserKey = await secureStorage.readKey("userKey");

    if (storedUserKey != null && storedUserKey.isNotEmpty) {
      // set user key
      changeUserKey(storedUserKey);

      // get user details
      await getUserDetails();

      // get exams
      await getExams();

      // set current exam
      await setCurrentExam();

      // get current subjects
      await getCurrentSubjects();

      // Get Unenrolled subjects
      getUnenrolledSubjects();
    }
  }

  @override
  void onInit() async {
    super.onInit();

    await checkUserKey();
  }
}
