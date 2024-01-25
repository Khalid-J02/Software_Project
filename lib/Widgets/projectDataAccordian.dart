import 'package:accordion/accordion.dart';
import 'package:accordion/controllers.dart';
import 'package:buildnex/Tasks/taskWidgets/pdfViewer.dart';
import 'package:buildnex/classes/language_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainProjectDataAccordion extends StatelessWidget {

  final double? projectBuildArea ;
  final int? projectRoomsNumber ;
  final int? projectFloorNumber ;
  final String? projectDesignDocument ;
  // this is for the main accordion

  final String? projectArchStyle ;
  final String? projectDoorMaterial ;
  final String? projectDoorColor ;
  final String? projectDoorDesign ;
  final String? projectTileType ;
  final String? projectTileColor ;
  final String? projectTileSize ;
  final String? projectTilePattern ;
  final String? projectPaintType;
  final String? projectPaintColor ;
  final String? projectPaintFinish ;
  final String? projectWindowType ;
  final String? projectWindowColor ;
  final String? projectWindowDesign ;
  // this is for the optional accordion

  const MainProjectDataAccordion(
      {
        super.key,
        required this.projectBuildArea,
        required this.projectRoomsNumber,
        required this.projectFloorNumber,
        required this.projectDesignDocument,
        this.projectArchStyle ,
        this.projectDoorMaterial ,
        this.projectDoorColor ,
        this.projectDoorDesign ,
        this.projectTileType ,
        this.projectTileColor ,
        this.projectTileSize ,
        this.projectTilePattern ,
        this.projectPaintType,
        this.projectPaintColor ,
        this.projectPaintFinish ,
        this.projectWindowType ,
        this.projectWindowColor ,
        this.projectWindowDesign ,
      }
      );

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: translation(context)!.localeName == 'ar' ? TextDirection.rtl : TextDirection.ltr,
      child: Accordion(
        headerBackgroundColor: const Color(0xFF122247),
        // headerBorderColorOpened: Color(0xFFF9FAFB),
        headerBackgroundColorOpened: const Color(0xFF122247),
        contentBackgroundColor: Color(0xFF2F4991),
        contentBorderColor: Color(0xFFF9FAFB),
        contentBorderWidth: 3,
        headerBorderWidth: 3,
        contentHorizontalPadding: 15,
        scaleWhenAnimating: true,
        openAndCloseAnimation: true,
        headerPadding:
          const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
          sectionOpeningHapticFeedback: SectionHapticFeedback.heavy,
          sectionClosingHapticFeedback: SectionHapticFeedback.light,
          children: [
            AccordionSection(
              isOpen: false,
              contentVerticalPadding: 15,
              leftIcon: const Icon(
                  Icons.info,
                  color: Color(0xFFF3D69B),
              ),
              header: Text(
                translation(context)!.homeOwnerProjectDataAccordionMainTitle,
                style: const TextStyle(
                    color: Color(0xFFF9FAFB),
                    fontSize: 18,
                    fontWeight: FontWeight.w500
                ),
              ),
              content: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    //padding: const EdgeInsets.only(top: 35, right: 20, left: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          translation(context)!.homeOwnerProjectDataAccordionBuildingArea,
                          style: const TextStyle(
                              color: Color(0xFFF9FAFB),
                              fontSize: 15,
                              fontWeight: FontWeight.w400
                          ),
                        ),
                        Text( '${projectBuildArea ?? ' - '} m2',
                          style: const TextStyle(
                              color: Color(0xFFF9FAFB),
                              fontSize: 15,
                              fontWeight: FontWeight.w400
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(translation(context)!.homeOwnerProjectDataAccordionNumbersOfRooms,
                          style: const TextStyle(
                              color: Color(0xFFF9FAFB),
                              fontSize: 15,
                              fontWeight: FontWeight.w400
                          ),
                        ),
                        Text(projectRoomsNumber != null ? projectRoomsNumber.toString() : ' - ',
                          style: const TextStyle(
                              color: Color(0xFFF9FAFB),
                              fontSize: 15,
                              fontWeight: FontWeight.w400
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          translation(context)!.homeOwnerProjectDataAccordionNumbersOfFloors,
                          style: const TextStyle(
                              color: Color(0xFFF9FAFB),
                              fontSize: 15,
                              fontWeight: FontWeight.w400
                          ),
                        ),
                        Text(projectFloorNumber != null ? projectFloorNumber.toString() : ' - ',
                          style: const TextStyle(
                              color: Color(0xFFF9FAFB),
                              fontSize: 15,
                              fontWeight: FontWeight.w400
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          translation(context)!.homeOwnerProjectDataAccordionDesignDrawings,
                          style: const TextStyle(
                              color: Color(0xFFF9FAFB),
                              fontSize: 15,
                              fontWeight: FontWeight.w400
                          ),
                        ),
                        Container(
                          height: 35,
                          width: 140,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          ),
                          child: TextButton(
                            onPressed: () {
                              if(projectDesignDocument != null){
                                Get.to(DocsPdfViewer(pdfFileURL: projectDesignDocument!,)) ;
                              }
                              else{
                                Get.snackbar('Hi' ,
                                    'There is no file to open' ,
                                    colorText: Colors.white,
                                    backgroundColor: Color(0xFF2F4771)) ;
                              }
                            },
                            child: Text(
                              translation(context)!.homeOwnerProjectDataAccordionOpenDocument,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Color(0xFF122247),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ),
          ],
      ),
    );
  }
}
