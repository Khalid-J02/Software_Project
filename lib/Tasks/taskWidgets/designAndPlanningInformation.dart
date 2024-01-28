import 'package:buildnex/Tasks/taskWidgets/pdfViewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:get/get.dart';

import '../../classes/language_constants.dart';

class DesignAndPlanningInformation extends StatefulWidget {
  final String title;
  final String documentName1;
  final String document1;
  final String documentName2;
  final String document2;

  DesignAndPlanningInformation({
    Key? key,
    required this.title,
    required this.documentName1,
    required this.document1,
    required this.documentName2,
    required this.document2,
  }) : super(key: key);

  @override
  State<DesignAndPlanningInformation> createState() => _DesignAndPlanningInformationState();
}

class _DesignAndPlanningInformationState extends State<DesignAndPlanningInformation> {

  double? _progress;

  void downloadFile(String _docs) {
    FileDownloader.downloadFile(
      url: _docs,
      onProgress: (name, progress) {
        setState(() {
          _progress = _progress;
        });
      },
      onDownloadCompleted: (value) {
        setState(() {
          _progress = null;
        });
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    final isRtl = Directionality.of(context) == TextDirection.rtl;

    return Directionality(
        textDirection: translation(context)!.localeName == 'ar'
        ? TextDirection.rtl
        : TextDirection.ltr,
    child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Card(
        elevation: 5,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min, // Adjusted to wrap content
          children: [
            Container(
              height: MediaQuery
                  .of(context)
                  .size
                  .height / 17,
              decoration: BoxDecoration(
                color: const Color(0xFF6781A6),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
                border: Border.all(
                  color: const Color(0xFF2F4771),
                  width: 1.0,
                ),
              ),
              child: Center(
                child: Text(
                  widget.title,
                  style: const TextStyle(
                      color: Color(0xFFFFFFFF),
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 0, right: 0, top:8),
                          child: Text(
                            widget.documentName1,
                            style:  TextStyle(
                                color: Color(0xFF2F4771),
                                fontWeight: isRtl ? FontWeight.w800 : FontWeight.w500,
                                fontSize: isRtl? 19: 16
                            ),
                          ),
                        ),
                      ),
                      _progress != null
                          ? const CircularProgressIndicator()
                          :
                      GestureDetector(
                        onTap: () {
                          if (widget.document1 != '') {
                            downloadFile(widget.document1);
                            Get.snackbar(
                              '',
                              '',
                              titleText: Text(
                                translation(context)!.snackbarHi,
                                textAlign: isRtl ? TextAlign.right : TextAlign.left,
                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                              ),
                              messageText: Text(
                                translation(context)!.snackbarDownloadContent,
                                textAlign: isRtl ? TextAlign.right : TextAlign.left,
                                style: TextStyle(color: Colors.white),
                              ),
                              backgroundColor: Color(0xFF2F4771),
                            );

                          }
                          else {
                            Get.snackbar(
                              '',
                              '',
                              titleText: Text(
                                translation(context)!.sp_task10snackbarTitle,
                                textAlign: isRtl ? TextAlign.right : TextAlign.left,
                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                              ),
                              messageText: Text(
                                translation(context)!.snackbarContent,
                                textAlign: isRtl ? TextAlign.right : TextAlign.left,
                                style: TextStyle(color: Colors.white),
                              ),
                              backgroundColor: Color(0xFF2F4771),
                            );
                          }
                        },
                        child: Container(
                          margin: isRtl ? const EdgeInsets.only(top: 5, left: 6): const EdgeInsets.only(top: 5, right: 4),
                          height: 33,
                          decoration: BoxDecoration(
                            color: const Color(0xFF2F4771),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(left: 6, right: 2),
                                child: Icon(
                                  Icons.sim_card_download,
                                  size: 19,
                                  color: Color(0xFFF9FAFB),
                                ),
                              ),
                              Padding(
                                padding: isRtl? const EdgeInsets.only(left: 8.0): const EdgeInsets.only(right: 8.0),
                                child: Text(
                                  translation(context)!.download,
                                  style: const TextStyle(
                                    color: Color(0xFFF9FAFB),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (widget.document1 != '') {
                            Get.to(DocsPdfViewer(
                              pdfFileURL: widget.document1,));
                          }
                          else {
                            Get.snackbar(translation(context)!.snackbarHi,
                                translation(context)!.snackbarContent,
                                colorText: Colors.white,
                                backgroundColor: Color(0xFF2F4771));
                          }
                        },
                        child: Container(
                          margin: const EdgeInsets.only(top: 5, right: 0),
                          height: 33,
                          decoration: BoxDecoration(
                            color: const Color(0xFF2F4771),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child:  Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(left: 8, right: 3),
                                child: Icon(
                                  Icons.file_open_outlined,
                                  size: 19,
                                  color: Color(0xFFF9FAFB),
                                ),
                              ),
                              Padding(
                                padding: isRtl? const EdgeInsets.only(left: 8.0): const EdgeInsets.only(right: 10.0),
                                child: Text(
                                  translation(context)!.open,
                                  style: const TextStyle(
                                    color: Color(0xFFF9FAFB),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ],
                          ),

                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8, right: 8, top:8),
                          child: Text(
                            widget.documentName2,
                            style:  TextStyle(
                                color: Color(0xFF2F4771),
                                fontWeight: isRtl ? FontWeight.w800 : FontWeight.w500,
                                fontSize: isRtl? 19: 16
                            ),
                          ),
                        ),
                      ),
                      _progress != null
                          ? const CircularProgressIndicator()
                          :
                      GestureDetector(
                        onTap: () {
                          if (widget.document2 != '') {
                            downloadFile(widget.document2);
                            Get.snackbar(
                              '',
                              '',
                              titleText: Text(
                                translation(context)!.snackbarHi,
                                textAlign: isRtl ? TextAlign.right : TextAlign.left,
                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                              ),
                              messageText: Text(
                                translation(context)!.snackbarDownloadContent,
                                textAlign: isRtl ? TextAlign.right : TextAlign.left,
                                style: TextStyle(color: Colors.white),
                              ),
                              backgroundColor: Color(0xFF2F4771),
                            );

                          }
                          else {
                            Get.snackbar(
                              '',
                              '',
                              titleText: Text(
                                translation(context)!.sp_task10snackbarTitle,
                                textAlign: isRtl ? TextAlign.right : TextAlign.left,
                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                              ),
                              messageText: Text(
                                translation(context)!.snackbarContent,
                                textAlign: isRtl ? TextAlign.right : TextAlign.left,
                                style: TextStyle(color: Colors.white),
                              ),
                              backgroundColor: Color(0xFF2F4771),
                            );
                          }
                        },
                        child: Container(
                          margin: isRtl ? const EdgeInsets.only(top: 5, left: 6): const EdgeInsets.only(top: 5, right: 4),
                          height: 33,
                          decoration: BoxDecoration(
                            color: const Color(0xFF2F4771),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child:  Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(left: 6, right: 2),
                                child: Icon(
                                  Icons.sim_card_download,
                                  size: 19,
                                  color: Color(0xFFF9FAFB),
                                ),
                              ),
                              Padding(
                                padding: isRtl? const EdgeInsets.only(left: 8.0): const EdgeInsets.only(right: 8.0),
                                child: Text(
                                  translation(context)!.download,
                                  style: const TextStyle(
                                    color: Color(0xFFF9FAFB),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (widget.document2 != '') {
                            Get.to(DocsPdfViewer(
                              pdfFileURL: widget.document2,
                            ));
                          }
                          else {
                            Get.snackbar(translation(context)!.snackbarHi,
                                translation(context)!.snackbarContent,
                                colorText: Colors.white,
                                backgroundColor: Color(0xFF2F4771));
                          }
                        },
                        child: Container(
                          margin: const EdgeInsets.only(top: 5, right: 0),
                          height: 33,
                          decoration: BoxDecoration(
                            color: const Color(0xFF2F4771),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child:  Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(left: 8, right: 3),
                                child: Icon(
                                  Icons.file_open_outlined,
                                  size: 19,
                                  color: Color(0xFFF9FAFB),
                                ),
                              ),
                              Padding(
                                padding: isRtl? const EdgeInsets.only(left: 8.0): const EdgeInsets.only(right: 10.0),
                                child: Text(
                                  translation(context)!.open,
                                  style: const TextStyle(
                                    color: Color(0xFFF9FAFB),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
    );
  }
}
