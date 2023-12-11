import 'package:accordion/accordion.dart';
import 'package:accordion/controllers.dart';
import 'package:flutter/material.dart';

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
    return Accordion(
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
            header: const Text(
              'Main Project Information',
              style: TextStyle(
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
                      const Text('Building Area',
                        style: TextStyle(
                            color: Color(0xFFF9FAFB),
                            fontSize: 15,
                            fontWeight: FontWeight.w400
                        ),
                      ),
                      Text( '${projectBuildArea} m2',
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
                      const Text('Numbers of Rooms',
                        style: TextStyle(
                            color: Color(0xFFF9FAFB),
                            fontSize: 15,
                            fontWeight: FontWeight.w400
                        ),
                      ),
                      Text( projectRoomsNumber.toString(),
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
                      const Text('Numbers of Floors',
                        style: TextStyle(
                            color: Color(0xFFF9FAFB),
                            fontSize: 15,
                            fontWeight: FontWeight.w400
                        ),
                      ),
                      Text( projectFloorNumber.toString(),
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
                      const Text('Design Document',
                        style: TextStyle(
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

                            // here you shold implement the function to open the pdf file from the url

                          },
                          child: const Text(
                            'Open Document',
                            style: TextStyle(
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
          AccordionSection(
              isOpen: false,
              contentVerticalPadding: 15,
              leftIcon: const Icon(
                Icons.info,
                color: Color(0xFFF3D69B),
              ),
              header: const Text(
                'Optional Project Information',
                style: TextStyle(
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        const Text('Architectural Style',
                          style: TextStyle(
                              color: Color(0xFFF9FAFB),
                              fontSize: 16,
                              fontWeight: FontWeight.w400
                          ),
                        ),
                        Text( '$projectArchStyle',
                          style: const TextStyle(
                              color: Color(0xFFF9FAFB),
                              fontSize: 16,
                              fontWeight: FontWeight.w400
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        const Text('Door Material',
                          style: TextStyle(
                              color: Color(0xFFF9FAFB),
                              fontSize: 16,
                              fontWeight: FontWeight.w400
                          ),
                        ),
                        Text( '$projectDoorMaterial',
                          style: const TextStyle(
                              color: Color(0xFFF9FAFB),
                              fontSize: 16,
                              fontWeight: FontWeight.w400
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        const Text('Door Color',
                          style: TextStyle(
                              color: Color(0xFFF9FAFB),
                              fontSize: 16,
                              fontWeight: FontWeight.w400
                          ),
                        ),
                        Text( '$projectDoorColor',
                          style: const TextStyle(
                              color: Color(0xFFF9FAFB),
                              fontSize: 16,
                              fontWeight: FontWeight.w400
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        const Text('Door Design',
                          style: TextStyle(
                              color: Color(0xFFF9FAFB),
                              fontSize: 16,
                              fontWeight: FontWeight.w400
                          ),
                        ),
                        Text( '$projectDoorDesign',
                          style: const TextStyle(
                              color: Color(0xFFF9FAFB),
                              fontSize: 16,
                              fontWeight: FontWeight.w400
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        const Text('Tile Type',
                          style: TextStyle(
                              color: Color(0xFFF9FAFB),
                              fontSize: 16,
                              fontWeight: FontWeight.w400
                          ),
                        ),
                        Text( '$projectTileType',
                          style: const TextStyle(
                              color: Color(0xFFF9FAFB),
                              fontSize: 16,
                              fontWeight: FontWeight.w400
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        const Text('Tile Color',
                          style: TextStyle(
                              color: Color(0xFFF9FAFB),
                              fontSize: 16,
                              fontWeight: FontWeight.w400
                          ),
                        ),
                        Text( '$projectTileColor',
                          style: const TextStyle(
                              color: Color(0xFFF9FAFB),
                              fontSize: 16,
                              fontWeight: FontWeight.w400
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        const Text('Tile Size',
                          style: TextStyle(
                              color: Color(0xFFF9FAFB),
                              fontSize: 16,
                              fontWeight: FontWeight.w400
                          ),
                        ),
                        Text( '$projectTileSize',
                          style: const TextStyle(
                              color: Color(0xFFF9FAFB),
                              fontSize: 16,
                              fontWeight: FontWeight.w400
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        const Text('Tile Pattern',
                          style: TextStyle(
                              color: Color(0xFFF9FAFB),
                              fontSize: 16,
                              fontWeight: FontWeight.w400
                          ),
                        ),
                        Text( '$projectTilePattern',
                          style: const TextStyle(
                              color: Color(0xFFF9FAFB),
                              fontSize: 16,
                              fontWeight: FontWeight.w400
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        const Text('Paint Type',
                          style: TextStyle(
                              color: Color(0xFFF9FAFB),
                              fontSize: 16,
                              fontWeight: FontWeight.w400
                          ),
                        ),
                        Text( '$projectPaintType',
                          style: const TextStyle(
                              color: Color(0xFFF9FAFB),
                              fontSize: 16,
                              fontWeight: FontWeight.w400
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        const Text('Paint Color',
                          style: TextStyle(
                              color: Color(0xFFF9FAFB),
                              fontSize: 16,
                              fontWeight: FontWeight.w400
                          ),
                        ),
                        Text( '$projectPaintColor',
                          style: const TextStyle(
                              color: Color(0xFFF9FAFB),
                              fontSize: 16,
                              fontWeight: FontWeight.w400
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        const Text('Paint Finish',
                          style: TextStyle(
                              color: Color(0xFFF9FAFB),
                              fontSize: 16,
                              fontWeight: FontWeight.w400
                          ),
                        ),
                        Text( '$projectPaintFinish',
                          style: const TextStyle(
                              color: Color(0xFFF9FAFB),
                              fontSize: 16,
                              fontWeight: FontWeight.w400
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        const Text('Window Type',
                          style: TextStyle(
                              color: Color(0xFFF9FAFB),
                              fontSize: 16,
                              fontWeight: FontWeight.w400
                          ),
                        ),
                        Text( '$projectWindowType',
                          style: const TextStyle(
                              color: Color(0xFFF9FAFB),
                              fontSize: 16,
                              fontWeight: FontWeight.w400
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        const Text('Window Color',
                          style: TextStyle(
                              color: Color(0xFFF9FAFB),
                              fontSize: 16,
                              fontWeight: FontWeight.w400
                          ),
                        ),
                        Text( '$projectWindowColor',
                          style: const TextStyle(
                              color: Color(0xFFF9FAFB),
                              fontSize: 16,
                              fontWeight: FontWeight.w400
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        const Text('Window Design',
                          style: TextStyle(
                              color: Color(0xFFF9FAFB),
                              fontSize: 16,
                              fontWeight: FontWeight.w400
                          ),
                        ),
                        Text( '$projectWindowDesign',
                          style: const TextStyle(
                              color: Color(0xFFF9FAFB),
                              fontSize: 16,
                              fontWeight: FontWeight.w400
                          ),
                        ),
                      ],
                    ),
                  ),

                ],

              )
          ),
        ],
    );
  }
}
