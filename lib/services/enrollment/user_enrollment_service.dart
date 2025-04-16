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
import 'package:edgiprep/services/configuration/configuration_service.dart';
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

    // listen to change after login
    ever(authService.doneLogin, (_) async {
      _fetchServerData();
    });

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
        List enrollments = response.data;

        if (enrollments.isNotEmpty) {
          List<UserExam> serverExams = [];

          for (var exam in enrollments) {
            serverExams.add(UserExam(
              id: exam['examId'],
              title: exam['exam']['name'],
              selected: false,
              enrollmentId: exam['id'],
            ));
          }

          UserExam selectedExam = await userExamBox.values.firstWhere(
            (exam) => exam.selected == true,
            orElse: () =>
                UserExam(id: "", title: "", selected: false, enrollmentId: ""),
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
            orElse: () =>
                UserExam(id: "", title: "", selected: false, enrollmentId: ""),
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
        }
      } else if (response.statusCode == 204) {
        await userExamBox.clear();
        doneFetchingUserExams.value = !doneFetchingUserExams.value;
      }
    } on DioException {
      debugPrint(
          "Error fetching user exams ------------------------- user enrollment service");
    }
  }

  Future<void> switchExam(String examId) async {
    // mark an exam selected from exambox
    for (UserExam exam in userExamBox.values) {
      if (exam.id == examId) {
        exam.selected = true;
      } else {
        exam.selected = false;
      }
    }

    await getUserServerExams();
  }

  // server user subjects
  Future<void> getUserServerSubjects() async {
    try {
      // get all subjects of exam
      String? token = await authService.getToken();

      if (userExamBox.isNotEmpty) {
        var userExam =
            userExamBox.values.firstWhere((exam) => exam.selected == true);

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
                color: enrollment['subject']['theme'] != null &&
                        enrollment['subject']['theme'].isNotEmpty
                    ? enrollment['subject']['theme']
                    : "#2383E2",
                icon: enrollment['subject']['icon'] != null &&
                        enrollment['subject']['icon'].isNotEmpty
                    ? "${config?.subjectsImageUrl}/${enrollment['subject']['icon']}"
                    : "${config?.subjectsImageUrl}/subject.svg",
                image: enrollment['subject']['image'] != null &&
                        enrollment['subject']['image'].isNotEmpty
                    ? "${config?.subjectsImageUrl}/${enrollment['subject']['image']}"
                    : "${config?.subjectsImageUrl}/subject.png",
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
    } on DioException {
      debugPrint(
          "Error fetching exam subjects ------------------------- user enrollment service");
    }
  }

  // server user units
  Future<void> getUserServerUnitsAndTopics() async {
    if (userSubjectBox.isNotEmpty) {
      var userSubjects = userSubjectBox.values.toList();

      List<Unit> units = [];
      List<Topic> topics = [];

      for (UserSubject subject in userSubjects) {
        Map<String, List> unitTopicMap =
            await fetchSubjectUnitsAndTopics(subject.enrollmentId);

        units.addAll(unitTopicMap['units']! as Iterable<Unit>);
        topics.addAll(unitTopicMap['topics']! as Iterable<Topic>);
      }

      await unitBox.clear();
      await unitBox.addAll(units);

      await topicBox.clear();
      await topicBox.addAll(topics);

      // delete old lessons
      await lessonBox.clear();

      // TODO:  get subjects papers
      // getUserServerPapers();
    }
  }

  Future<Map<String, List>> fetchSubjectUnitsAndTopics(
      String subjectEnrollmentId) async {
    try {
      String? token = await authService.getToken();

      List<Unit> units = [];
      List<Topic> topics = [];

      final response = await _dio.get(
        '${config?.apiUrl}/Unit/Mobile/Units?SubjectEnrollmentId=$subjectEnrollmentId',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        for (var unit in response.data) {
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
                subjectEnrollmentId: subjectEnrollmentId,
              ),
            );
          }
        }

        return {
          "units": units,
          "topics": topics,
        };
      }
    } on DioException {
      debugPrint(
          "Error fetching subject units and topics ------------------------- user enrollment service");
    }

    return {
      "units": [],
      "topics": [],
    };
  }

  // server topic lessons
  Future<void> getServerTopicLessons(Topic topic) async {
    if (topicBox.isNotEmpty) {
      try {
        String? token = await authService.getToken();

        List<Lesson> topicLessons = [];

        // get lessons

        final response = await _dio.get(
          '${config?.apiUrl}/Lesson/Mobile/Lessons?SubjectEnrollmentId=${topic.subjectEnrollmentId}&TopicId=${topic.id}',
          options: Options(
            headers: {
              'Authorization': 'Bearer $token',
            },
          ),
        );

        if (response.statusCode == 200) {
          for (var lesson in response.data) {
            topicLessons.add(
              Lesson(
                id: lesson['lesson']['id'],
                name: lesson['lesson']['name'],
                order: lesson['lesson']['order'],
                topicId: lesson['lesson']['topicId'],
                numberOfSlides: lesson['totalSlides'],
                numberOfSlidesDone: lesson['doneSlides'],
                subjectEnrollmentId: topic.subjectEnrollmentId,
              ),
            );
          }
        }

        // delete old topic lessons
        final keysToDelete = lessonBox.keys.where((key) {
          final lesson = lessonBox.get(key);
          return lesson?.topicId == topic.id;
        }).toList();

        await lessonBox.deleteAll(keysToDelete);

        // add new topic lessons
        await lessonBox.addAll(topicLessons);
      } on DioException {
        debugPrint(
            "Error fetching topic lessons ------------------------- user enrollment service");
      }
    }
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

  // Enroll new subjects
  Future<bool> enrollSubjects(
      String enrollmentId, List<String> enrollSubjectIds) async {
    try {
      String? token = await authService.getToken();

      bool done = false;

      if (enrollSubjectIds.isNotEmpty) {
        final response =
            await _dio.put('${config?.apiUrl}/Enrollment/Mobile/EnrollSubject',
                options: Options(
                  headers: {
                    'Authorization': 'Bearer $token',
                  },
                ),
                data: {
              "enrollmentId": enrollmentId,
              "subjects": enrollSubjectIds,
            });

        if (response.statusCode == 200) {
          done = true;
        }
      }

      await getUserServerSubjects();

      return done;
    } on DioException {
      debugPrint(
          "Error enrolling new subjects ------------------------- user enrollment service");
    }

    return false;
  }

  // Unnroll subject
  Future<bool> unenrollSubject(String subjectEnrollmentId) async {
    try {
      String? token = await authService.getToken();

      bool done = false;

      final unenrollResponse = await _dio.delete(
        '${config?.apiUrl}/Enrollment/Mobile/UnenrollSubject/$subjectEnrollmentId',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (unenrollResponse.statusCode == 204) {
        done = true;
      }

      await getUserServerSubjects();

      return done;
    } on DioException {
      debugPrint(
          "Error unenrolling a subject ------------------------- user enrollment service");
    }

    return false;
  }

  // Public getter for user exams
  Future<List<UserExam>> getExams() async {
    List<UserExam> exams = [];

    for (UserExam exam in userExamBox.values.toList()) {
      exams.add(exam);
    }

    return exams;
  }

  Future<UserExam> getActiveExam() async {
    return await userExamBox.values.firstWhere(
      (exam) => exam.selected == true,
      orElse: () =>
          UserExam(id: "", title: "", selected: false, enrollmentId: ""),
    );
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
      for (UserSubject subject in userSubjectBox.values.toList()) {
        if (subject.examId == userExam.id) {
          subjects.add(subject);
        }
      }
    }

    return subjects;
  }

  Future<bool> checkSubjectEnrollment(String subjectId) async {
    return userSubjectBox.values.any((subject) => subject.id == subjectId);
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
  Future<List<Lesson>> getTopicLessons(Topic topic) async {
    List<Lesson> lessons = lessonBox.values
        .where((lesson) => lesson.topicId == topic.id)
        .cast<Lesson>()
        .toList();

    if (lessons.isEmpty) {
      await getServerTopicLessons(topic);
      lessons = lessonBox.values
          .where((lesson) => lesson.topicId == topic.id)
          .cast<Lesson>()
          .toList();
    } else {
      getServerTopicLessons(topic);
    }

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
