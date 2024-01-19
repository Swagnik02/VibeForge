import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vibeforge/common/utils.dart';
import 'package:vibeforge/screens/HomeScreen/profile_page_controller.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  final ProfilePageController controller = Get.put(ProfilePageController());
  double screenHeight = Get.height;
  double screenWidth = Get.width;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfilePageController>(
      builder: (_) => Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.deepPurple.shade800.withOpacity(0.8),
                Colors.deepPurple.shade200.withOpacity(0.8),
              ],
            ),
          ),
          child: Stack(
            children: [
              // circle design
              Positioned(
                top: 0 - (screenWidth - (screenWidth / 4)),
                left: 0 - (screenWidth / 2),
                right: 0 - (screenWidth / 2),
                child: Container(
                    width: screenWidth + (screenWidth / 2),
                    height: screenWidth + (screenWidth / 2),
                    child: CircleAvatar(
                      backgroundColor: Colors.deepPurple.shade500,
                    )),
              ),

              // control buttons
              Positioned(
                top: screenWidth / 10,
                left: 0,
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () => Get.back(),
                        icon: Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: Colors.white,
                        ),
                      ),
                      IconButton(
                        onPressed: () => Get.back(),
                        icon: Transform(
                          alignment: Alignment.center,
                          transform: Matrix4.rotationY(22 / 7),
                          child: Icon(
                            Icons.sort_rounded,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),

              // Profile Pic
              Positioned(
                top: (screenWidth - (screenWidth / 2)),
                left: 0 - (150 / 2),
                right: 0 - (150 / 2),
                child: SizedBox(
                  width: 150,
                  height: 150,
                  child: CircleAvatar(
                    foregroundImage: AssetImage(
                      TestProfile.profilePic,
                    ),
                  ),
                ),
              ),

              // userName
              Positioned(
                top: (screenWidth - (screenWidth / 2) - (screenWidth / 8)),
                left: 0,
                right: 0,
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Center(
                      child: Text(
                        TestProfile.fullName,
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall!
                            .copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w400),
                      ),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
