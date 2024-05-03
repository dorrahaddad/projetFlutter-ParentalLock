import 'package:external_app_launcher/external_app_launcher.dart';
import 'package:untitled3/alert_dialog_service/alert_dialog_service.dart';
import 'package:untitled3/main_app_ui/utils/fonts.dart';
import 'package:flutter/material.dart';

class AlertDialogHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Material(
      type: MaterialType.transparency,
      child: SizedBox(
        height: screenHeight * 0.4,
        child: Column(
          children: [
            Padding(
                padding: EdgeInsets.all(screenWidth * 0.01),
                child: Image(
                  image: const AssetImage("assets/icons/block.png"),
                  width: screenHeight * 0.15,
                )),
            Spacer(),
            _title(),
            Spacer(),
            _dismissButton(context),
            SizedBox(width: screenWidth * 0.025)
          ],
        ),
      ),
    );
  }

  Widget _title() {
    return Text("out of time!!!!", style: Fonts.header3(color: Colors.white));
  }

  Widget _dismissButton(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return IconButton(
      color: Colors.white,
      onPressed: () async {
        await LaunchApp.openApp(
          androidPackageName: 'com.example.untitled3',
          openStore: true,
        );
        await AlertDialogService.closeAlertDialog();
      },
      icon: Icon(
        Icons.close,
        size: screenHeight * 0.04,
      ),
    );
  }
}
