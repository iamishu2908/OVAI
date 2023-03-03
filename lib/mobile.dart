import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

import 'package:pcod/ProfilePage.dart';

Future<void> saveAndLaunchFile(List<int> bytes, String fileName) async {
  final directory = await getApplicationDocumentsDirectory();
  final path = directory.path;
  File file = File('$path/Ovai_report_$currentDate.pdf');
  await file.writeAsBytes(bytes, flush: true);
  OpenFile.open('$path/Ovai_report_$currentDate.pdf');
}
