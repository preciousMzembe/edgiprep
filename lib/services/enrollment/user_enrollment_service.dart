import 'package:dio/dio.dart';
import 'package:edgiprep/db/boxes.dart';
import 'package:edgiprep/db/config/config.dart';
import 'package:edgiprep/db/exam/user_exam.dart';
import 'package:edgiprep/db/lesson/lesson.dart';
import 'package:edgiprep/db/mock_exam/mock_exam.dart';
import 'package:edgiprep/db/past_paper/past_paper.dart';
import 'package:edgiprep/db/subject/subject_progress.dart';
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

    // clear old data
    await userSubjectBox.clear();
    await unitBox.clear();
    await topicBox.clear();
    await lessonBox.clear();
    await pastPaperBox.clear();
    await mockExamBox.clear();
    await searchResultsBox.clear();

    // get new data
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

        if (userExam.enrollmentId.isNotEmpty) {
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
                  currentTopic: enrollment['currentTopic'],
                  enrollmentId: enrollment['id'],
                ),
              );

              getUserServerSubjectProgress(enrollment['id']);
              getSubjectServerPapers(enrollment['subject']['id']);
              getSubjectServerMocks(enrollment['subject']['id']);
            }

            await userSubjectBox.clear();
            await userSubjectBox.addAll(subjects);

            doneFetchingUserSubjects.value = !doneFetchingUserSubjects.value;

            // get units
            getUserServerUnitsAndTopics();
          }
        } else {
          await userSubjectBox.clear();
          doneFetchingUserSubjects.value = !doneFetchingUserSubjects.value;
        }
      }
    } on DioException {
      debugPrint(
          "Error fetching exam subjects ------------------------- user enrollment service");
    }
  }

  Future<void> getUserServerSubjectProgress(String subjectEnrollmentId) async {
    try {
      String? token = await authService.getToken();

      // get progress

      final response = await _dio.get(
        '${config?.apiUrl}/Subject/Mobile/SubjectStatistic?EnrollementId=$subjectEnrollmentId',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      SubjectProgress subjectProgress = SubjectProgress(
        subjectEnrollmentId: subjectEnrollmentId,
        completedLessons: 0,
        totalLessons: 0,
        totalTopics: 0,
        coveredTopics: 0,
        completedQuizzes: 0,
        completedMocks: 0,
        completedPPs: 0,
      );

      if (response.statusCode == 200) {
        subjectProgress = SubjectProgress(
          subjectEnrollmentId: subjectEnrollmentId,
          completedLessons: response.data['completedLessons'],
          totalLessons: response.data['totalLessons'],
          totalTopics: response.data['totalTopics'],
          coveredTopics: response.data['coveredTopics'],
          completedQuizzes: response.data['completedQuizzes'],
          completedMocks: response.data['completedMocks'],
          completedPPs: response.data['completedPPs'],
        );
      }

      // delete old progress
      final keysToDelete = subjectProgressBox.keys.where((key) {
        final subjectProgressData = subjectProgressBox.get(key);
        return subjectProgressData?.subjectEnrollmentId == subjectEnrollmentId;
      }).toList();

      await subjectProgressBox.deleteAll(keysToDelete);

      // add new progress
      await subjectProgressBox.add(subjectProgress);
    } on DioException {
      debugPrint(
          "Error fetching subject progress ------------------------- user enrollment service");
    }
  }

  // server user units
  Future<void> getUserServerUnitsAndTopics() async {
    if (userSubjectBox.isNotEmpty) {
      var userSubjects = userSubjectBox.values.toList();

      for (UserSubject subject in userSubjects) {
        fetchSubjectUnitsAndTopics(subject.enrollmentId);
      }
    }
  }

  Future<void> fetchSubjectUnitsAndTopics(String subjectEnrollmentId) async {
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
            Topic newTopic = Topic(
              id: topic['topic']['id'],
              name: topic['topic']['name'],
              order: topic['topic']['order'],
              unitId: unit['id'],
              numberOfLessons: topic['totalLessons'],
              numberOfLessonsDone: topic['doneLessons'],
              needSubscrion: false,
              subjectEnrollmentId: subjectEnrollmentId,
            );
            topics.add(newTopic);

            // fetch topic lessons
            getServerTopicLessons(newTopic);
          }
        }

        // delete old subject units and topics
        final unitKeysToDelete = unitBox.keys.where((key) {
          final unit = unitBox.get(key);
          return unit?.subjectEnrollmentId == subjectEnrollmentId;
        }).toList();

        final topicKeysToDelete = topicBox.keys.where((key) {
          final topic = topicBox.get(key);
          return topic?.subjectEnrollmentId == subjectEnrollmentId;
        }).toList();

        await unitBox.deleteAll(unitKeysToDelete);
        await topicBox.deleteAll(topicKeysToDelete);

        // add new subject units and topics
        await unitBox.addAll(units);
        await topicBox.addAll(topics);

        // get all units and topics to find active or not
        getUnitsAndTopics(subjectEnrollmentId);
      }
    } on DioException {
      debugPrint(
          "Error fetching subject units and topics ------------------------- user enrollment service");
    }
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
                numberOfSlidesDone: lesson['doneSlides'] < lesson['totalSlides']
                    ? lesson['doneSlides']
                    : lesson['totalSlides'],
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
  Future<void> getSubjectServerPapers(String subjectId) async {
    try {
      String? token = await authService.getToken();

      List<PastPaper> subjectPapers = [];

      // get lessons

      final response = await _dio.get(
        '${config?.apiUrl}/Test/Mobile/GetPastPapers?SubjectId=$subjectId',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        for (var paper in response.data) {
          subjectPapers.add(
            PastPaper(
              id: paper['id'],
              name: paper['name'],
              questions: paper['questions'],
              subjectId: subjectId,
              duration: paper['duration'],
            ),
          );
        }
      }

      // delete old subject papers
      final keysToDelete = pastPaperBox.keys.where((key) {
        final paper = pastPaperBox.get(key);
        return paper?.subjectId == subjectId;
      }).toList();

      await pastPaperBox.deleteAll(keysToDelete);

      // add new subject papers
      await pastPaperBox.addAll(subjectPapers);
    } on DioException {
      debugPrint(
          "Error fetching subject papers ------------------------- user enrollment service");
    }
  }

  // server user papers
  Future<void> getSubjectServerMocks(String subjectId) async {
    try {
      String? token = await authService.getToken();

      List<MockExam> subjectMocks = [];

      // get mocks

      final response = await _dio.get(
        '${config?.apiUrl}/Test/Mobile/GetMocks?SubjectId=$subjectId',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        for (var mock in response.data) {
          subjectMocks.add(
            MockExam(
              id: mock['id'],
              name: mock['name'],
              questions: mock['questions'],
              subjectId: subjectId,
              duration: mock['duration'],
            ),
          );
        }
      }

      // delete old subject mocks
      final keysToDelete = mockExamBox.keys.where((key) {
        final mock = mockExamBox.get(key);
        return mock?.subjectId == subjectId;
      }).toList();

      await mockExamBox.deleteAll(keysToDelete);

      // add new subject mocks
      await mockExamBox.addAll(subjectMocks);
    } on DioException {
      debugPrint(
          "Error fetching subject mocks ------------------------- user enrollment service");
    }
  }

  // Unenroll exam
  Future<bool> unenrollExam(String examEnrollmentId) async {
    try {
      String? token = await authService.getToken();

      bool done = false;

      final unenrollResponse = await _dio.delete(
        '${config?.apiUrl}/Enrollment/Mobile/Unenroll/$examEnrollmentId',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (unenrollResponse.statusCode == 204) {
        done = true;
      }

      await getUserServerExams();

      return done;
    } on DioException {
      debugPrint(
          "Error unenrolling an exam ------------------------- user enrollment service");
    }

    return false;
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
        // Delete subject units, topics, lessons
        final unitKeysToDelete = unitBox.keys.where((key) {
          final unit = unitBox.get(key);
          return unit?.subjectEnrollmentId == subjectEnrollmentId;
        }).toList();
        final topicKeysToDelete = topicBox.keys.where((key) {
          final topic = topicBox.get(key);
          return topic?.subjectEnrollmentId == subjectEnrollmentId;
        }).toList();
        final lessonKeysToDelete = lessonBox.keys.where((key) {
          final lesson = lessonBox.get(key);
          return lesson?.subjectEnrollmentId == subjectEnrollmentId;
        }).toList();

        await unitBox.deleteAll(unitKeysToDelete);
        await topicBox.deleteAll(topicKeysToDelete);
        await lessonBox.deleteAll(lessonKeysToDelete);

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

  Future<SubjectProgress> getSubjetProgress(String subjectEnrollmentId) async {
    SubjectProgress progress = subjectProgressBox.values.firstWhere(
        (subjectProgress) =>
            subjectProgress.subjectEnrollmentId == subjectEnrollmentId,
        orElse: () => SubjectProgress(
              subjectEnrollmentId: "",
              completedLessons: 0,
              totalLessons: 0,
              totalTopics: 0,
              coveredTopics: 0,
              completedQuizzes: 0,
              completedMocks: 0,
              completedPPs: 0,
            ));

    if (progress.subjectEnrollmentId == "") {
      await getUserServerSubjectProgress(subjectEnrollmentId);

      progress = subjectProgressBox.values.firstWhere(
          (subjectProgress) =>
              subjectProgress.subjectEnrollmentId == subjectEnrollmentId,
          orElse: () => SubjectProgress(
                subjectEnrollmentId: "",
                completedLessons: 0,
                totalLessons: 0,
                totalTopics: 0,
                coveredTopics: 0,
                completedQuizzes: 0,
                completedMocks: 0,
                completedPPs: 0,
              ));
    } else {
      getUserServerSubjectProgress(subjectEnrollmentId);
    }

    return progress;
  }

  Future<bool> checkSubjectEnrollment(String subjectId) async {
    return userSubjectBox.values.any((subject) => subject.id == subjectId);
  }

  Future<bool> checkExamEnrollment(String examId) async {
    return userExamBox.values.any((exam) => exam.id == examId);
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
          .where((topic) =>
              topic is Topic &&
              topic.unitId == unit.id &&
              topic.subjectEnrollmentId == subjectEnrollmentId)
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

  // Public getter for topic and all lessons of a topic
  Future<Topic> getTopic(String topicId, String subjectEnrollmentId) async {
    return await topicBox.values.firstWhere(
      (topic) =>
          topic.id == topicId &&
          topic.subjectEnrollmentId == subjectEnrollmentId,
      orElse: () => Topic(
        id: "",
        name: "",
        order: 0,
        unitId: "",
        numberOfLessons: 0,
        numberOfLessonsDone: 0,
        needSubscrion: false,
        subjectEnrollmentId: "",
      ),
    );
  }

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

    if (pastPapers.isEmpty) {
      await getSubjectServerPapers(subjectId);
      pastPapers = pastPaperBox.values
          .where((paper) => paper is PastPaper && paper.subjectId == subjectId)
          .cast<PastPaper>()
          .toList();
    } else {
      getSubjectServerPapers(subjectId);
    }

    return pastPapers;
  }

  int getSubjectPapersCount(String subjectId) {
    return pastPaperBox.values
        .where((paper) => paper is PastPaper && paper.subjectId == subjectId)
        .length;
  }

  // Public getter for all mocks of a subject
  Future<List<MockExam>> getSubjectMocks(String subjectId) async {
    List<MockExam> mockExams = mockExamBox.values
        .where((mock) => mock is MockExam && mock.subjectId == subjectId)
        .cast<MockExam>()
        .toList();

    if (mockExams.isEmpty) {
      await getSubjectServerMocks(subjectId);
      mockExams = mockExamBox.values
          .where((mock) => mock is MockExam && mock.subjectId == subjectId)
          .cast<MockExam>()
          .toList();
    } else {
      getSubjectServerMocks(subjectId);
    }

    return mockExams;
  }

  int getSubjectMocksCount(String subjectId) {
    return mockExamBox.values
        .where((mock) => mock is MockExam && mock.subjectId == subjectId)
        .length;
  }

  Future<List<UserSubject>> getSubjectsByExamId(String examEnrollmetId) async {
    try {
      // get all subjects of exam
      String? token = await authService.getToken();

      final response = await _dio.get(
        '${config?.apiUrl}/Subject/Mobile/EnrolledSubjects?EnrollementId=$examEnrollmetId',
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

        return subjects;
      }
    } on DioException {
      debugPrint(
          "Error fetching exam subjects ------------------------- user enrollment service");
    }

    return [];
  }
}
