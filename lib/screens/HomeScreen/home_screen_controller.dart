import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vibeforge/common/utils.dart';
import 'package:vibeforge/models/user_model.dart';
import 'package:vibeforge/screens/ProfileScreen/profile_page.dart';
import 'package:vibeforge/services/auth_service.dart';

class HomeScreenController extends GetxController {
  var bottomNavBarIndex = 0.obs;
  RxString text = 'VibeForge'.obs;

  @override
  void onInit() {
    super.onInit();
    Timer(const Duration(seconds: 8), () {
      text.value = '';
    });
  }
  // MiniProfile

  void miniProfileUI(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double paddingLength = ((screenHeight / 5) - (screenHeight / 6)) / 2;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor:
              bottomNavBarIndex.obs == 3.obs ? Colors.black : Colors.white,
          content: Container(
            height: screenHeight / 3.6,
            child: Stack(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      child: Icon(
                        Icons.edit_outlined,
                        color: bottomNavBarIndex.obs == 3.obs
                            ? Colors.grey
                            : Colors.deepPurple,
                      ),
                      onTap: () => Get.to(() => ProfilePage()),
                    ),
                    InkWell(
                      child: Icon(
                        Icons.logout,
                        color: bottomNavBarIndex.obs == 3.obs
                            ? Colors.grey
                            : Colors.deepPurple,
                      ),
                      onTap: () => AuthService().signOut(),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: screenHeight / 5,
                      width: screenHeight / 5,
                      child: CircleAvatar(
                        backgroundColor: bottomNavBarIndex.obs == 3.obs
                            ? Colors.grey
                            : Colors.deepPurple,
                        // backgroundImage: AssetImage(TestProfile.profilePic),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: paddingLength),
                      child: SizedBox(
                        height: screenHeight / 6,
                        width: screenHeight / 6,
                        child: CircleAvatar(
                          backgroundImage: AssetImage(TestProfile.profilePic),
                        ),
                      ),
                    ),
                    SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Text(
                              UserDataService().user?.userName ?? '',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall!
                                  .copyWith(
                                      color: bottomNavBarIndex.obs == 3.obs
                                          ? Colors.grey
                                          : Colors.deepPurple,
                                      fontWeight: FontWeight.bold),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
