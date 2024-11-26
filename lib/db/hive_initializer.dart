import 'package:edgiprep/db/boxes.dart';
import 'package:edgiprep/db/config/config.dart';
import 'package:edgiprep/db/exam/exam.dart';
import 'package:edgiprep/db/exam/user_exam.dart';
import 'package:edgiprep/db/lesson/lesson.dart';
import 'package:edgiprep/db/notification/notification.dart';
import 'package:edgiprep/db/past%20paper/past_paper.dart';
import 'package:edgiprep/db/reminder/reminder.dart';
import 'package:edgiprep/db/subject/subject.dart';
import 'package:edgiprep/db/subject/user_subject.dart';
import 'package:edgiprep/db/topic/topic.dart';
import 'package:edgiprep/db/unit/unit.dart';
import 'package:edgiprep/db/user/user.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HiveInitializer {
  Future<void> init() async {
    await Hive.initFlutter();

    // Call rebuildHiveOnFirstOpen to clear Hive data if needed
    await rebuildHiveOnFirstOpen();

    // Register adapters
    Hive.registerAdapter(ConfigAdapter());
    Hive.registerAdapter(UserAdapter());
    Hive.registerAdapter(ExamAdapter());
    Hive.registerAdapter(UserExamAdapter());
    Hive.registerAdapter(SubjectAdapter());
    Hive.registerAdapter(UserSubjectAdapter());
    Hive.registerAdapter(UnitAdapter());
    Hive.registerAdapter(TopicAdapter());
    Hive.registerAdapter(LessonAdapter());
    Hive.registerAdapter(PastPaperAdapter());
    Hive.registerAdapter(ReminderAdapter());
    Hive.registerAdapter(UserNotificationAdapter());

    // Open boxes
    try {
      userBox = await Hive.openBox<User>('userBox');
      examBox = await Hive.openBox<Exam>('examBox');
      userExamBox = await Hive.openBox<UserExam>('userExamBox');
      subjectBox = await Hive.openBox<Subject>('subjectBox');
      userSubjectBox = await Hive.openBox<UserSubject>('userSubjectBox');
      unitBox = await Hive.openBox<Unit>('unitBox');
      topicBox = await Hive.openBox<Topic>('topicBox');
      lessonBox = await Hive.openBox<Lesson>('lessonBox');
      pastPaperBox = await Hive.openBox<PastPaper>('pastPaperBox');
      configBox = await Hive.openBox<Config>('configBox');
      reminderBox = await Hive.openBox<Reminder>('reminderBox');
      notificationBox = await Hive.openBox<UserNotification>('notificationBox');
    } catch (e) {
      debugPrint("Error openig Hive boxes: $e");
    }
  }

  Future<void> rebuildHiveOnFirstOpen() async {
    final prefs = await SharedPreferences.getInstance();
    const currentVersion = 46; // Update this for each new version
    final lastVersion = prefs.getInt('last_version') ?? 0;

    if (lastVersion < currentVersion) {
      // List of all box names to be cleared
      final boxNames = [
        'userBox',
        'examBox',
        'userExamBox',
        'subjectBox',
        'userSubjectBox',
        'unitBox',
        'topicBox',
        'lessonBox',
        'pastPaperBox',
        'configBox',
        'reminderBox',
        'notificationBox',
      ];

      for (String boxName in boxNames) {
        if (await Hive.boxExists(boxName)) {
          await Hive.deleteBoxFromDisk(boxName);
        }
      }

      // Ensure future calls don't repeat this operation
      await prefs.setInt('last_version', currentVersion);
    }
  }
}
