import 'package:buildnex/Tasks/taskWidgets/pdfViewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:get/get.dart';

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
    return Container(
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
                      color: Color(0xFFF9FAFB),
                      fontSize: 16,
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
                          padding: const EdgeInsets.only(left: 8, right: 8),
                          child: Text(
                            widget.documentName1,
                            style: const TextStyle(
                                color: Color(0xFF2F4771),
                                fontWeight: FontWeight.w500,
                                fontSize: 16
                            ),
                          ),
                        ),
                      ),
                      _progress != null
                          ? const CircularProgressIndicator()
                          :
                      GestureDetector(
                        onTap: () {
                          if (widget.document1 != null) {
                            downloadFile(widget.document1);
                          }
                          else {
                            Get.snackbar('Hi', 'There is no file to download');
                          }
                        },
                        child: Container(
                          margin: const EdgeInsets.only(top: 5, right: 5),
                          height: 35,
                          decoration: BoxDecoration(
                            color: const Color(0xFF2F4771),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: const Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 8, right: 8),
                                child: Icon(
                                  Icons.sim_card_download,
                                  size: 20,
                                  color: Color(0xFFF9FAFB),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(right: 12.0),
                                child: Text(
                                  "Download",
                                  style: TextStyle(
                                    color: Color(0xFFF9FAFB),
                                    fontSize: 15,
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
                          if (widget.document1 != null) {
                            Get.to(DocsPdfViewer(
                              pdfFileURL: widget.document1,
                            ));
                          }
                          else {
                            Get.snackbar('Hi',
                                'There is no file to open',
                                colorText: Colors.white,
                                backgroundColor: Color(0xFF2F4771));
                          }
                        },
                        child: Container(
                          margin: const EdgeInsets.only(top: 5, right: 5),
                          height: 35,
                          decoration: BoxDecoration(
                            color: const Color(0xFF2F4771),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: const Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 8, right: 8),
                                child: Icon(
                                  Icons.file_open_outlined,
                                  size: 20,
                                  color: Color(0xFFF9FAFB),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(right: 12.0),
                                child: Text(
                                  "Open",
                                  style: TextStyle(
                                    color: Color(0xFFF9FAFB),
                                    fontSize: 15,
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
                          padding: const EdgeInsets.only(left: 8, right: 8),
                          child: Text(
                            widget.documentName2,
                            style: const TextStyle(
                                color: Color(0xFF2F4771),
                                fontWeight: FontWeight.w500,
                                fontSize: 16
                            ),
                          ),
                        ),
                      ),
                      _progress != null
                          ? const CircularProgressIndicator()
                          :
                      GestureDetector(
                        onTap: () {
                          if (widget.document2 != null) {
                            downloadFile(widget.document2);
                          }
                          else {
                            Get.snackbar('Hi', 'There is no file to download');
                          }
                        },
                        child: Container(
                          margin: const EdgeInsets.only(top: 5, right: 5),
                          height: 35,
                          decoration: BoxDecoration(
                            color: const Color(0xFF2F4771),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: const Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 8, right: 8),
                                child: Icon(
                                  Icons.sim_card_download,
                                  size: 20,
                                  color: Color(0xFFF9FAFB),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(right: 12.0),
                                child: Text(
                                  "Download",
                                  style: TextStyle(
                                    color: Color(0xFFF9FAFB),
                                    fontSize: 15,
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
                          if (widget.document2 != null) {
                            Get.to(DocsPdfViewer(
                              pdfFileURL: widget.document2,
                            ));
                          }
                          else {
                            Get.snackbar('Hi',
                                'There is no file to open',
                                colorText: Colors.white,
                                backgroundColor: Color(0xFF2F4771));
                          }
                        },
                        child: Container(
                          margin: const EdgeInsets.only(top: 5, right: 5),
                          height: 35,
                          decoration: BoxDecoration(
                            color: const Color(0xFF2F4771),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: const Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 8, right: 8),
                                child: Icon(
                                  Icons.file_open_outlined,
                                  size: 20,
                                  color: Color(0xFFF9FAFB),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(right: 12.0),
                                child: Text(
                                  "Open",
                                  style: TextStyle(
                                    color: Color(0xFFF9FAFB),
                                    fontSize: 15,
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
    );
  }
}
