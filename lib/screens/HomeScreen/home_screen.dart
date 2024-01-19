import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vibeforge/common/utils.dart';
import 'package:vibeforge/screens/BottomNav/NCSMusic/ncs_music_controller.dart';
import 'package:vibeforge/screens/HomeScreen/home_screen_controller.dart';
import 'package:vibeforge/screens/BottomNav/NCSMusic/ncs_mucis.dart';
import 'package:vibeforge/screens/HomeScreen/profile_page.dart';
import 'package:vibeforge/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final HomeScreenController controller = Get.put(HomeScreenController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeScreenController>(
      builder: (_) => Obx(() {
        return Container(
          decoration: boxDecor(),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: _CustomAppBar(controller: controller),
            bottomNavigationBar: _CustomNavBar(controller: controller),
            body: (() {
              switch (controller.bottomNavBarIndex.value) {
                case 0:
                  Get.delete<NCSMusicController>();
                  return const Home();
                case 1:
                  Get.delete<NCSMusicController>();
                  return Container();
                case 2:
                  Get.delete<NCSMusicController>();
                  return Container();
                case 3:
                  return NCSMusic();
                default:
                  return const Home();
              }
            })(),
          ),
        );
      }),
    );
  }

  BoxDecoration boxDecor() {
    if (controller.bottomNavBarIndex.value == 0) {
      // Return gradient for index 0
      return BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.deepPurple.shade900.withOpacity(0.8),
            Colors.deepPurple.shade300.withOpacity(0.8),
          ],
        ),
      );
    } else if (controller.bottomNavBarIndex.value == 3) {
      // Return gradient for index 3
      return BoxDecoration(
        //   gradient: LinearGradient(
        //     begin: Alignment.center,
        //     end: Alignment.bottomCenter,
        //     colors: [
        //       Colors.black.withOpacity(0.8),
        //       Colors.white.withOpacity(0.8),
        //     ],
        //   ),
        color: Colors.black,
      );
    } else {
      // Return a default gradient or any other decoration for other indices
      return BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.deepPurple.shade800.withOpacity(0.8),
            Colors.deepPurple.shade200.withOpacity(0.8),
          ],
        ),
      );
    }
  }
}

class _CustomNavBar extends StatelessWidget {
  final HomeScreenController controller;

  const _CustomNavBar({
    required this.controller,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: controller.bottomNavBarIndex == 3
          ? Colors.black
          : Colors.deepPurple.shade900,
      unselectedItemColor: Colors.white,
      selectedItemColor: Colors.white,
      showUnselectedLabels: false,
      showSelectedLabels: false,
      currentIndex: controller.bottomNavBarIndex.value,
      onTap: (index) {
        controller.bottomNavBarIndex.value = index;
      },
      items: [
        const BottomNavigationBarItem(
          icon: Icon(Icons.home_rounded),
          label: 'Home',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.favorite_outline),
          label: 'Favourites',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.play_circle_fill_outlined),
          label: 'Play',
        ),
        BottomNavigationBarItem(
          icon: Image(
            image: AssetImage(LocalAssets.ncsLogo),
            width: 50,
          ),
          label: 'NCS',
        ),
      ],
    );
  }
}

class _CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final HomeScreenController controller;

  const _CustomAppBar({
    required this.controller,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      title: controller.bottomNavBarIndex == 3
          ? Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Image(
                  image: AssetImage(LocalAssets.ncsLogo),
                  height: 25,
                ),
                const SizedBox(width: 10),
                const Text(
                  'NoCopyrightSounds',
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
              ],
            )
          : null,
      leading: Icon(
        Icons.grid_view_outlined,
        color: Colors.white.withOpacity(0.9),
      ),
      actions: [
        Container(
          margin: const EdgeInsets.only(right: 20),
          child: GestureDetector(
            onTap: () {
              controller.miniProfileUI(context);
            },
            child: CircleAvatar(
              backgroundImage: AssetImage(TestProfile.profilePic),
            ),
          ),
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}
