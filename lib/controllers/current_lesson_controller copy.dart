import 'package:edgiprep/models/lesson_question.dart';
import 'package:get/get.dart';

class CurrentLessonController extends GetxController {
  // Rx variables to store quiz data
  final RxString _title = "".obs;
  final RxInt _currentQuestionIndex = 0.obs;
  final RxInt _score = 0.obs;
  final RxList<LessonQuestion> _questions = RxList<LessonQuestion>([]);
  final RxInt _selectedIndex = RxInt(-1);
  final RxBool _checkAnswer = false.obs;
  final RxBool _showQuestion = false.obs;
  final RxList<LessonQuestion> _wrongQuestions = RxList<LessonQuestion>([]);
  final RxBool _done = false.obs;

  // Getter methods for accessing data
  String get title => _title.value;
  int get currentQuestionIndex => _currentQuestionIndex.value;
  int get score => _score.value;
  List<LessonQuestion> get questions => _questions.toList();
  int get numberOfQuestions => _questions.length;
  int get selectedIndex => _selectedIndex.value;
  bool get checkAnswer => _checkAnswer.value;
  bool get showQuestion => _showQuestion.value;
  List<LessonQuestion> get wrongQuestions => _wrongQuestions.toList();
  bool get done => _done.value;

  // Method to set parts of quiz

  void setTitle(String title) {
    _title.value = title;
  }

  void setQuestions(List<LessonQuestion> questions) {
    _questions.value = questions;
  }

  void setSampleQuetions() {
    _questions.value = sampleQuestions;
  }

  void addCorrectionQuestion(LessonQuestion question) {
    _wrongQuestions.add(question);
  }

  void emptyWrongQuestions() {
    _wrongQuestions.value = [];
  }

  void setCheckAnswer(bool check) {
    _checkAnswer.value = check;
  }

  void setShowQuestion(bool show) {
    _showQuestion.value = show;
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
    setShowQuestion(false);
  }

  // Method to show qustion for content
  void goToQuestion(){
    setShowQuestion(true);
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
final List<LessonQuestion> sampleQuestions = [
  LessonQuestion(
    questionId: 1,
    question: "Which of the following is the basic unit of life?",
    options: ["Cell", "Organ", "Tissue", "System"],
    answer: "Cell",
    userAnswer: "",
    lessonContent:
        "Cells are the basic building blocks of all living organisms. They provide structure for the body, take in nutrients from food, convert those nutrients into energy, and carry out specialized functions.",
  ),
  LessonQuestion(
    questionId: 2,
    question:
        "What process uses sunlight, water, and carbon dioxide to produce glucose and oxygen?",
    options: ["Cellular respiration", "Photosynthesis", "Mitosis", "Meiosis"],
    answer: "Photosynthesis",
    userAnswer: "",
    lessonContent:
        "Photosynthesis is the process by which green plants and some other organisms use sunlight to synthesize foods with the help of chlorophyll. The process takes in carbon dioxide and water, and converts them into glucose and oxygen.",
  ),
  LessonQuestion(
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
    lessonContent:
        "DNA, or deoxyribonucleic acid, is the hereditary material in humans and almost all other organisms. Nearly every cell in a person’s body has the same DNA. It carries genetic information used in growth, development, functioning, and reproduction.",
  ),
  LessonQuestion(
    questionId: 4,
    question:
        "What is the process by which an organism inherits traits from its parents?",
    options: ["Adaptation", "Evolution", "Heredity", "Homeostasis"],
    answer: "Heredity",
    userAnswer: "",
    lessonContent:
        "Heredity is the passing of traits from parents to their offspring, either through asexual reproduction or sexual reproduction. The offspring cells or organisms acquire the genetic information of their parents.",
  ),
  LessonQuestion(
    questionId: 5,
    question:
        "What are the structures in a plant cell that capture sunlight for photosynthesis?",
    options: ["Nucleus", "Chloroplasts", "Mitochondria", "Cell wall"],
    answer: "Chloroplasts",
    userAnswer: "",
    lessonContent:
        "Chloroplasts are the structures in plant cells and other photosynthetic organisms that capture sunlight to produce food through photosynthesis. They contain the pigment chlorophyll, which absorbs sunlight.",
  ),
  // const LessonQuestion(
  // questionId: 6,
  //   question: "What is the waste product of cellular respiration?",
  //   options: ["Glucose", "Oxygen", "Carbon dioxide", "Water"],
  //   answer: "Carbon dioxide",
  // userAnswer: "",
  // ),
  // const LessonQuestion(
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
  // const LessonQuestion(
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
  // const LessonQuestion(
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
  // const LessonQuestion(
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
