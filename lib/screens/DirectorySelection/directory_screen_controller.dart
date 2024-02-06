import 'dart:developer';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';

class DirSong {
  String name;
  String path;

  DirSong({required this.name, required this.path});
}

class DirectoryScreenController extends GetxController {
  List<String> selectedFolders = [];
  List<FileSystemEntity> files = [];

  List<DirSong> songs = [];

  @override
  void onInit() {
    // TODO: implement onInit
    // _loadFiles();
  }

  void addFolder() async {
    final path = await FilePicker.platform.getDirectoryPath();
    if (path == null) {
      return;
    }

    log(path);

    selectedFolders.add(path);
    update();
    await _loadFiles(path);
  }

  Future<void> _loadFiles(String path) async {
    try {
      Directory dir = Directory(path);
      List<FileSystemEntity> fileList = dir.listSync();

      files = fileList;
      update();
    } catch (e) {
      print("Error loading files: $e");
    }
  }
}
