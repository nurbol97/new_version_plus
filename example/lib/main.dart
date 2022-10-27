import 'package:flutter/material.dart';
import 'package:new_version_plus/new_version_plus.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();

    // Instantiate NewVersion manager object (Using GCP Console app as example)
    final newVersion = NewVersionPlus();

    // You can let the plugin handle fetching the status and showing a dialog,
    // or you can fetch the status and display your own dialog, or no dialog.
    const simpleBehavior = true;
    advancedStatusCheck(newVersion);
    // if (simpleBehavior) {
    //   basicStatusCheck(newVersion);
    // }
    // else {
    //   advancedStatusCheck(newVersion);
    // }
  }

  basicStatusCheck(NewVersionPlus newVersion) {
    newVersion.showAlertIfNecessary(context: context);
  }

  advancedStatusCheck(NewVersionPlus newVersion) async {
    final status = await newVersion.getVersionStatus();
    if (status != null) {
      debugPrint(status.releaseNotes);
      debugPrint(status.appStoreLink);
      debugPrint(status.localVersion);
      debugPrint(status.storeVersion);
      debugPrint(status.canUpdate.toString());
      newVersion.showUpdateDialog(
        context: context,
        versionStatus: status,
        allowDismissal: false,
        dialogTitle: Column(
          children: [
            SvgPicture.asset(
              'assets/info_square.svg',
              width: 36.67,
              height: 36.67,
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Обновление доступно',
              style: TextStyle(fontSize: 21, fontWeight: FontWeight.w700),
            ),
          ],
        ),
        dialogText: const Text(
          'Please update to the latest version of the app to continue.',
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
          textAlign: TextAlign.center,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Example App"),
      ),
    );
  }
}
