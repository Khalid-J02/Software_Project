import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../APIRequests/serviceProviderRequestsAPI.dart';
import '../Widgets/ProjectDataDetails.dart';
import '../classes/language_constants.dart';

class ProjectDescriptionSeeDetails extends StatefulWidget {
  final String projectId;
  final String taskId;
  final String taskNumber;

  const ProjectDescriptionSeeDetails({
    Key? key,
    required this.projectId,
    required this.taskId,
    required this.taskNumber,
  }) : super(key: key);

  @override
  State<ProjectDescriptionSeeDetails> createState() =>
      _ProjectDescriptionSeeDetailsState();
}

class _ProjectDescriptionSeeDetailsState
    extends State<ProjectDescriptionSeeDetails> {
  bool _isLoading = true;
  Map<String, dynamic> projectData = {};

  List arabicTasksName = [
    "مسح الممتلكات",
    "الحصول على التصاريح والمعلومات التنظيمية",
    "فحص التربة",
    "التصميم والتخطيط",
    "الحصول على موافقة نقابة المهندسين وسلطة التراخيص",
    "بناء الأساسات",
    "الأعمال الميكانيكة",
    "الأعمال الكهربائية",
    "أعمال العزل",
    "تركيب إطارات الأبواب",
    "قصارة البيت - التجصيص -",
    "وضع البلاط",
    "أعمال الألمنيوم",
    "أعمال النجارة",
    "طلاء البيت",
    "التشطيبات النهائية",
  ];

  List englishTasksName = [
    "Property Survey",
    "Obtaining Permits & Regulatory Information",
    "Soil Investigation",
    "Design and Planning",
    "Obtaining Approval from Engineering Association & licensing Authority",
    "Foundation Construction & Framing",
    "Rough Mechanical Work",
    "Rough Electrical Work",
    "Insulation Work",
    "Door Frame Installation",
    "Plastering Work",
    "Tile Work",
    "Aluminum Work",
    "Carpentry Work",
    "Painting Work",
    "Installing Fixtures and Finishing Up",
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
    fetchProjectInformation();
  }

  Future<void> fetchProjectInformation() async {
    try {
      final fetchedProjectData =
          await RequestsAPI.getProjectDetails(widget.projectId, widget.taskId);
      setState(() {
        projectData = fetchedProjectData;
        _isLoading = false;
      });
    } catch (e) {
      // Handle errors
      print('Error fetching project information: $e');
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isRtl = (translation(context)!.localeName == 'ar');
    return Directionality(
      textDirection: translation(context)!.localeName == 'ar'
          ? TextDirection.rtl
          : TextDirection.ltr,
      child: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    color: const Color(0xFF122247),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 30),
                    //child: const Icon(Icons.edit, color: Color(0xFFF3D69B),),
                  ),
                ),
                Expanded(
                  flex: 7,
                  child: Container(
                    color: const Color(0xFF2F4771),
                    width: MediaQuery.of(context).size.width,
                    child: ProjectDataDetails(
                      projectName: projectData['projectName'] ?? '',
                      projectOwner: projectData['ownerUserName'] ?? '',
                      projectCity: projectData['projectCity'] ?? '',
                      projectLocation: projectData['projectLocation'] ?? '',
                      taskDescription: isRtl? arabicTasksDesc[int.parse(widget.taskNumber) - 1] : projectData['taskDescription']??'',
                      taskName: isRtl? arabicTasksName[int.parse(widget.taskNumber) - 1] : englishTasksName[int.parse(widget.taskNumber) - 1],
                      taskDate: projectData['taskDate'] ?? '',
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              top: MediaQuery.of(context).size.width > 930
                  ? MediaQuery.of(context).size.width / 120
                  : MediaQuery.of(context).size.width / 40,
              left: MediaQuery.of(context).size.width / 3,
              right: MediaQuery.of(context).size.width / 3,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Color(0xFFF3D69B),
                    width: 5,
                  ),
                  shape: BoxShape.circle,
                ),
                child: CircularPercentIndicator(
                    animation: true,
                    animationDuration: 1200,
                    radius: 69,
                    lineWidth: 10,
                    percent: 1.0,
                    progressColor: Color(0xFFEEAF2F),
                    backgroundColor: Color(0xFFEAD6AC),
                    circularStrokeCap: CircularStrokeCap.round,
                    center: const CircleAvatar(
                      radius: 60,
                      backgroundColor: Color(0xFF2F4771),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Icon(
                            Icons.house,
                            size: 60,
                            color: Color(0xFFF3D69B),
                          ),
                        ],
                      ),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
