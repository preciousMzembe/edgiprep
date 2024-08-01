import 'package:edgiprep/models/lesson_slide.dart';
import 'package:get/get.dart';

class CurrentLessonController extends GetxController {
  // Rx variables to store quiz data
  final RxString _title = "".obs;
  final RxInt _currentSlideIndex = 0.obs;
  final RxInt _score = 0.obs;
  final RxList<LessonSlide> _slides = RxList<LessonSlide>([]);
  final RxInt _selectedIndex = RxInt(-1);
  final RxBool _checkAnswer = false.obs;
  final RxBool _done = false.obs;

  // Getter methods for accessing data
  String get title => _title.value;
  int get currentSlideIndex => _currentSlideIndex.value;
  int get score => _score.value;
  List<LessonSlide> get slides => _slides.toList();
  int get numberOfSlides => _slides.length;
  int get selectedIndex => _selectedIndex.value;
  bool get checkAnswer => _checkAnswer.value;
  bool get done => _done.value;

  // Method to set parts of quiz

  void setTitle(String title) {
    _title.value = title;
  }

  void setQuestions(List<LessonSlide> questions) {
    _slides.value = questions;
  }

  void setSampleQuetions() {
    _slides.value = sampleSlides;
  }

  void setCheckAnswer(bool check) {
    _checkAnswer.value = check;
  }

  void setSelectedIndex(int index) {
    _selectedIndex.value = index;
  }

  void setDone(bool done) {
    _done.value = done;
  }

  void refreshPage() {
    setSelectedIndex(-1);
    setCheckAnswer(false);
  }

  // get number of questions
  int getNumberOfQuestions() {
    int questionCount = 0;

    for (var slide in slides) {
      if (slide.question != null) {
        questionCount++;
      }
    }

    return questionCount;
  }

  // slide
  void goToNextSlide() {
    _currentSlideIndex.value++;
  }

  // Method to check if the current question is the last one
  bool isLastSlide() => currentSlideIndex == slides.length - 1;

  // Method to handle user's answer selection
  void answerSelected(String userAnswer, String correctAnswer) async {
    // set user answer
    _slides[currentSlideIndex].question?.userAnswer = userAnswer;

    // correct or wrong
    if (userAnswer == correctAnswer) {
      _score.value++;
    }

    if (!isLastSlide()) {
      _currentSlideIndex.value++;
    }

    // uncheck answer
    refreshPage();
  }

  // Method to reset the quiz (optional)
  void resetQuiz() {
    _currentSlideIndex.value = 0;
    _score.value = 0;
    _done.value = false;

    // uncheck answer
    refreshPage();
  }
}

// Sample biology quiz questions (Multiple Choice)
final List<LessonSlide> sampleSlides = [
  LessonSlide(
    lessonId: 1,
    content: 'This is the introduction to the lesson.',
  ),
  LessonSlide(
    lessonId: 2,
    question: LessonQuestion(
      question: 'Which of the following is the basic unit of life?',
      options: ['Cell', 'Organ', 'Tissue', 'System'],
      answer: 'Cell',
    ),
  ),
  LessonSlide(
    lessonId: 3,
    content:
        'Photosynthesis is the process used by plants to convert light energy into chemical energy.',
  ),
  // LessonSlide(
  //   lessonId: 4,
  //   question: LessonQuestion(
  //     question:
  //         'What process uses sunlight, water, and carbon dioxide to produce glucose and oxygen?',
  //     options: ['Cellular respiration', 'Photosynthesis', 'Mitosis', 'Meiosis'],
  //     answer: 'Photosynthesis',
  //   ),
  // ),
];
