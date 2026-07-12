
// import 'package:flutter/material.dart';

// enum DialogType { success, error, warning }

// class AppDialog {
//   static Future<void> show(
//     BuildContext context, {
//     required DialogType type,
//     String title = "",
//     required String message,
//     String buttonText = "OK",
//     VoidCallback? onOk,
//     bool barrierDismissible = false,
//   }) {
//     return showDialog(
//       context: context,
//       barrierDismissible: barrierDismissible,
//       builder: (_) {
//         final config = _getConfig(type);

//         return Dialog(
//           backgroundColor: Colors.white,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(15),
//           ),
//           insetPadding: const EdgeInsets.symmetric(horizontal: 24),
//           child: Padding(
//             padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 /// 🎯 Lottie
//                 // Lottie.asset(config.lottiePath, height: 140, repeat: false),

//                 // const SizedBox(height: 12),

//                 /// Title
//                 Text(
//                   title.isEmpty ? config.defaultTitle : title,
//                   style: const TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.w700,
//                   ),
//                   textAlign: TextAlign.center,
//                 ),

//                 const SizedBox(height: 8),

//                 /// Message
//                 Text(
//                   message,
//                   textAlign: TextAlign.center,
//                   style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
//                 ),

//                 const SizedBox(height: 10),

//                 /// Button
//                 // CommonBtn(
//                 //   onPressed: () {
//                 //     onOk?.call();
//                 //     // Navigator.of(context).pop();
//                 //   },
//                 //   width: 100,
//                 //   height: 50,
//                 //   bgColor: AppColors.primaryDark,
//                 //   text: buttonText,
//                 // ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }

//   static _DialogConfig _getConfig(DialogType type) {
//     switch (type) {
//       case DialogType.success:
//         return _DialogConfig(
//           lottiePath: "assets/lotties/success.json",
//           defaultTitle: "Success",
//           buttonColor: Colors.green,
//         );

//       case DialogType.error:
//         return _DialogConfig(
//           lottiePath: "assets/lotties/error.json",
//           defaultTitle: "Error",
//           buttonColor: Colors.red,
//         );

//       case DialogType.warning:
//         return _DialogConfig(
//           lottiePath: "assets/lotties/warning.json",
//           defaultTitle: "Warning",
//           buttonColor: Colors.orange,
//         );
//     }
//   }

//   static Future<void> deviceLogout(
//     BuildContext context, {
//     String device = "",
//     required String deviceName,
//     VoidCallback? logout,
//   }) {
//     return showDialog(
//       context: context,
//       builder: (dialogContext) {
//         return Dialog(
//           backgroundColor: AppColors.white,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(15),
//           ),
//           insetPadding: const EdgeInsets.symmetric(horizontal: 24),
//           child: DeviceLogout(
//             device: device,
//             deviceName: deviceName,
//             onLogout: logout,
//           ),
//         );
//       },
//     );
//   }
// }