import 'package:connection_notifier/connection_notifier.dart';
import 'package:edu_pro/provider/announcements_provider.dart';
import 'package:edu_pro/provider/card_provider.dart';
import 'package:edu_pro/provider/grade_system_provider.dart';
import 'package:edu_pro/provider/login_provider.dart';
import 'package:edu_pro/provider/survey_provider.dart';
import 'package:edu_pro/view/announcements.dart';
import 'package:edu_pro/view/attendance/attendance.dart';
import 'package:edu_pro/view/complaints/complaints.dart';
import 'package:edu_pro/view/complaints/update_complain.dart';
import 'package:edu_pro/view/e_services/e_services.dart';
import 'package:edu_pro/view/e_services/show_e_services.dart';
import 'package:edu_pro/view/faculty_material/faculty_information.dart';
import 'package:edu_pro/view/faculty_material/grade_system.dart';
import 'package:edu_pro/view/faculty_material/home_curriculum.dart';
import 'package:edu_pro/view/home.dart';
import 'package:edu_pro/view/registration_fessInformation/registration_details.dart';
import 'package:edu_pro/view/universities.dart';
import 'package:edu_pro/view_models/activity_view_model.dart';
import 'package:edu_pro/view/library/borrowed_library.dart';
import 'package:edu_pro/view/library/digital_library.dart';
import 'package:edu_pro/view/library/library.dart';
import 'package:edu_pro/view/login_home.dart';
import 'package:edu_pro/view/my_activties/coming.dart';
import 'package:edu_pro/view/my_activties/current.dart';
import 'package:edu_pro/view/my_activties/search.dart';
import 'package:edu_pro/view/news&events/coming.dart';
import 'package:edu_pro/view/news&events/current.dart';
import 'package:edu_pro/view/news&events/events_more.dart';
import 'package:edu_pro/view/news&events/search.dart';
import 'package:edu_pro/view/restrictions.dart';
import 'package:edu_pro/view/results.dart';
import 'package:edu_pro/view/staff_directory.dart';
import 'package:edu_pro/view/timetable/lecture_timetable.dart';
import 'package:edu_pro/view/timetable/timetable.dart';
import 'package:edu_pro/view_models/academic_view_model.dart';
import 'package:edu_pro/view_models/attendance_view_model.dart';
import 'package:edu_pro/view_models/complain_view_model.dart';
import 'package:edu_pro/view_models/curriculum_view_model.dart';
import 'package:edu_pro/view_models/drawar_view_model.dart';
import 'package:edu_pro/view_models/e_services_type_view_model.dart';
import 'package:edu_pro/view_models/e_services_view_model.dart';
import 'package:edu_pro/view_models/exams_view_model.dart';
import 'package:edu_pro/view_models/fees_view_model.dart';
import 'package:edu_pro/view_models/grade_system_mark_view_model.dart';
import 'package:edu_pro/view_models/grade_system_no_view_model.dart';
import 'package:edu_pro/view_models/lecture_timetable_view_model.dart';
import 'package:edu_pro/view_models/library/books_view_model.dart';
import 'package:edu_pro/view_models/library/library_brrowed_view_model.dart';
import 'package:edu_pro/view_models/news_view_model.dart';
import 'package:edu_pro/view_models/profile_view_model.dart';
import 'package:edu_pro/view_models/library/publications_view_model.dart';
import 'package:edu_pro/view_models/registration_view_model.dart';
import 'package:edu_pro/view_models/restrictions_view_model.dart';
import 'package:edu_pro/view_models/results/semester_view_model.dart';
import 'package:edu_pro/view_models/subject_view_model.dart';
import 'package:flutter/material.dart';

import 'provider/faculty_info_provider.dart';
import 'provider/user_provider.dart';
import 'view/complaints/add_complaints.dart';
import 'view/complaints/my_complaints.dart';
import 'view/complaints/report_complaints.dart';
import 'view/e_services/add_request.dart';
import 'view/e_services/show_e_services_more_details.dart';
import 'view/faculty_material/curriculum.dart';
import 'view/faculty_material/Course_specification.dart';
import 'view/faculty_material/planning_study.dart';
import 'view/faculty_material/program_structure.dart';
import 'view/intro_screen.dart';
import 'view/my_activties/activities.dart';
import 'view/attendance/attendance_more.dart';
import 'view/calender.dart';
import 'view/card_information.dart';
import 'view/faculty_material/faculty_material.dart';
import 'view/fees_information.dart';
import 'view/medical_profile.dart';
import 'view/my_profile/my_profile.dart';
import 'view/my_profile/my_profile_detail.dart';
import 'view/news&events/news&events.dart';
import 'view/news&events/news_search.dart';
import 'view/registration.dart';
import 'view/surveys.dart';
import 'view/timetable/exame_timetable.dart';
import 'view/my_profile/update_profile.dart';
import 'package:provider/provider.dart';

import 'view_models/calnder_view_model.dart';
import 'view_models/results/result_view_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginProvider()),
        ChangeNotifierProvider(create: (_) => CardProvider()),
        ChangeNotifierProvider(create: (_) => FacultyInfoProvider()),
        ChangeNotifierProvider(create: (_) => SurveyProvider()),
        ChangeNotifierProvider(create: (_) => AnnouncementsProvider()),
        ChangeNotifierProvider(create: (_) => GradeSystemProvider()),
        ChangeNotifierProvider(create: (_) => CalenderViewModel()),
        ChangeNotifierProvider(create: (_) => NewsViewModel()),
        ChangeNotifierProvider(create: (_) => SemesterViewModel()),
        ChangeNotifierProvider(create: (_) => ResultViewModel()),
        ChangeNotifierProvider(create: (_) => AcademicViewModel()),
        ChangeNotifierProvider(create: (_) => FeesViewModel()),
        ChangeNotifierProvider(create: (_) => ProfileViewModel()),
        ChangeNotifierProvider(create: (_) => LibraryBorrowViewModel()),
        ChangeNotifierProvider(create: (_) => PublicationsViewModel()),
        ChangeNotifierProvider(create: (_) => BooksViewModel()),
        ChangeNotifierProvider(create: (_) => ComplainViewModel()),
        ChangeNotifierProvider(create: (_) => RestrictionsViewModel()),
        ChangeNotifierProvider(create: (_) => AttendanceViewModel()),
        ChangeNotifierProvider(create: (_) => SubjectAttendanceViewModel()),
        ChangeNotifierProvider(create: (_) => LectureTimetableViewModel()),
        ChangeNotifierProvider(create: (_) => ExamsViewModel()),
        ChangeNotifierProvider(create: (_) => ActivityViewModel()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => GradeSystemNoViewModel()),
        ChangeNotifierProvider(create: (_) => GradeSystemMarkViewModel()),
        ChangeNotifierProvider(create: (_) => EServicesViewModel()),
        ChangeNotifierProvider(create: (_) => EServicesTypeViewModel()),
        ChangeNotifierProvider(create: (_) => RegistrationViewModel()),
        ChangeNotifierProvider(create: (_) => DrawerViewModel()),
        ChangeNotifierProvider(create: (_) => CurriculumViewModel()),
      ],
      child: ConnectionNotifier(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Student Portal',
          theme: ThemeData(
            colorScheme: ColorScheme(
              primary: Color(0xff095BA4),
              onPrimary: Colors.black,
              primaryVariant: Color(0xff4CB3F2),
              background: Color(0xff868C8F),
              onBackground: Colors.black,
              secondary: Color(0xff095BA4),
              onSecondary: Colors.white,
              secondaryVariant: Colors.black87,
              error: Colors.red,
              onError: Colors.orange.shade200,
              surface: Colors.white,
              onSurface: Colors.black54,
              brightness: Brightness.light,
            ),
          ),
          home: SplashScreenPage(),
          routes: {
            Home.routeName: (ctx) => Home(),
            FacultyMaterial.routeName: (ctx) => FacultyMaterial(),
            MedicalProfile.routeName: (ctx) => MedicalProfile(),
            FeesInformation.routeName: (ctx) => FeesInformation(),
            CardInformation.routeName: (ctx) => CardInformation(),
            Library.routeName: (ctx) => Library(),
            Timetable.routeName: (ctx) => Timetable(),
            Restrictions.routeName: (ctx) => Restrictions(),
            StaffDirectory.routeName: (ctx) => StaffDirectory(),
            Complaints.routeName: (ctx) => Complaints(),
            MyProfile.routeName: (ctx) => MyProfile(),
            MyProfileDetail.routeName: (ctx) => MyProfileDetail(),
            UpdateProfile.routeName: (ctx) => UpdateProfile(),
            DigitalLibrary.routeName: (ctx) => DigitalLibrary(),
            BorrowedLibrary.routeName: (ctx) => BorrowedLibrary(),
            LectureTimetable.routeName: (ctx) => LectureTimetable(),
            ExameTimetable.routeName: (ctx) => ExameTimetable(),
            Calender.routeName: (ctx) => Calender(),
            Attendance.routeName: (ctx) => Attendance(),
            Results.routeName: (ctx) => Results(),
            Activities.routeName: (ctx) => Activities(),
            Announcements.routeName: (ctx) => Announcements(),
            News.routeName: (ctx) => News(),
            Surveys.routeName: (ctx) => Surveys(),
            AttendanceMore.routeName: (ctx) => AttendanceMore(),
            CurrentNews.routeName: (ctx) => CurrentNews(),
            CurrentActivities.routeName: (ctx) => CurrentActivities(),
            ComingNews.routeName: (ctx) => ComingNews(),
            ComingActivities.routeName: (ctx) => ComingActivities(),
            SearchNews.routeName: (ctx) => SearchNews(),
            SearchActivities.routeName: (ctx) => SearchActivities(),
            EventsMore.routeName: (ctx) => EventsMore(),
            FacultyInformation.routeName: (ctx) => FacultyInformation(),
            GradeSystem.routeName: (ctx) => GradeSystem(),
            ReportComplaints.routeName: (ctx) => ReportComplaints(),
            MyComplaints.routeName: (ctx) => MyComplaints(),
            LoginHome.routeName: (ctx) => LoginHome(),
            AddComplaints.routeName: (ctx) => AddComplaints(),
            UpdateComplaints.routeName: (ctx) => UpdateComplaints(),
            NewsSearch.routeName: (ctx) => NewsSearch(),
            EServices.routeName: (ctx) => EServices(),
            ShowEServices.routeName: (ctx) => ShowEServices(),
            ShowEServicesMoreDetails.routeName: (ctx) =>
                ShowEServicesMoreDetails(),
            AddRequest.routeName: (ctx) => AddRequest(),
            Registration.routeName: (ctx) => Registration(),
            RegistrationDetails.routeName: (ctx) => RegistrationDetails(),
            Universities.routeName: (ctx) => Universities(),
            Curriculum.routeName: (ctx) => Curriculum(),
            CourseSpecification.routeName: (ctx) => CourseSpecification(),
            HomeCurriculum.routeName: (ctx) => HomeCurriculum(),
            ProgramStructure.routeName: (ctx) => ProgramStructure(),
            PlanningStudy.routeName: (ctx) => PlanningStudy(),
          },
        ),
      ),
    );
  }
}
