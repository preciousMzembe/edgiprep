import 'package:edgiprep/db/boxes.dart';
import 'package:edgiprep/db/search/search_result.dart';
import 'package:edgiprep/db/subject/user_subject.dart';
import 'package:edgiprep/db/topic/topic.dart';
import 'package:get/get.dart';

class SearchService extends GetxService {
  RxList<SearchResult> searchResults = <SearchResult>[].obs;
  RxList<SearchResult> searchHistory = <SearchResult>[].obs;

  RxString searchText = ''.obs;

  // Search for subjects and topics
  void search() async {
    // search from userSubjectBox
    List<UserSubject> subjects = userSubjectBox.values
        .where((subject) => subject.title
            .toLowerCase()
            .contains(searchText.value.toLowerCase()))
        .toList()
        .cast<UserSubject>();

    // search from topicBox
    List<Topic> topics = topicBox.values
        .where((topic) =>
            topic.name.toLowerCase().contains(searchText.value.toLowerCase()) &&
            topic.active)
        .toList()
        .cast<Topic>();

    // Add subjects and topics to searchResults
    List<SearchResult> subjectResults = subjects
        .map((subject) => SearchResult(
              type: "subject",
              subject: subject,
            ))
        .toList();

    List<SearchResult> topicResults = topics.map((topic) {
      // Get the subject from the subjectBox
      UserSubject? subject = userSubjectBox.values.firstWhere(
        (subject) => subject.enrollmentId == topic.subjectEnrollmentId,
        orElse: () => UserSubject(
          id: "",
          title: "",
          description: "",
          color: "",
          icon: "",
          image: "",
          examId: "",
          numberOfTopics: 0,
          numberOfTopicsDone: 0,
          currentTopic: "",
          enrollmentId: "",
        ),
      );
      return SearchResult(
        type: "topic",
        topic: topic,
        subject: subject,
      );
    }).toList();

    searchResults.value = [...subjectResults, ...topicResults];
  }

  // Save history
  void saveHistory(SearchResult result) async {
    // Check if the result already exists in the box
    bool exists = searchResultsBox.values.any((item) =>
        item.type == result.type &&
        (result.type == "subject"
            ? item.subject!.id == result.subject!.id
            : item.topic!.id == result.topic!.id));
    if (!exists) {
      await searchResultsBox.add(result);
    }
    getHistory();
  }

  // Get history
  void getHistory() async {
    searchHistory.value = searchResultsBox.values.toList().cast<SearchResult>();
  }

  // Clear history
  void clearHistory() async {
    await searchResultsBox.clear();
    getHistory();
  }
}
