import 'package:buildnex/Widgets/ProjectTasks.dart';
import 'package:buildnex/classes/language_constants.dart';
import 'package:flutter/material.dart';
import '../APIRequests/NavbarProjectPageHomeOwnerAPI.dart';

class ProjectTasksHomeOwner extends StatefulWidget {
  final String projectId;

  const ProjectTasksHomeOwner({
    Key? key,
    required this.projectId,
  }) : super(key: key);

  @override
  State<ProjectTasksHomeOwner> createState() => _ProjectTasksHomeOwnerState();
}

class _ProjectTasksHomeOwnerState extends State<ProjectTasksHomeOwner> {
  List<Map<String, dynamic>> userProjectTasks = [];
  bool isLoading = true; // Track whether tasks are being loaded

  List arabicTasksName = [
    "مسح الممتلكات",
    "الحصول على التصاريح والمعلومات التنظيمية",
    "فحص التربة",
    "التصميم والتخطيط",
    "الحصول على موافقة نقابة المهندسين وسلطة الترخيص",
    "بناء الأساسات",
    "تركيب إمدادات المياه",
    "تركيب إمدادات الكهرباء",
    "تركيب إمدادات المياه",
    "العزل وتركيب التدفئة والتهوية وتكييف الهواء",
    "تركيب إطارات الأبواب",
    "قصارة البيت - التجصيص -",
    "تركيب البلاط",
    "تركيب النوافذ",
    "تركيب الأبواب",
    "طلاء البيت",
  ];

  @override
  void initState() {
    super.initState();
    fetchTasks(widget.projectId);
  }

  Future<void> fetchTasks(String projectId) async {
    try {
      final fetchedTasks =
      await HomeOwnerProjectPageNavbarAPI.getProjectTasks(projectId);

      if(translation(context)!.localeName == 'ar'){
        translateStatusToArabic(fetchedTasks);
      }

      setState(() {
        userProjectTasks = fetchedTasks;
        isLoading = false; // Set loading to false when tasks are loaded
      });

    } catch (e) {
      // Handle errors
      print('Error fetching tasks: $e');
      setState(() {
        isLoading = false; // Set loading to false even in case of an error
      });
    }
  }

  void translateStatusToArabic(List list){
    for(int index = 0 ; index < list.length ; index++){
      if(list[index]["TaskStatus"]! == 'Not Started'){
        list[index]["TaskStatus"] = 'لم تبدأ' ;
      }
      else if(list[index]["TaskStatus"]! == 'In Progress'){
        list[index]["TaskStatus"] = 'قيد التنفيذ' ;
      }
      else{
        list[index]["TaskStatus"] = 'مكتملة' ;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: translation(context)!.localeName == 'ar' ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        body: SafeArea(
          child: Container(
            color: Color(0xFF2F4771),
            child: isLoading
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
              itemCount: userProjectTasks.length,
              itemBuilder: (context, index) {
                if(translation(context)!.localeName == 'ar'){
                  translateStatusToArabic(userProjectTasks);
                }
                return ProjectTasks(
                    taskProjectId: widget.projectId,
                    taskID: userProjectTasks[index]["TaskID"].toString(),
                    taskName: translation(context)!.localeName == 'ar' ? arabicTasksName[index] : userProjectTasks[index]["TaskName"]!,
                    taskDescription: userProjectTasks[index]["TaskDescription"]?.toString() ?? 'Default Description',
                    taskStatus: userProjectTasks[index]["TaskStatus"]!,
                    taskNumber: userProjectTasks[index]["TaskNumber"].toString(),
                    serviceProviderID: userProjectTasks[index]["ServiceProviderID"]?.toString() ?? 'No Provider ID',
                    serviceProviderName:  userProjectTasks[index]["ServiceProviderName"].toString() ?? 'No Provider Name'
                );
              },
            ),
          ),
        ),
      ),
    ) ;
  }
}
