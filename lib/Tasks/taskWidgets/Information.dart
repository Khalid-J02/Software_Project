import 'dart:convert';
import 'dart:io';
import 'package:buildnex/Tasks/taskWidgets/pdfViewer.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../../classes/language_constants.dart';

class Information extends StatefulWidget {
  String title;
  String documentName;
  String document;

  Information({
    super.key,
    required this.title,
    required this.documentName,
    required this.document,
  });

  @override
  State<Information> createState() => _TaskInformationState();
}

class _TaskInformationState extends State<Information> {
  double? _progress;

  @override
  Widget build(BuildContext context) {
    final isRtl = Directionality.of(context) == TextDirection.rtl;

    return Directionality(
      textDirection: translation(context)!.localeName == 'ar'
          ? TextDirection.rtl
          : TextDirection.ltr,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20.0),
            bottomRight: Radius.circular(20.0),
            topRight: Radius.zero,
            topLeft: Radius.zero,
          ),
        ),
        child: Card(
          elevation: 5,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
              bottomLeft: Radius.zero,
              bottomRight: Radius.zero,
            ),
          ),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  color: Color(0xFF6781A6),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                    bottomLeft: Radius.zero,
                    bottomRight: Radius.zero,
                  ),
                  border: Border.all(
                    color: Color(0xFF2F4771),
                    width: 1.0,
                  ),
                ),
                child: Center(
                  child: Text(
                    widget.title,
                    style: const TextStyle(
                        color: Color(0xFFFFFFFF),
                        fontSize: 19,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: Text(
                                widget.documentName,
                                style:  TextStyle(
                                    color: Color(0xFF2F4771),
                                    fontSize: isRtl? 19 : 16,
                                    fontWeight:  isRtl?  FontWeight.w800: FontWeight.w500 ),
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              _progress != null
                                  ? const CircularProgressIndicator()
                                  : GestureDetector(
                                      onTap: () {
                                        if (widget.document != '') {
                                          FileDownloader.downloadFile(
                                            url: widget.document,
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
                                        margin: const EdgeInsets.only(
                                            top: 5, right: 4),
                                        height: 35,
                                        width: isRtl ? 75 : 95,
                                        decoration: BoxDecoration(
                                          color: Color(0xFF2F4771),
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                        ),
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding: isRtl
                                                  ? const EdgeInsets.only(
                                                      top: 6.0,
                                                      left: 8,
                                                      bottom: 6,
                                                      right: 4)
                                                  : const EdgeInsets.only(
                                                      top: 6.0,
                                                      left: 4,
                                                      bottom: 8,
                                                      right: 1),
                                              child: const Icon(
                                                Icons
                                                    .sim_card_download_outlined,
                                                size: 20,
                                                color: Color(0xFFF9FAFB),
                                              ),
                                            ),
                                            Text(
                                              translation(context)!.download,
                                              style: const TextStyle(
                                                  color: Color(0xFFF9FAFB),
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 14),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                              GestureDetector(
                                onTap: () {
                                  if (widget.document != null) {
                                    Get.to(DocsPdfViewer(
                                      pdfFileURL: widget.document,
                                    ));
                                  } else {
                                    Get.snackbar(
                                        translation(context)!.snackbarHi,
                                        translation(context)!.snackbarContent,
                                        colorText: Colors.white,
                                        backgroundColor: Color(0xFF2F4771));
                                  }
                                },
                                child: Container(
                                  margin: isRtl
                                      ? const EdgeInsets.only(
                                          top: 5, right: 5, left: 8)
                                      : const EdgeInsets.only(top: 5, right: 5),
                                  height: 35,
                                  width: isRtl ? 70 : 80,
                                  decoration: BoxDecoration(
                                    color: Color(0xFF2F4771),
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: isRtl
                                            ? const EdgeInsets.only(
                                                top: 6.0,
                                                left: 8,
                                                bottom: 6,
                                                right: 10)
                                            : const EdgeInsets.only(
                                                top: 6.0,
                                                left: 8,
                                                bottom: 6,
                                                right: 4),
                                        child: const Icon(
                                          Icons.file_open_outlined,
                                          size: 20,
                                          color: Color(0xFFF9FAFB),
                                        ),
                                      ),
                                      Text(
                                        translation(context)!.open,
                                        style: const TextStyle(
                                            color: Color(0xFFF9FAFB),
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14),
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
                    const SizedBox(height: 5.0),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
