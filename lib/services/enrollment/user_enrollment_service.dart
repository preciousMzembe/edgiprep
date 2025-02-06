import 'package:dio/dio.dart';
import 'package:edgiprep/db/boxes.dart';
import 'package:edgiprep/db/config/config.dart';
import 'package:edgiprep/db/exam/user_exam.dart';
import 'package:edgiprep/db/lesson/lesson.dart';
import 'package:edgiprep/db/past%20paper/past_paper.dart';
import 'package:edgiprep/db/subject/user_subject.dart';
import 'package:edgiprep/db/topic/topic.dart';
import 'package:edgiprep/db/unit/unit.dart';
import 'package:edgiprep/services/auth/auth_service.dart';
import 'package:edgiprep/services/config/config_Service.dart';
import 'package:edgiprep/services/enrollment/enrollment_service.dart';
import 'package:edgiprep/utils/dio_client.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserEnrollmentService extends GetxService {
  final AuthService authService = Get.find<AuthService>();
  ConfigService configService = Get.find<ConfigService>();
  late Config? config;
  final Dio _dio = createDio();

  final EnrollmentService enrollmentService = Get.find<EnrollmentService>();

  RxBool doneFetchingUserExams = true.obs;
  RxBool doneFetchingUserSubjects = true.obs;

  RxString authToken = "".obs;

  // Ensure data is fetched upon initialization
  @override
  Future<void> onInit() async {
    super.onInit();

    config = await configService.getConfig();
    await _fetchServerData();

    config ??= await configService.getConfig();

    // listen to change after enrollment
    ever(enrollmentService.doneEnrollment, (_) async {
      _fetchServerData();
    });
  }

  // Initialize exams and subjects by fetching from server
  Future<void> _fetchServerData() async {
    config ??= await configService.getConfig();

    // check if token is not empty first
    String? token = await authService.getToken();

    if (token != null && token != '') {
      await getUserServerExams();
    }
  }

  // server user exams
  Future<void> getUserServerExams() async {
    try {
      String? token = await authService.getToken();
      final response = await _dio.get(
        '${config?.apiUrl}/Enrollment/Mobile/Enrollments',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> enrollment = response.data;

        UserExam serverExam = UserExam(
          id: enrollment['examId'],
          title: enrollment['exam']['name'],
          selected: true,
          enrollmentId: enrollment['id'],
        );

        // UserExam selectedExam = await userExamBox.values.firstWhere(
        //   (exam) => exam.selected == true,
        //   orElse: () =>
        //       UserExam(id: "", title: "", selected: false, enrollmentId: ""),
        // );

        // // mark selected exam
        // if (selectedExam.id != "") {
        //   for (UserExam exam in serverExams) {
        //     if (exam.id == selectedExam.id) {
        //       exam.selected = true;
        //     }
        //   }
        // }

        // // check if one is selected
        // selectedExam = serverExams.firstWhere(
        //   (exam) => exam.selected == true,
        //   orElse: () =>
        //       UserExam(id: "", title: "", selected: false, enrollmentId: ""),
        // );

        // if (selectedExam.id == "") {
        //   // mark first as selected
        //   serverExams[0].selected = true;
        // }

        await userExamBox.clear();
        await userExamBox.add(serverExam);

        doneFetchingUserExams.value = !doneFetchingUserExams.value;

        // get subjects
        getUserServerSubjects();
      } else if (response.statusCode == 204) {
        await userExamBox.clear();
        doneFetchingUserExams.value = !doneFetchingUserExams.value;
      }
    } on DioException catch (e) {
      debugPrint(
          "Error fetching user exams ------------------------- user enrollment service");
    }
  }

  // server user subjects
  Future<void> getUserServerSubjects() async {
    try {
      // get all subjects of exam
      String? token = await authService.getToken();

      if (userExamBox.isNotEmpty) {
        var userExam = userExamBox.values.first;

        final response = await _dio.get(
          '${config?.apiUrl}/Subject/Mobile/EnrolledSubjects?EnrollementId=${userExam.enrollmentId}',
          options: Options(
            headers: {
              'Authorization': 'Bearer $token',
            },
          ),
        );

        if (response.statusCode == 200) {
          List<UserSubject> subjects = [];

          for (var enrollment in response.data) {
            subjects.add(
              UserSubject(
                id: enrollment['subject']['id'],
                title: enrollment['subject']['name'],
                description: enrollment['subject']['description'],
                color: "rgb(81, 157, 232)",
                icon: "biology.svg",
                image: "biology.png",
                examId: enrollment['subject']['examId'],
                numberOfTopics: enrollment['totalTopics'],
                numberOfTopicsDone: enrollment['doneTopics'],
                currentTopic: "Introduction To Human Biology",
                enrollmentId: enrollment['id'],
              ),
            );
          }

          await userSubjectBox.clear();
          await userSubjectBox.addAll(subjects);

          doneFetchingUserSubjects.value = !doneFetchingUserSubjects.value;

          // get units
          getUserServerUnitsAndTopics();
          // get subjects papers
          getUserServerPapers();
        }
      }
    } on DioException catch (e) {
      debugPrint(
          "Error fetching exam subjects ------------------------- user enrollment service");
    }
  }

  // server user units
  Future<void> getUserServerUnitsAndTopics() async {
    if (userSubjectBox.isNotEmpty) {
      var userSubjects = userSubjectBox.values;

      for (UserSubject subject in userSubjects) {
        await fetchSubjectUnitsAndTopics(subject.enrollmentId);
      }

      // get lessons
      getUserServerLessons();

      // TODO:  get subjects papers
      // getUserServerPapers();
    }
  }

  Future<void> fetchSubjectUnitsAndTopics(String subjectEnrollmentId) async {
    try {
      String? token = await authService.getToken();

      final response = await _dio.get(
        '${config?.apiUrl}/Unit/Mobile/Units?SubjectEnrollmentId=$subjectEnrollmentId',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        List<Unit> units = [];
        List<Topic> topics = [];

        String unitId = "";

        for (var unit in response.data) {
          unitId = unit['id'];

          units.add(
            Unit(
              id: unit['id'],
              name: unit['name'],
              order: unit['order'],
              subjectEnrollmentId: subjectEnrollmentId,
            ),
          );

          for (var topic in unit['topics']) {
            topics.add(
              Topic(
                id: topic['topic']['id'],
                name: topic['topic']['name'],
                order: topic['topic']['order'],
                unitId: topic['topic']['unitId'],
                numberOfLessons: topic['totalLessons'],
                numberOfLessonsDone: topic['doneLessons'],
                needSubscrion: false,
              ),
            );
          }
        }

        // Save units locally
        var unitKeysToDelete = [];

        // Collect keys of units with  subjectEnrollmentId
        for (var key in unitBox.keys) {
          var entry = unitBox.get(key);
          if (entry.subjectEnrollmentId == subjectEnrollmentId) {
            unitKeysToDelete.add(key);
          }
        }

        // Delete the collected units
        for (var key in unitKeysToDelete) {
          await unitBox.delete(key);
        }

        await unitBox.addAll(units);

        // Save topics locally
        var topicKeysToDelete = [];

        // Collect keys of topics with  unitId
        for (var key in topicBox.keys) {
          var entry = topicBox.get(key);
          if (entry.unitId == unitId) {
            topicKeysToDelete.add(key);
          }
        }

        // Delete the collected topics
        for (var key in topicKeysToDelete) {
          await topicBox.delete(key);
        }

        await topicBox.addAll(topics);
      }
    } on DioException catch (e) {
      debugPrint(
          "Error fetching subject units and topics ------------------------- user enrollment service");
    }
  }

  // server user lessons
  Future<void> getUserServerLessons() async {
    // get all lessons using topics

    List<Lesson> lessons = [
      Lesson(
        id: "1",
        name: "Overview of Cell Theory",
        order: 1,
        topicId: "1",
        numberOfSlides: 4,
        numberOfSlidesDone: 4,
      ),
      Lesson(
        id: "2",
        name: "Prokaryotic vs. Eukaryotic Cells",
        order: 2,
        topicId: "1",
        numberOfSlides: 5,
        numberOfSlidesDone: 1,
      ),
      Lesson(
        id: "3",
        name: "Plant vs. Animal Cells",
        order: 3,
        topicId: "1",
        numberOfSlides: 5,
        numberOfSlidesDone: 0,
      ),
      Lesson(
        id: "4",
        name: "Basics of Linear Equations",
        order: 1,
        topicId: "3",
        numberOfSlides: 5,
        numberOfSlidesDone: 0,
      ),
      Lesson(
        id: "5",
        name: "Graphing Linear Equations",
        order: 2,
        topicId: "3",
        numberOfSlides: 6,
        numberOfSlidesDone: 0,
      ),
      Lesson(
        id: "6",
        name: "Solving and Graphing Linear Inequalities",
        order: 3,
        topicId: "3",
        numberOfSlides: 4,
        numberOfSlidesDone: 0,
      ),
    ];

    await lessonBox.clear();
    await lessonBox.addAll(lessons);
  }

  // server user papers
  Future<void> getUserServerPapers() async {
    // get all papers using user subjects

    List<PastPaper> papers = [
      PastPaper(
        id: "1",
        name: "2024 MANEB",
        duration: "2.30 hrs",
        questions: 30,
        subjectId: "1",
        score: 70,
      ),
      PastPaper(
        id: "2",
        name: "2022 Mock",
        duration: "2.20 hrs",
        questions: 25,
        subjectId: "1",
        score: 90,
      ),
      PastPaper(
        id: "3",
        name: "2023 MANEB",
        duration: "2.30 hrs",
        questions: 40,
        subjectId: "1",
        score: 40,
      ),
      PastPaper(
        id: "4",
        name: "2024 Chaminadi Mock",
        duration: "2.30 hrs",
        questions: 30,
        subjectId: "2",
        score: 60,
      ),
      PastPaper(
        id: "5",
        name: "2022 MANEB",
        duration: "2.20 hrs",
        questions: 25,
        subjectId: "2",
        score: 30,
      ),
      PastPaper(
        id: "6",
        name: "2023 MANEB",
        duration: "2.30 hrs",
        questions: 40,
        subjectId: "2",
        score: 80,
      ),
    ];

    await pastPaperBox.clear();
    await pastPaperBox.addAll(papers);
  }

  // Public getter for user exams
  Future<List<UserExam>> getExams() async {
    List<UserExam> exams = [];

    for (UserExam exam in userExamBox.values) {
      exams.add(exam);
    }

    return exams;
  }

  // Public getter for subjects for selected exam
  Future<List<UserSubject>> getSubjects() async {
    List<UserSubject> subjects = [];

    UserExam userExam = userExamBox.values.firstWhere(
      (exam) => exam.selected == true,
      orElse: () =>
          UserExam(id: "", title: "", selected: false, enrollmentId: ""),
    );

    if (userExam.id != "") {
      // get exam subjects
      for (UserSubject subject in userSubjectBox.values) {
        if (subject.examId == userExam.id) {
          subjects.add(subject);
        }
      }
    }

    return subjects;
  }

  // Public getter for all units and topics of a subject
  Future<Map<Unit, List<Topic>>> getUnitsAndTopics(
      String subjectEnrollmentId) async {
    Map<Unit, List<Topic>> unitTopicMap = {};

    // get units
    List<Unit> units = unitBox.values
        .where((unit) => unit.subjectEnrollmentId == subjectEnrollmentId)
        .cast<Unit>()
        .toList();

    units.sort((a, b) => a.order.compareTo(b.order));

    // get topics
    bool active = true;
    for (Unit unit in units) {
      List<Topic> topics = topicBox.values
          .where((topic) => topic is Topic && topic.unitId == unit.id)
          .cast<Topic>()
          .toList();

      topics.sort((a, b) => a.order.compareTo(b.order));

      // check for current topic
      for (var topic in topics) {
        topic.active = active;

        if (active == true &&
            topic.numberOfLessons > 0 &&
            (topic.numberOfLessons == topic.numberOfLessonsDone)) {
          active = true;
        } else {
          active = false;
        }
      }

      unitTopicMap[unit] = topics;
    }

    return unitTopicMap;
  }

  // Public getter for all lessons of a topic
  Future<List<Lesson>> getTopicLessons(String topicId) async {
    List<Lesson> lessons = lessonBox.values
        .where((lesson) => lesson.topicId == topicId)
        .cast<Lesson>()
        .toList();

    lessons.sort((a, b) => a.order.compareTo(b.order));

    // check for current lesson
    bool active = true;
    int index = 1;
    for (var lesson in lessons) {
      lesson.active = active;
      lesson.lessonNumber = index;
      lesson.isFirst = index == 1;
      lesson.isLast = index == lessons.length;

      if (active == true &&
          lesson.numberOfSlides > 0 &&
          (lesson.numberOfSlides == lesson.numberOfSlidesDone)) {
        active = true;
      } else {
        active = false;
      }

      index++;
    }

    return lessons;
  }

  // Public getter for all papers of a subject
  Future<List<PastPaper>> getSubjectPapers(String subjectId) async {
    List<PastPaper> pastPapers = pastPaperBox.values
        .where((paper) => paper is PastPaper && paper.subjectId == subjectId)
        .cast<PastPaper>()
        .toList();

    return pastPapers;
  }
}
