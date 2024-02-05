import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vibeforge/common/utils.dart';
import 'package:vibeforge/models/user_model.dart';
import 'package:vibeforge/screens/HomeScreen/profile_page_controller.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  final ProfilePageController controller = Get.put(ProfilePageController());
  final double screenHeight = Get.height;
  final double screenWidth = Get.width;
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
                        icon: const Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: Colors.white,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Transform(
                          alignment: Alignment.center,
                          transform: Matrix4.rotationY(22 / 7),
                          child: const Icon(
                            Icons.sort_rounded,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
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
                      UserDataService().user?.userName ?? 'UserName',
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(
                              color: Colors.white, fontWeight: FontWeight.w400),
                    ),
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
                    backgroundColor: ColorConstants.themeColour,
                    child: ClipOval(
                      child: Image.asset(
                        LocalAssets.avatar,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),

              // Details Column
              Positioned(
                top: (screenWidth - (screenWidth / 12)),
                left: 0,
                right: 0,
                child: Container(
                  height: screenHeight / 3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 50, vertical: 5),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.deepPurple.shade200,
                                border: Border.all(),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: TextField(
                                enabled: false,
                                controller: controller.emailController,
                                style: const TextStyle(color: Colors.white),
                                textAlign: TextAlign.center,
                                keyboardType: TextInputType.emailAddress,
                                decoration: const InputDecoration(
                                  hintText: 'E-mail',
                                  border: InputBorder.none,
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 30),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 50, vertical: 5),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.deepPurple.shade200,
                                border: Border.all(),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: TextField(
                                enabled: false,
                                controller: controller.mobileController,
                                style: const TextStyle(color: Colors.white),
                                textAlign: TextAlign.center,
                                keyboardType: TextInputType.phone,
                                decoration: const InputDecoration(
                                  hintText: 'Mobile',
                                  border: InputBorder.none,
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 30),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      // edit button

                      Row(
                        children: [
                          Expanded(
                              child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 50.0),
                            child: TextButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                  Colors.deepPurple.shade500,
                                ),
                              ),
                              onPressed: () => controller.editWindow(),
                              child: Text(
                                'Edit',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall!
                                    .copyWith(
                                      color: Colors.deepPurple.shade100,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ),
                          )),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
