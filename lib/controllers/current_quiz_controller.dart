import 'package:edgiprep/models/question.dart';
import 'package:edgiprep/utils/enums.dart';
import 'package:get/get.dart';

class CurrentQuizController extends GetxController {
  // Rx variables to store quiz data
  final Rx<TestMode> _testMode = TestMode.quiz.obs;
  final RxString _title = "".obs;
  final RxInt _currentQuestionIndex = 0.obs;
  final RxInt _score = 0.obs;
  final RxList<Question> _questions = RxList<Question>([]);
  final RxInt _selectedIndex = RxInt(-1);
  final RxBool _checkAnswer = false.obs;

  // Getter methods for accessing data
  TestMode get testMode => _testMode.value;
  String get title => _title.value;
  int get currentQuestionIndex => _currentQuestionIndex.value;
  int get score => _score.value;
  List<Question> get questions => _questions.toList();
  int get numberOfQuestions => _questions.length;
  int get selectedIndex => _selectedIndex.value;
  bool get checkAnswer => _checkAnswer.value;

  // Method to set parts of quiz
  void setTestMode(TestMode testMode) {
    _testMode.value = testMode;
  }

  void setTitle(String title) {
    _title.value = title;
  }

  void setQuestions(List<Question> questions) {
    _questions.value = questions;
  }

  void setSampleQuetions() {
    _questions.value = sampleQuestions;
  }

  void setCheckAnswer(bool check) {
    _checkAnswer.value = check;
  }

  void setSelectedIndex(int index) {
    _selectedIndex.value = index;
  }

  void refreshPage() {
    setSelectedIndex(-1);
    setCheckAnswer(false);
  }

  // Method to check if the current question is the last one
  bool isLastQuestion() => currentQuestionIndex == questions.length - 1;

  // Method to handle user's answer selection
  void answerSelected(String userAnswer, String correctAnswer) {
    if (userAnswer == correctAnswer) {
      _score.value++;
    }
    _currentQuestionIndex.value++; // Move to the next question
  }

  // Method to reset the quiz (optional)
  void resetQuiz() {
    _currentQuestionIndex.value = 0;
    _score.value = 0;
  }
}

// Sample biology quiz questions (Multiple Choice)
final List<Question> sampleQuestions = [
  const Question(
    question: "Which of the following is the basic unit of life?",
    options: ["Cell", "Organ", "Tissue", "System"],
    answer: "Cell",
  ),
  const Question(
    question:
        "What process uses sunlight, water, and carbon dioxide to produce glucose and oxygen?",
    options: ["Cellular respiration", "Photosynthesis", "Mitosis", "Meiosis"],
    answer: "Photosynthesis",
  ),
  const Question(
    question: "What is the function of DNA?",
    options: [
      "To transport materials within the cell",
      "To store genetic information",
      "To provide energy for the cell",
      "To build proteins"
    ],
    answer: "To store genetic information",
  ),
  const Question(
    question:
        "What is the process by which an organism inherits traits from its parents?",
    options: ["Adaptation", "Evolution", "Heredity", "Homeostasis"],
    answer: "Heredity",
  ),
  const Question(
    question:
        "What are the structures in a plant cell that capture sunlight for photosynthesis?",
    options: ["Nucleus", "Chloroplasts", "Mitochondria", "Cell wall"],
    answer: "Chloroplasts",
  ),
  const Question(
    question: "What is the waste product of cellular respiration?",
    options: ["Glucose", "Oxygen", "Carbon dioxide", "Water"],
    answer: "Carbon dioxide",
  ),
  const Question(
    question: "What is the function of the digestive system?",
    options: [
      "To remove waste products from the body",
      "To transport materials throughout the body",
      "To break down food into smaller molecules",
      "To control the body's temperature"
    ],
    answer: "To break down food into smaller molecules",
  ),
  const Question(
    question: "What is the difference between arteries and veins?",
    options: [
      "Arteries carry oxygen-rich blood, veins carry oxygen-depleted blood.",
      "Veins carry oxygen-rich blood, arteries carry oxygen-depleted blood.",
      "Arteries are thinner and less muscular than veins.",
      "Veins are thinner and less muscular than arteries."
    ],
    answer:
        "Arteries carry oxygen-rich blood, veins carry oxygen-depleted blood.",
  ),
  const Question(
    question: "What is the role of enzymes in the body?",
    options: [
      "To provide energy",
      "To speed up chemical reactions",
      "To build structures",
      "To transport materials"
    ],
    answer: "To speed up chemical reactions",
  ),
  const Question(
    question:
        "What is the process by which plants lose water vapor through their leaves?",
    options: [
      "Transpiration",
      "Cellular respiration",
      "Photosynthesis",
      "Mitosis"
    ],
    answer: "Transpiration",
  ),
];

// Define the Question class (adjust based on your quiz data structure)

