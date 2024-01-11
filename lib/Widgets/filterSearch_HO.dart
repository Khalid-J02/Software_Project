import 'package:buildnex/Widgets/ratingBar_ServiceProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FilterSearch extends StatefulWidget {

  int filterRating ;
  int filterMinWage ;
  int filterMaxWage ;
  String filterSPLocation ;
  String activeCategory ;

  FilterSearch(
      {
        super.key,
        required this.activeCategory,
        required this.filterRating,
        required this.filterSPLocation,
        required this.filterMinWage,
        required this.filterMaxWage
      }
  );

  @override
  State<FilterSearch> createState() => _FilterSearchState();
}

class _FilterSearchState extends State<FilterSearch> {

  String projectCity = "Choose City" ;
  late RangeValues priceValues = RangeValues(0 , 1);
  @override
  void initState() {
    super.initState();

    priceValues = RangeValues(widget.filterMinWage.toDouble() , widget.filterMaxWage.toDouble()) ;
  }

  ButtonStyle ElevatedButtonStyle(){
    return ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Color(0xFF6781A6)),
        elevation: MaterialStateProperty.all(0),
        side: MaterialStateProperty.all(BorderSide(color: Color(0xFFF3D69B), width: 1)),
        alignment: Alignment.center
    ) ;
  }

  TextStyle ElevatedButtonTextStyle(){
    return TextStyle(
        color: Color(0xFFF3D69B),
        fontSize: 16,
        fontWeight: FontWeight.normal
    );
  }

  void chooseCityBottomSheet(){
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context){
          return Container(
            color: Color(0xFF2F4771),
            height: MediaQuery.of(context).size.height/3,
            child: Center(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    width: 120,
                    child: ElevatedButton(
                      onPressed: (){
                        setState(() {
                          projectCity = "Nablus" ;
                          widget.filterSPLocation = projectCity ;
                        });
                        Navigator.pop(context);
                      },
                      style: ElevatedButtonStyle(),
                      child: Text("Nablus" , style: ElevatedButtonTextStyle(),),
                    ),
                  ),
                  SizedBox(
                    width: 120,
                    child: ElevatedButton(
                      onPressed: (){
                        setState(() {
                          projectCity = "Ramallah" ;
                          widget.filterSPLocation = projectCity ;
                        });
                        Navigator.pop(context);
                      },
                      style: ElevatedButtonStyle(),
                      child: Text("Ramallah" , style: ElevatedButtonTextStyle()),
                    ),
                  ),
                  SizedBox(
                    width: 120,
                    child: ElevatedButton(
                      onPressed: (){
                        setState(() {
                          projectCity = "Tulkarm" ;
                          widget.filterSPLocation = projectCity ;
                        });
                        Navigator.pop(context);
                      },
                      style: ElevatedButtonStyle(),
                      child: Text("Tulkarm" , style: ElevatedButtonTextStyle()),
                    ),
                  ),
                  SizedBox(
                    width: 120,
                    child: ElevatedButton(
                      onPressed: (){
                        setState(() {
                          projectCity = "Qalqilya" ;
                          widget.filterSPLocation = projectCity ;
                        });
                        Navigator.pop(context);
                      },
                      style: ElevatedButtonStyle(),
                      child: Text("Qalqilya" , style: ElevatedButtonTextStyle()),
                    ),
                  ),
                  SizedBox(
                    width: 120,
                    child: ElevatedButton(
                      onPressed: (){
                        setState(() {
                          projectCity = "Jenin" ;
                          widget.filterSPLocation = projectCity ;
                        });
                        Navigator.pop(context);
                      },
                      style: ElevatedButtonStyle(),
                      child: Text("Jenin" , style: ElevatedButtonTextStyle()),
                    ),
                  ),
                  SizedBox(
                    width: 120,
                    child: ElevatedButton(
                      onPressed: (){
                        setState(() {
                          projectCity = "Jericho" ;
                          widget.filterSPLocation = projectCity ;
                        });
                        Navigator.pop(context);
                      },
                      style: ElevatedButtonStyle(),
                      child: Text("Jericho" , style: ElevatedButtonTextStyle()),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
    );
  }

  void savedData(){
    List<String> data = [
      widget.filterRating.toString(),
      (priceValues.start.toInt()).toString(),
      priceValues.end.toInt().toString(),
      widget.filterSPLocation,
    ];
    Navigator.of(context).pop(data);
  }

  @override
  Widget build(BuildContext context) {

    RangeLabels priceLabels = RangeLabels(priceValues.start.toString(), priceValues.end.toString()) ;

    return AlertDialog(
      backgroundColor: Color(0xFF2F4771),
      content: Container(
        height: MediaQuery.of(context).size.height / 2.2,
        width: 350,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: Text("Filter Your Search",
                style: TextStyle(
                    fontSize: 25,
                    color: Color(0xFFF3D69B)
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: Text(
                      "Rating: ",
                      style: TextStyle(
                          color: Color(0xFFF9FAFB),
                          fontSize: 20
                      ),
                    ),
                  ),
                  SizedBox( height: 8,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RatingBarSB(rating: widget.filterRating.toDouble() , size: 25,),
                      Row(
                        children: [
                          Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                              color: const Color(0xFFF9FAFB),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 3,
                                  blurRadius: 12,
                                  offset: const Offset(0,3),
                                )
                              ]),
                            child: IconButton(
                              onPressed: (){
                                setState(() {
                                  if(widget.filterRating == 1){
                                    widget.filterRating = 1 ;
                                  }
                                  else{
                                    widget.filterRating = widget.filterRating - 1 ;
                                  }
                                });
                              },
                              icon: const Icon(CupertinoIcons.minus , size: 15, color: Color(0xFF022D6B),),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              widget.filterRating.toString(),
                              style: const TextStyle(
                                color: Color(0xFFF9FAFB),
                                fontSize: 20,
                                fontWeight: FontWeight.w400
                              ),
                            ),
                          ),
                          Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                                color: const Color(0xFFF9FAFB),
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 3,
                                    blurRadius: 12,
                                    offset: const Offset(0,3),
                                  )
                                ]),
                            child: IconButton(
                              onPressed: (){
                                setState(() {
                                  if(widget.filterRating == 5){
                                    widget.filterRating = 5 ;
                                  }
                                  else{
                                    widget.filterRating = widget.filterRating + 1 ;
                                  }
                                });
                              },
                              icon: const Icon(Icons.add ,size: 15, color: Color(0xFF022D6B),),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 15,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    "Price:",
                    style: TextStyle(
                      color: Color(0xFFF9FAFB),
                      fontSize: 20
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: RangeSlider(
                    values: priceValues,
                    labels: priceLabels,
                    divisions: 10  ,
                    min: widget.filterMinWage.toDouble(),
                    max: widget.filterMaxWage.toDouble(),
                    activeColor: Color(0xFFF9FAFB),
                    onChanged: (newValue) {
                      priceValues = newValue ;
                      setState(() {
                      });
                    },

                  ),
                ),
                SizedBox(height: 10,),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    "Provider City:",
                    style: TextStyle(
                        color: Color(0xFFF9FAFB),
                        fontSize: 20
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0 , right: 8.0 , top: 8.0 , bottom: 12.0),
                  child: Container(
                    width: 270,
                    height: 55,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: ElevatedButton(
                      onPressed: chooseCityBottomSheet,
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Color(0xFF6781A6)),
                          elevation: MaterialStateProperty.all(0),
                          side: MaterialStateProperty.all(BorderSide(color: Color(0xFFF3D69B), width: 1)),
                          alignment: Alignment.centerLeft
                      ),
                      child: Text(projectCity,
                        style: const TextStyle(
                            color: Color(0xFFF3D69B),
                            fontSize: 16,
                            fontWeight: FontWeight.normal
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top : 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    width: 100,
                    padding: MediaQuery.of(context).size.width > 930
                        ?
                    EdgeInsets.symmetric(vertical: 10)
                        :
                    EdgeInsets.zero ,
                    decoration: const BoxDecoration(
                      color: Color(0xFFF3D69B),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    child: TextButton(
                      onPressed: savedData,
                      child: const Text(
                        'Save',
                        style: TextStyle(
                          fontSize: 20,
                          color: Color(0xFF122247),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 100,
                    padding: MediaQuery.of(context).size.width > 930
                        ?
                    EdgeInsets.symmetric(vertical: 10)
                        :
                    EdgeInsets.zero ,
                    decoration: const BoxDecoration(
                      color: Color(0xFFF3D69B),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Cancel',
                        style: TextStyle(
                          fontSize: 20,
                          color: Color(0xFF122247),
                        ),
                      ),
                    ),
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
