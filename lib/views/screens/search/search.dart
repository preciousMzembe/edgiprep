import 'package:edgiprep/utils/constants.dart';
import 'package:edgiprep/utils/device_utils.dart';
import 'package:edgiprep/views/components/search/search_input.dart';
import 'package:edgiprep/views/components/search/search_result.dart';
import 'package:edgiprep/views/components/settings/settings_back_button.dart';
import 'package:edgiprep/views/components/subject/subject_unit_name.dart';
import 'package:edgiprep/views/screens/subjects/subject.dart';
import 'package:edgiprep/views/screens/subjects/topic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:edgiprep/services/search/search_service.dart';
import 'package:google_fonts/google_fonts.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  SearchService searchService = Get.find<SearchService>();
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    searchService.getHistory();

    _searchController.addListener(() {
      searchService.searchText.value = _searchController.text.trim();
      searchService.search();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isTablet = DeviceUtils.isTablet(context);
        bool isSmallTablet = DeviceUtils.isSmallTablet(context);

        double titleSize = isTablet
            ? 34.sp
            : isSmallTablet
                ? 36.sp
                : 38.sp;

        double subtitleSize = isTablet
            ? 18.sp
            : isSmallTablet
                ? 20.sp
                : 22.sp;

        return Scaffold(
          backgroundColor: appbarColor,
          body: SafeArea(
            child: Container(
              color: backgroundColor,
              child: Obx(() {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Search and back
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 30.w,
                        vertical: 10.h,
                      ),
                      color: const Color.fromRGBO(215, 235, 255, 1),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.back();
                            },
                            child: settingsBackButton(),
                          ),
                          Expanded(
                            child: SearchInput(
                              label: "Search Everything",
                              icon: FontAwesomeIcons.magnifyingGlass,
                              radius: 16,
                              type: TextInputType.text,
                              isPassword: false,
                              controller: _searchController,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // No Search History
                    if (searchService.searchText.value.isEmpty &&
                        searchService.searchHistory.isEmpty)
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Search What You \nWant to Learn",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.inter(
                                fontSize: titleSize,
                                fontWeight: FontWeight.w800,
                                color: const Color.fromRGBO(52, 74, 106, 1),
                              ),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 60.w),
                              child: Text(
                                "Search for subjects and topics\nthat you want to dive into.",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.inter(
                                  fontSize: subtitleSize,
                                  fontWeight: FontWeight.w400,
                                  color: const Color.fromRGBO(92, 101, 120, 1),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                    // Search History
                    if (searchService.searchText.value.isEmpty &&
                        searchService.searchHistory.isNotEmpty)
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            // title
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 40.w, vertical: 30.h),
                              child: subjectUnitName("Search History"),
                            ),

                            // list
                            Expanded(
                              child: SingleChildScrollView(
                                child: Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 30.w),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      ...searchService.searchHistory.map(
                                        (result) {
                                          return Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  // Open subject or topic
                                                  if (result.type == "topic") {
                                                    Get.to(() => SubjectTopic(
                                                          subject:
                                                              result.subject!,
                                                          topic: result.topic!,
                                                        ));
                                                  } else {
                                                    Get.to(() => Subject(
                                                          subject:
                                                              result.subject!,
                                                        ));
                                                  }
                                                },
                                                child: searchResult(
                                                  getColorFromString(
                                                      result.subject!.color),
                                                  result.subject!.icon,
                                                  result.subject!.title,
                                                  result.type == "subject"
                                                      ? result
                                                          .subject!.currentTopic
                                                      : result.topic!.name,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 30.h,
                                              ),
                                            ],
                                          );
                                        },
                                      ),

                                      // clear history
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              searchService.clearHistory();
                                            },
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 35.w,
                                                  vertical: 15.h),
                                              decoration: BoxDecoration(
                                                color: const Color.fromRGBO(
                                                    52, 74, 106, 1),
                                                borderRadius:
                                                    BorderRadius.circular(30.r),
                                              ),
                                              child: Text(
                                                "Clear Search History",
                                                style: GoogleFonts.inter(
                                                  fontSize: 18.sp,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 50.h,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),

                    // Search Results
                    if (searchService.searchText.isNotEmpty &&
                        searchService.searchResults.isNotEmpty)
                      Expanded(
                        child: SingleChildScrollView(
                          padding: EdgeInsets.symmetric(
                              horizontal: 30.w, vertical: 30.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              ...searchService.searchResults.map(
                                (result) {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          // save history
                                          searchService.saveHistory(result);

                                          // Open subject or topic
                                          if (result.type == "topic") {
                                            Get.to(() => SubjectTopic(
                                                  subject: result.subject!,
                                                  topic: result.topic!,
                                                ));
                                          } else {
                                            Get.to(() => Subject(
                                                  subject: result.subject!,
                                                ));
                                          }
                                        },
                                        child: searchResult(
                                          getColorFromString(
                                              result.subject!.color),
                                          result.subject!.icon,
                                          result.subject!.title,
                                          result.type == "subject"
                                              ? result.subject!.currentTopic
                                              : result.topic!.name,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 30.h,
                                      ),
                                    ],
                                  );
                                },
                              ),

                              // bottom
                              SizedBox(
                                height: 70.h,
                              ),
                            ],
                          ),
                        ),
                      ),

                    // No Search Results
                    if (searchService.searchText.value.isNotEmpty &&
                        searchService.searchResults.isEmpty)
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "No Results Found",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.inter(
                                fontSize: titleSize,
                                fontWeight: FontWeight.w800,
                                color: const Color.fromRGBO(52, 74, 106, 1),
                              ),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 60.w),
                              child: Text(
                                "Try searching for something else.\nYou can search for subjects and topics.",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.inter(
                                  fontSize: subtitleSize,
                                  fontWeight: FontWeight.w400,
                                  color: const Color.fromRGBO(92, 101, 120, 1),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                );
              }),
            ),
          ),
        );
      },
    );
  }
}
