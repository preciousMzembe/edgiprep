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
import 'package:edgiprep/utils/dio_client.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserEnrollmentService extends GetxService {
  final AuthService authService = Get.find<AuthService>();
  ConfigService configService = Get.find<ConfigService>();
  late Config? config;
  final Dio _dio = createDio();

  RxBool doneFetchingUserExams = true.obs;
  RxBool doneFetchingUserSubjects = true.obs;

  RxString authToken = "".obs;

  // Ensure data is fetched upon initialization
  @override
  Future<void> onInit() async {
    super.onInit();

    config = await configService.getConfig();
    await _fetchServerData();
  }

  // Initialize exams and subjects by fetching from server
  Future<void> _fetchServerData() async {
    config ??= await configService.getConfig();

    // String? tocket = await authService.getToken();

    // if (tocket != null) {
    //   await getUserServerExams();
    // }

    await getUserServerExams();
  }

  // server user exams
  Future<void> getUserServerExams() async {
    try {
      // final response = await _dio.get("${config?.apiUrl}/Exam/Exams");

      // if (response.statusCode == 200) {
      // List<dynamic> data = response.data;

      List<UserExam> serverExams = [
        UserExam(id: "1", title: "JCE", selected: false),
      ];

      // if (data.isNotEmpty) {
      //   for (var exam in data) {
      //     serverExams.add(
      //       UserExam(
      //         id: exam['id'],
      //         title: exam['name'],
      //         selected: false,
      //       ),
      //     );
      //   }
      // }

      UserExam selectedExam = await userExamBox.values.firstWhere(
        (exam) => exam.selected == true,
        orElse: () => UserExam(id: "", title: "", selected: false),
      );

      // mark selected exam
      if (selectedExam.id != "") {
        for (UserExam exam in serverExams) {
          if (exam.id == selectedExam.id) {
            exam.selected = true;
          }
        }
      }

      // check if one is selected
      selectedExam = serverExams.firstWhere(
        (exam) => exam.selected == true,
        orElse: () => UserExam(id: "", title: "", selected: false),
      );

      if (selectedExam.id == "") {
        // mark first as selected
        serverExams[0].selected = true;
      }

      await userExamBox.clear();
      await userExamBox.addAll(serverExams);

      doneFetchingUserExams.value = !doneFetchingUserExams.value;

      // get subjects
      getUserServerSubjects();
      // } else {
      //   debugPrint(
      //       "Error fetching user exams ------------------------- user enrollment service");
      // }
    } catch (e) {
      debugPrint(
          "Error fetching user exams ------------------------- user enrollment service : error");
    }
  }

  // server user subjects
  Future<void> getUserServerSubjects() async {
    // get all subjects of selected exam

    UserExam userExam = userExamBox.values.firstWhere(
      (exam) => exam.selected == true,
      orElse: () => UserExam(id: "", title: "", selected: false),
    );

    List<UserSubject> subjects = [
      UserSubject(
        id: "1",
        title: "Biology",
        description: "Biology Info",
        color: "rgb(81, 157, 232)",
        icon: "biology.svg",
        image: "biology.png",
        examId: "1",
        numberOfTopics: 2,
        numberOfTopicsDone: 1,
        currentTopic: "Introduction To Human Biology",
      ),
      UserSubject(
        id: "2",
        title: "Matematics",
        description: "Mathematics Info",
        color: "rgb(134, 214, 152)",
        icon: "maths.svg",
        image: "maths.png",
        examId: "1",
        numberOfTopics: 2,
        numberOfTopicsDone: 0,
        currentTopic: "Introduction To Algebra One",
      ),
    ];

    await userSubjectBox.clear();
    await userSubjectBox.addAll(subjects);

    doneFetchingUserSubjects.value = !doneFetchingUserSubjects.value;

    // get units
    getUserServerUnits();
    // get subjects papers
    getUserServerPapers();
  }

  // server user units
  Future<void> getUserServerUnits() async {
    // get all units using user subjects

    List<Unit> units = [
      Unit(
        id: "1",
        name: "Cell Biology",
        order: 1,
        subjectId: "1",
      ),
      Unit(
        id: "2",
        name: "Genetics and Molecular Biology",
        order: 2,
        subjectId: "1",
      ),
      Unit(
        id: "3",
        name: "Algebra",
        order: 1,
        subjectId: "2",
      ),
    ];

    await unitBox.clear();
    await unitBox.addAll(units);

    // get topics
    getUserServerTopics();
  }

  // server user topics
  Future<void> getUserServerTopics() async {
    // get all topics using user units

    List<Topic> topics = [
      Topic(
        id: "1",
        name: "Introduction to the Cell",
        order: 1,
        unitId: "1",
        numberOfLessons: 3,
        numberOfLessonsDone: 1,
        needSubscrion: false,
      ),
      Topic(
        id: "2",
        name: "DNA Structure and Function",
        order: 1,
        unitId: "2",
        numberOfLessons: 3,
        numberOfLessonsDone: 0,
        needSubscrion: true,
      ),
      Topic(
        id: "3",
        name: "Linear Equations and Inequalities",
        order: 1,
        unitId: "3",
        numberOfLessons: 3,
        numberOfLessonsDone: 0,
        needSubscrion: false,
      ),
      Topic(
        id: "4",
        name: "Quadratic Equations",
        order: 2,
        unitId: "3",
        numberOfLessons: 3,
        numberOfLessonsDone: 0,
        needSubscrion: false,
      ),
    ];

    await topicBox.clear();
    await topicBox.addAll(topics);

    // get lessons
    getUserServerLessons();
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
      orElse: () => UserExam(id: "", title: "", selected: false),
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
  Future<Map<Unit, List<Topic>>> getUnitsAndTopics(String subjectId) async {
    Map<Unit, List<Topic>> unitTopicMap = {};

    // get units
    List<Unit> units = unitBox.values
        .where((unit) => unit.subjectId == subjectId)
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
