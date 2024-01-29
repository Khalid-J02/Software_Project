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
    "1. مسح الممتلكات",
    "2. الحصول على التصاريح والمعلومات التنظيمية",
    "3. فحص التربة",
    "4. التصميم والتخطيط",
    "5. الحصول على موافقة نقابة المهندسين وسلطة التراخيص",
    "6. بناء الأساسات",
    "7. الأعمال الميكانيكة",
    "8. الأعمال الكهربائية",
    "9. أعمال العزل",
    "10. تركيب إطارات الأبواب",
    "11. قصارة البيت - التجصيص -",
    "12. وضع البلاط",
    "13. أعمال الألمنيوم",
    "14. أعمال النجارة",
    "15. طلاء البيت",
    "16. التشطيبات النهائية",
  ];

  List arabicTasksDesc = [
    "مسح الأرض أمر ضروري قبل بناء المنزل لتحديد حدود الملكية بدقة. يشمل استخدام معدات متخصصة وتقنيات لتحديد مواقع النقاط والمسافات والزوايا. حيث يقوم المساحون المرخصون  بهذا العمل.",
    "يتم في هذه الخطوة تقديم مخطط المساحة إلى وزارة السياحة والآثار ثم إلى سلطة الأراضي، حيث يتم الحصول على الموافقات المطلوبة منهما. ثم التوجه إلى جهة الترخيص للحصول على المعلومات التنظيمية.",
    "يعد فحص التربة خطوة حيوية في البناء حيث يتضمن هذا الإجراء فحص التركيب الكيميائي والفيزيائي للتربة لتحديد قدرتها الاستيعابية، وهو أمر ضروري لتقييم قدرتها على تحمل وزن البناء.",
    "في نهاية هذه المرحلة، يتم الحصول على مخططات البناء الأساسية : المعمارية والمدنية والميكانيكية والكهربائية.",
    "تشمل رحلة الموافقة على المخططات المعمارية والمدنية والميكانيكية والكهربائية عملية دقيقة من خطوتين، الأولى : الحصول على الموافقات من قبل نقابة المهندسين، والثانية: الحصول على الموافقات من جهة التراخيص على المخططات التي تم الموافقة عليها من قبل نقابة المهندسين.",
    "يبدأ البناء بإنشاء الأساسات والهياكل الإنشائية وفقاً للخطط الموافق عليها، مما يوفر الأساس الثابت والمتين للمبنى.",
    "الأعمال الميكانيكية تتطلب دقة وتخطيطاً محكماً، حيث يتبع السباكون المخططات التفصيلية لضمان تركيب نظام المياه بشكل متقن.",
    "تتمثل الأعمال الكهربائية في وضع التمديدات الكهربائية بشكل صحيح وفقاً للمخططات، مع التأكيد على السلامة والكفاءة.",
    "يعد عمل العزل - إذا تم اختياره- أمرًا حيويًا، حيث يسهم في تنظيم درجة حرارة المنزل، بالإضافة لمنع تسريبات المياه والرطوبة.",
    "في هذه المرحلة يقوم الحرفيون الماهرون بتركيب إطارات الأبواب وفقًا للخطط المعمارية، مما يضمن تناسب الأبواب بشكل متناغم مع المساحات المعيشية، مع التركيز على القياسات الدقيقة.",
    "في هذه المرحلة يقوم الحرفيون الماهرون بأعمال التجصيص -القصارة-  التي تعزز جمالية المبنى، حيث تجعل ملمس الجدران والأسقف ملساً ومتناسقاً.",
    "أعمال البلاط تضمن تنفيذ الرؤية المعمارية بمهارة ودقة، مع الحرص على محاذاة البلاط وتثبيته بشكل متقن.",
    "أعمال الألمنيوم تضمن تركيب النوافذ على حسب المواصفات التي قام صاحب المنزل باختيارها.",
    "أعمال النجارة تضمن تركيب الأبواب والمستلزمات الخشيبة على حسب المواصفات التي قام صاحب المنزل باختيارها.",
    "مرحلة الطلاء تتيح لأصحاب المنازل اختيار الألوان والأنواع واللمسات النهائية التي تعبر عن ذوقهم الشخصي، ويطبق الدهانون المتمرسون هذه الطلبات.",
    "تتم التشطبيات النهائية في هذه المرحلة، كمالك منزل، ستختار مثلًا ما تحتاجه من أدوات الإضاءة والصنابير ومقابض الخزائن التي تتوافق مع أسلوبك واحتياجاتك، مما يشكل الجو النهائي لمساحتك المعيشية الجديدة..",
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
                    taskDescription: translation(context)!.localeName == 'ar' ? arabicTasksDesc[index] :userProjectTasks[index]["TaskDescription"]?.toString() ?? 'Default Description',
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
