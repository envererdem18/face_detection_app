import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

extension GlobalLoadingWrapper on BuildContext {
  Future<void> globalLoadingWrapper(Function() func) async {
    _startLoading();
    await func();
    _stopLoading();
  }

  // this is where you would do your fullscreen loading
  Future<void> _startLoading() async {
    return await showDialog<void>(
      context: this,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const SimpleDialog(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          children: <Widget>[
            Center(
              child: SizedBox(
                height: 96,
                width: 96,
                child: Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(6),
                    ),
                  ),
                  child: SpinKitDualRing(
                    color: Colors.lightBlueAccent,
                    duration: Duration(milliseconds: 1000),
                    size: 50,
                  ),
                ),
              ),
            )
          ],
        );
      },
    );
  }

  Future<void> _stopLoading() async => Get.back();
}
