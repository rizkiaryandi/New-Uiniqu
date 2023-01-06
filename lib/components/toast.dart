import 'package:flutter/material.dart';

class toast {
  static dynamic mainToast(fToast, message) {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.white,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Icon(
            Icons.check_circle,
            color: Colors.grey[900],
          ),
          SizedBox(
            width: 6.0,
          ),
          Text(message, style: TextStyle(color: Colors.grey[900])),
        ],
      ),
    );
    return fToast.showToast(
        child: toast,
        toastDuration: Duration(seconds: 3),
        positionedToastBuilder: (context, child) {
          return Positioned(
            child: child,
            bottom: 16.0,
            right: 16.0,
          );
        });
  }

  static dynamic dangerToast(fToast, message) {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.red,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Icon(
            Icons.check_circle,
            color: Colors.white,
          ),
          SizedBox(
            width: 6.0,
          ),
          Text(message, style: TextStyle(color: Colors.white)),
        ],
      ),
    );
    return fToast.showToast(
        child: toast,
        toastDuration: Duration(seconds: 3),
        positionedToastBuilder: (context, child) {
          return Positioned(
            child: child,
            bottom: 16.0,
            right: 16.0,
          );
        });
  }

  static dynamic successToast(fToast, message) {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.green,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Icon(
            Icons.check_circle,
            color: Colors.white,
          ),
          SizedBox(
            width: 6.0,
          ),
          Text(message, style: TextStyle(color: Colors.white)),
        ],
      ),
    );
    return fToast.showToast(
        child: toast,
        toastDuration: Duration(seconds: 3),
        positionedToastBuilder: (context, child) {
          return Positioned(
            child: child,
            bottom: 16.0,
            right: 16.0,
          );
        });
  }
}
