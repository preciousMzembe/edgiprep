import 'package:dio/dio.dart';
import 'package:edgiprep/models/paper_model.dart';
import 'package:edgiprep/utils/helper_functions.dart';
import 'package:edgiprep/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PapersController extends GetxController {
  RxBool loading = false.obs;
  RxList papers = [].obs;
  RxList searchPapers = [].obs;

  Future<void> getPapers(int subjectId) async {
    int instanceId = subjectId;
    try {
      String? key = await secureStorage.readKey("userKey");

      if (key != null && key.isNotEmpty) {
        final Map<String, dynamic> headers = {
          'AuthKey': key,
          'Content-Type': 'application/json',
        };
        final response = await dio.get(
          "${ApiUrl!}/PastPaper/PastPapersWithInstanceId?instanceId=$instanceId",
          options: Options(
            headers: headers,
          ),
        );

        if (response.statusCode == 200) {
          // Update papers
          var papersData = response.data;

          List tempPapers = [];
          for (var i = 0; i < papersData.length; i++) {
            PaperModel paper = PaperModel(
              paperId: papersData[i]['pastPaperId'],
              paperName: papersData[i]['pastPaperName'],
              paperDate: papersData[i]['pastPaperDate'] ?? "March 20, 2020",
              paperDuration: papersData[i]['paperDuration'] ?? "2 hours",
              paperDone: papersData[i]['paperDone'] ?? false,
            );

            tempPapers.add(paper.toMap);
          }

          // change papers
          papers.value = tempPapers;
        }
      }
    } on DioException catch (e) {
      if (e.response != null) {
        debugPrint(
            "error getting papers -------------------------------- enrolled papers");
      } else {
        // Other errors like network issues
        debugPrint(
            "error getting papers -------------------------------- enrolled papers - connection");
      }
    } catch (e) {
      // Handle any exceptions
      debugPrint(
          "error getting papers -------------------------------- enrolled papers - error occured");
    }
  }
}
