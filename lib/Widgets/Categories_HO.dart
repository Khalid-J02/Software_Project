import 'package:flutter/material.dart';

class CategoriesHo extends StatefulWidget {

  List<Map<String, dynamic>> categoryList ;
  final Function(String) selectedCategory ;

  CategoriesHo(
      {
        super.key,
        required this.categoryList,
        required this.selectedCategory,
      }
  );

  @override
  State<CategoriesHo> createState() => _CategoriesHoState();
}

class _CategoriesHoState extends State<CategoriesHo> {

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
            }else{
              widget.selectedCategory(widget.categoryList[index]["serviceName"]) ;
            }
          },
          child: Container(
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(
              color: selectedCategoryIndex == index ? const Color(0xFF2F4991) : Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Icon(
                    widget.categoryList[index]["Icon"],
                    size: MediaQuery.of(context).size.width > 930
                        ? 22
                        : 15,
                    color: selectedCategoryIndex == index ? Colors.white : const Color(0xFF022D6B),
                  ),
                ),
                Text(
                  widget.categoryList[index]["serviceName"],
                  style: TextStyle(
                    color: selectedCategoryIndex == index ? Colors.white : const Color(0xFF022D6B),
                    fontSize: MediaQuery.of(context).size.width > 930
                        ? 20
                        : 15,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        );
      }
    );
  }
}
