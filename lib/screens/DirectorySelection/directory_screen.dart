import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vibeforge/common/utils.dart';
import 'package:vibeforge/screens/DirectorySelection/directory_screen_controller.dart';

class DirectoryScreen extends StatelessWidget {
  DirectoryScreen({super.key});

  final DirectoryScreenController controller =
      Get.put(DirectoryScreenController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DirectoryScreenController>(
      builder: (_) => Container(
        decoration: boxDecor(),
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Scan Media',
              style: TextStyle(
                color: Colors.purpleAccent.shade400,
              ),
            ),
            backgroundColor: Colors.transparent,
            leading: IconButton(
              onPressed: Get.back,
              icon: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Colors.purpleAccent.shade400,
              ),
            ),
          ),
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          body: _mainBody(),
        ),
      ),
    );
  }

  // Background Gradient Colour

  BoxDecoration boxDecor() {
    return BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          ColorConstants.themeColourShade3,
          ColorConstants.themeColourShade2,
          ColorConstants.themeColourShade1,
        ],
      ),
    );
  }

  Widget _mainBody() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () => controller.addFolder(),
          child: Text('Add Folder'),
        ),

        // Display the added folders
        Text('Display the added folders'),
        for (String folder in controller.selectedFolders)
          ListTile(
            title: Text(folder, style: TextStyle(color: Colors.white)),
          ),

        Expanded(
          child: ListView.builder(
            itemCount: controller.files.length,
            itemBuilder: (context, index) {
              return ListTile(
                  title: Text(
                    controller.files[index].uri.pathSegments.last,
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () => controller.playAudioFile(index));
            },
          ),
        )
      ],
    );
  }
}
