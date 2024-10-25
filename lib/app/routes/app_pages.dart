
import 'package:get/get.dart';
import 'package:rishta_admin/app/screens/edit/basic_information_edit.dart';
import 'package:rishta_admin/app/screens/edit/edit_profile_new.dart';
import 'package:rishta_admin/app/screens/edit/family_information_edit.dart';
import 'package:rishta_admin/app/screens/edit/required_proposal_edit.dart';
import 'package:rishta_admin/app/screens/searchProfiles/newProfilesInWeek.dart';
import 'package:rishta_admin/app/screens/searchProfiles/search_list.dart';

import '../screens/login_screen.dart';
import '../screens/main_page_all_castes.dart';
import '../screens/male_female.dart';
import '../screens/pending_requests.dart';
import '../screens/proposal_details.dart';
import '../screens/proposal_list.dart';
import '../screens/searchProfiles/search_profiles.dart';
import '../screens/splash.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH_SCREEN;
  static final routes = [
    GetPage(
      name: _Paths.SPLASH_SCREEN,
      page: () => SplashScreen(),
    ),
    GetPage(
      name: _Paths.LOGIN_SCREEN,
      page: () => LoginScreen(),
      // binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.MALE_FEMALE,
      page: () => MaleFemale(),
      // binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.ALL_CASTES_MAIN_PAGE,
      page: () => AllCastesMainPage(),
    ),
    GetPage(
      name: _Paths.PROPOSALS_LIST,
      page: () => ProposalsList(),
    ),
    GetPage(
      name: _Paths.PROPOSALS_DETAIL,
      page: () => ProposalDetails(),
    ),
    GetPage(
      name: _Paths.EDIT_PROFILE_NEW,
      page: () => EditProfileNew(),
    ),
    GetPage(
      name: _Paths.BASIC_INFORMATION_EDIT,
      page: () => BasicInformationEdit(),
    ),
    GetPage(
      name: _Paths.FAMILY_INFORMATION_EDIT,
      page: () => FamilyInformationEdit(),
    ),
    GetPage(
      name: _Paths.REQUIRED_PROPOSAL_EDIT,
      page: () => RequiredProposalEdit(),
    ),
    GetPage(
      name: _Paths.SEARCH_PROFILES,
      page: () => SearchProfiles(),
    ),
    GetPage(
      name: _Paths.SEARCH_LIST,
      page: () => SearchList(),
    ),
    GetPage(
      name: _Paths.PENDING_REQUESTS,
      page: () => PendingRequests(),
    ),
    GetPage(
      name: _Paths.NEW_PROFILES,
      page: () => NewProfilesInWeek(),
    ),
    // GetPage(
    //   name: _Paths.BASIC_INFORMATION,
    //   page: () => BasicInformation(),
    // ),
  ];
}
