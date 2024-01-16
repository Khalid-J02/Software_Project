import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StatsCategories extends StatefulWidget {

  List<Map<String, dynamic>> categoryList ;
  final Function(String) selectedCategory ;

  StatsCategories(
      {
        super.key,
        required this.categoryList,
        required this.selectedCategory
      }
  );

  @override
  State<StatsCategories> createState() => _StatsCategoriesState();
}

class _StatsCategoriesState extends State<StatsCategories> {
  int selectedCategoryIndex = -1 ;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.categoryList.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: (){
              setState(() {
                if(selectedCategoryIndex == index){
                  selectedCategoryIndex = -1 ;
                }
                else{
                  selectedCategoryIndex = index ;
                }
              });

              if(selectedCategoryIndex == -1){
                widget.selectedCategory('') ;
              }
              else{
                widget.selectedCategory(widget.categoryList[index]["serviceName"]) ;
              }
            },
            child: Column(
              children: [
                Container(
                  width: 90,
                  height: 75,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: selectedCategoryIndex == index ? widget.categoryList[index]["IconColor"] : widget.categoryList[index]["backgroundColor"],
                    border: Border.all(
                      width: 1.5,
                      color: selectedCategoryIndex == index ? widget.categoryList[index]["backgroundColor"] : widget.categoryList[index]["IconColor"],
                    ),
                  ),
                  child: Center(
                    child: Icon(
                      widget.categoryList[index]["Icon"],
                      size: 35,
                      color: selectedCategoryIndex == index ? widget.categoryList[index]["backgroundColor"] : widget.categoryList[index]["IconColor"] ,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 6),
                  child: Text(
                    widget.categoryList[index]["serviceName"],
                    style: const TextStyle(
                      color: Color(0xFF022D6B),
                      fontWeight: FontWeight.w400,
                      fontSize: 15
                    ),
                  ),
                ),
              ],
            ),
          );
        }
    );
  }
}
