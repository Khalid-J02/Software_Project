import 'package:flutter/material.dart';

import '../../classes/language_constants.dart';

class LandInformation extends StatefulWidget {
  String basinNumber;
  String plotNumber;

  LandInformation(
      {super.key, required this.basinNumber, required this.plotNumber});

  @override
  State<LandInformation> createState() => _TaskInformationState();
}

class _TaskInformationState extends State<LandInformation> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: translation(context)!.localeName == 'ar' ? TextDirection.rtl : TextDirection.ltr,
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
                height: MediaQuery.of(context).size.height/17 ,
                // color: Color(0xFF6781A6),
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
                    translation(context)!.landInformationMainTitle,
                    style: const TextStyle(
                        color: Color(0xFFF9FAFB),
                        fontSize: 19,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height*0.107843137 + 1,
                child: Column(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 15.0),
                              child: Center(
                                child: Text(
                                  translation(context)!.landInformationBasinNumber,
                                  style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 17
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 15.0),
                              child: Center(
                                child: Text(
                                  translation(context)!.landInformationPlotNumber,
                                  style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 17
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              widget.basinNumber,
                              style: const TextStyle(
                                  color: Color(0xFF2F4771),
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              widget.plotNumber,
                              style: const TextStyle(
                                  color: Color(0xFF2F4771),
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
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
