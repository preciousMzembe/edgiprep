import 'dart:convert';

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
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HiveInitializer {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  final String _encryptionKey = "hiveEncryptionKey";

  // Generate & Store Secure Key
  Future<void> generateAndStoreKey() async {
    final encryptionKey = Hive.generateSecureKey();
    String encodedKey = base64Encode(encryptionKey);

    await _secureStorage.write(
      key: _encryptionKey,
      value: encodedKey,
    );
  }

  // Retrieve Encryption Key from Secure Storage or Generate If Not There
  Future<List<int>> getEncryptionKey() async {
    try {
      String? keyString = await _secureStorage.read(key: _encryptionKey);

      if (keyString == null || keyString.isEmpty) {
        await generateAndStoreKey();
        keyString = await _secureStorage.read(key: _encryptionKey);
      }

      return base64Decode(keyString!);
    } catch (e) {
      // Delete corrupted key and generate a new one
      await _secureStorage.delete(key: _encryptionKey);
      await generateAndStoreKey();
      String? keyString = await _secureStorage.read(key: _encryptionKey);
      return base64Decode(keyString!);
    }
  }

  // Open Hive Box with Encryption
  Future<Box<T>> openSecureBox<T>(String boxName) async {
    final encryptionKey = await getEncryptionKey();

    final encryptedBox = await Hive.openBox<T>(
      boxName,
      encryptionCipher: HiveAesCipher(encryptionKey),
    );

    return encryptedBox;
  }

  Future<void> init() async {
    await Hive.initFlutter();

    // Check first install (prevent secure storage errors)
    await checkForReinstall();

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
      userBox = await openSecureBox<User>('userBox');
      examBox = await openSecureBox<Exam>('examBox');
      userExamBox = await openSecureBox<UserExam>('userExamBox');
      subjectBox = await openSecureBox<Subject>('subjectBox');
      userSubjectBox = await openSecureBox<UserSubject>('userSubjectBox');
      unitBox = await openSecureBox<Unit>('unitBox');
      topicBox = await openSecureBox<Topic>('topicBox');
      lessonBox = await openSecureBox<Lesson>('lessonBox');
      pastPaperBox = await openSecureBox<PastPaper>('pastPaperBox');
      configBox = await openSecureBox<Config>('configBox');
      reminderBox = await openSecureBox<Reminder>('reminderBox');
      notificationBox =
          await openSecureBox<UserNotification>('notificationBox');
    } catch (e) {
      debugPrint("Error openig Hive boxes: $e");
    }
  }

  Future<void> rebuildHiveOnFirstOpen() async {
    final prefs = await SharedPreferences.getInstance();
    const currentVersion = 3; // Update this for each new version
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

  Future<void> checkForReinstall() async {
    final prefs = await SharedPreferences.getInstance();
    bool isFirstLaunch = prefs.getBool('first_launch') ?? true;

    if (isFirstLaunch) {
      debugPrint("🛑 App reinstall detected! Clearing Secure Storage...");
      await _secureStorage.deleteAll();
      await prefs.setBool('first_launch', false);
    }
  }
}
