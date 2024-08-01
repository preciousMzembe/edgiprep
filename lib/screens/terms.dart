import 'package:edgiprep/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Terms extends StatelessWidget {
  const Terms({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constants) {
        final isTall = constants.maxHeight > constants.maxWidth;
        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: 30.h,
                ),
                // top
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.w),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // back
                      GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: Container(
                          width: 50.w,
                          height: 50.w,
                          color: Colors.transparent,
                          child: Icon(
                            FontAwesomeIcons.arrowLeft,
                            size: 40.w,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20.w,
                      ),
                      Expanded(
                        child: Text(
                          "Terms of Use",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.nunito(
                            fontSize: 40.sp,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // about info
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 30.w,
                      vertical: 30.w,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                            width: 1.0,
                            color: const Color.fromARGB(92, 119, 119, 119)),
                        borderRadius: BorderRadius.circular(40.r),
                      ),
                      padding: EdgeInsets.all(40.w),
                      child: const SingleChildScrollView(
                        child: Text(
                            "EdgiPrep is designed to be your go-to resource for all your exam preparation needs. Whether you're studying for high school finals, college entrance exams, professional certifications, or any other significant assessments, EdgiPrep provides a comprehensive and personalized learning experience. Our app is built to help students and professionals alike to not only prepare efficiently but also to excel with confidence. With a user-friendly interface and a plethora of resources, EdgiPrep ensures that every user has the tools they need to succeed. \n\n One of the standout features of EdgiPrep is its extensive library of past papers. These past papers cover a wide range of subjects and exam boards, giving you the opportunity to practice and familiarize yourself with the exam format and question styles. Each paper comes with detailed solutions and explanations, helping you understand where you went wrong and how to improve. The past papers are an invaluable resource for identifying your strengths and weaknesses, allowing you to focus your study efforts more effectively. \n\n In addition to past papers, EdgiPrep offers a variety of mock exams that simulate the actual test environment. These mock exams are timed and scored just like the real thing, providing you with a realistic experience that can help reduce exam day anxiety. After completing a mock exam, you’ll receive a detailed performance analysis, highlighting areas where you excelled and topics that need more attention. This feedback loop is crucial for continuous improvement and helps build the confidence needed to perform well under pressure. \n\n The app also includes a robust set of features to support your study regimen. You can track your study hours, set daily or weekly goals, and monitor your progress over time. Personalized study plans can be created based on your exam date, ensuring you cover all necessary material before the big day. EdgiPrep also integrates seamlessly with a variety of learning resources, including flashcards, video tutorials, and interactive quizzes. These tools are designed to make studying more engaging and effective, catering to different learning styles and preferences. \n\n In addition to study tools, EdgiPrep emphasizes the importance of community and support. Join study groups, participate in discussion forums, and connect with fellow students and educators. Sharing knowledge, tips, and experiences can make the preparation process less daunting and more enjoyable. Our app fosters a collaborative learning environment where you can find motivation and encouragement from others who are on the same journey. Whether you're tackling tough subjects or looking for advice on exam strategies, the EdgiPrep community is there to support you every step of the way."),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
