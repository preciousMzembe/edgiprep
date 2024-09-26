import 'package:edgiprep/controllers/user_controller.dart';
import 'package:get/get.dart';

class PapersController extends GetxController {
  UserController userController = Get.find<UserController>();
  RxBool loading = false.obs;
  RxList papers = [].obs;
  RxList searchPapers = [].obs;

  Future<void> getPapers(int subjectId) async {
    papers.value = userController.subjectsPapers[subjectId.toString()];
    searchPapers.value = userController.subjectsPapers[subjectId.toString()];
  }

  Future<void> search(String term) async {
    if (term.isEmpty) {
      searchPapers.value = papers; 
    } else {
      List<String> searchTerms = term.toLowerCase().split(' ');

      searchPapers.value = papers.where((paper) {
        String paperName = paper['paperName'].toString().toLowerCase();

        return searchTerms.any((word) => paperName.contains(word));
      }).toList();
    }
  }
}
