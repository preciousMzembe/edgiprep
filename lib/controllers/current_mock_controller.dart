import 'package:edgiprep/models/test_question.dart';
import 'package:get/get.dart';

class CurrentMockController extends GetxController {
  // Rx variables to store quiz data
  final RxString _title = "".obs;
  final RxInt _currentQuestionIndex = 0.obs;
  final RxInt _score = 0.obs;
  final RxList<TestQuestion> _questions = RxList<TestQuestion>([]);
  final RxInt _selectedIndex = RxInt(-1);
  final RxBool _checkAnswer = false.obs;
  final RxList<TestQuestion> _wrongQuestions = RxList<TestQuestion>([]);
  final RxBool _done = false.obs;

  // Getter methods for accessing data
  String get title => _title.value;
  int get currentQuestionIndex => _currentQuestionIndex.value;
  int get score => _score.value;
  List<TestQuestion> get questions => _questions.toList();
  int get numberOfQuestions => _questions.length;
  int get selectedIndex => _selectedIndex.value;
  bool get checkAnswer => _checkAnswer.value;
  List<TestQuestion> get wrongQuestions => _wrongQuestions.toList();
  bool get done => _done.value;

  // Method to set parts of quiz

  void setTitle(String title) {
    _title.value = title;
  }

  void setQuestions(List<TestQuestion> questions) {
    _questions.value = questions;
  }

  void setSampleQuetions() {
    _questions.value = sampleQuestions;
  }

  void addCorrectionQuestion(TestQuestion question) {
    _wrongQuestions.add(question);
  }

  void emptyWrongQuestions() {
    _wrongQuestions.value = [];
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

  // Method to check if the current question is the last one
  bool isLastQuestion() => currentQuestionIndex == questions.length - 1;

  // Method to handle user's answer selection
  void answerSelected(String userAnswer, String correctAnswer) async {
    // set user answer
    _questions[currentQuestionIndex].userAnswer = userAnswer;

    // correct or wrong
    if (userAnswer == correctAnswer) {
      _score.value++;
    } else {
      // add wrong question
      addCorrectionQuestion(questions[_currentQuestionIndex.value]);
    }

    if (!isLastQuestion()) {
      _currentQuestionIndex.value++; // Move to the next question
    }

    // uncheck answer
    refreshPage();
  }

  // Method to reset the quiz (optional)
  void resetQuiz() {
    _currentQuestionIndex.value = 0;
    _score.value = 0;
    _done.value = false;

    // uncheck answer
    refreshPage();
  }
}

// Sample biology quiz questions (Multiple Choice)
final List<TestQuestion> sampleQuestions = [
  TestQuestion(
    questionId: 1,
    question: "Which of the following is the basic unit of life?",
    options: ["Cell", "Organ", "Tissue", "System"],
    answer: "Cell",
    userAnswer: "",
  ),
  TestQuestion(
    questionId: 2,
    question:
        "What process uses sunlight, water, and carbon dioxide to produce glucose and oxygen?",
    options: ["Cellular respiration", "Photosynthesis", "Mitosis", "Meiosis"],
    answer: "Photosynthesis",
    userAnswer: "",
  ),
  TestQuestion(
    questionId: 3,
    question: "What is the function of DNA?",
    options: [
      "To transport materials within the cell",
      "To store genetic information",
      "To provide energy for the cell",
      "To build proteins"
    ],
    answer: "To store genetic information",
    userAnswer: "",
  ),
  TestQuestion(
    questionId: 4,
    question:
        "What is the process by which an organism inherits traits from its parents?",
    options: ["Adaptation", "Evolution", "Heredity", "Homeostasis"],
    answer: "Heredity",
    userAnswer: "",
  ),
  TestQuestion(
    questionId: 5,
    question:
        "What are the structures in a plant cell that capture sunlight for photosynthesis?",
    options: ["Nucleus", "Chloroplasts", "Mitochondria", "Cell wall"],
    answer: "Chloroplasts",
    userAnswer: "",
  ),
  // const TestQuestion(
  // questionId: 6,
  //   question: "What is the waste product of cellular respiration?",
  //   options: ["Glucose", "Oxygen", "Carbon dioxide", "Water"],
  //   answer: "Carbon dioxide",
  // userAnswer: "",
  // ),
  // const TestQuestion(
  // questionId: 7,
  //   question: "What is the function of the digestive system?",
  //   options: [
  //     "To remove waste products from the body",
  //     "To transport materials throughout the body",
  //     "To break down food into smaller molecules",
  //     "To control the body's temperature"
  //   ],
  //   answer: "To break down food into smaller molecules",
  // userAnswer: "",
  // ),
  // const TestQuestion(
  // questionId: 8,
  //   question: "What is the difference between arteries and veins?",
  //   options: [
  //     "Arteries carry oxygen-rich blood, veins carry oxygen-depleted blood.",
  //     "Veins carry oxygen-rich blood, arteries carry oxygen-depleted blood.",
  //     "Arteries are thinner and less muscular than veins.",
  //     "Veins are thinner and less muscular than arteries."
  //   ],
  //   answer:
  //       "Arteries carry oxygen-rich blood, veins carry oxygen-depleted blood.",
  // userAnswer: "",
  // ),
  // const TestQuestion(
  // questionId: 9,
  //   question: "What is the role of enzymes in the body?",
  //   options: [
  //     "To provide energy",
  //     "To speed up chemical reactions",
  //     "To build structures",
  //     "To transport materials"
  //   ],
  //   answer: "To speed up chemical reactions",
  // userAnswer: "",
  // ),
  // const TestQuestion(
  // questionId: 10,
  //   question:
  //       "What is the process by which plants lose water vapor through their leaves?",
  //   options: [
  //     "Transpiration",
  //     "Cellular respiration",
  //     "Photosynthesis",
  //     "Mitosis"
  //   ],
  //   answer: "Transpiration",
  // userAnswer: "",
  // ),
];
