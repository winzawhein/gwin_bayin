import 'package:flutter/material.dart';

import 'member_screen.dart';

class VipDialogHelper {
  static void showVipPurchaseDialog(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Dismiss VIP Dialog',
      barrierColor: Colors.black.withOpacity(0.75), // Dark dimmed overlay background
      transitionDuration: const Duration(milliseconds: 450),
      pageBuilder: (context, animation, secondaryAnimation) {
        return const SizedBox.shrink();
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        // Curve combination for a smooth, premium bouncy entry feel
        final curvedAnimation = CurvedAnimation(
          parent: animation,
          curve: Curves.bounceInOut, 
        );

        return ScaleTransition(
          scale: curvedAnimation,
          child: FadeTransition(
            opacity: animation,
            child: const AlertDialog(
              contentPadding: EdgeInsets.zero,
              backgroundColor: Colors.transparent,
              content: VipPurchaseDialogContent(),
            ),
          ),
        );
      },
    );
  }
}

class VipPurchaseDialogContent extends StatelessWidget {
  const VipPurchaseDialogContent({Key? key}) : super(key: key);

  // Exact styling colors extracted from your design assets
  static const Color cardBgColor = Color(0xFF132247); 
  static const Color primaryGold = Color(0xFFFFB800);
  static const Color innerBorderColor = Color(0xFF334B81);
  static const Color textButtonBg = Color(0xFF233560);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.85,
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        color: cardBgColor,
        borderRadius: BorderRadius.circular(28),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 12),
          
          // Glowing Trophy Badge
          Container(
            width: 90,
            height: 90,
            decoration: const BoxDecoration(
              color: primaryGold,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.amberAccent,
                  blurRadius: 25,
                  spreadRadius: -4,
                )
              ],
            ),
            child: const Icon(
              Icons.emoji_events, // Trophy asset icon matching your image wireframe
              size: 45,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 20),

          // Main Header Text
          const Text(
            'VIP ဝယ်ယူရန်',
            style: TextStyle(
              color: primaryGold,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),

          // Outlined Inner Highlight Box
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
            decoration: BoxDecoration(
              border: Border.all(color: innerBorderColor, width: 1.5),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Text(
              'မိုးလင်းတာနဲ့ ခံချင်နေပြီး',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 20),

          // Explanatory Burmese Message Block
          const Text(
            'ဤဗီဒီယိုသည် VIP User များအတွက်သာဖြစ်ပါသည်။ ကြည့်ရှုရန် VIP User ဖြစ်ရန် လိုအပ်ပါသည်။။',
            style: TextStyle(
              color: Colors.amberAccent, // Soft crisp white tint
              fontSize: 15,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 28),

          // Interactive Action Buttons Row
          Row(
            children: [
              // Buy/Upgrade Action Button
              Expanded(
                flex: 3,
                child: SizedBox(
                  height: 52,
                  child: ElevatedButton(
                    onPressed: () {
                      // Trigger purchase process flows
                      Navigator.pop(context);
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> VipMembershipScreen()));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryGold,
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      elevation: 0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.auto_awesome, size: 18, color: Colors.black),
                        SizedBox(width: 6),
                        Text(
                          'ဝယ်ယူရန်',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              
              // Close/Dismiss Action Button
              Expanded(
                flex: 2,
                child: SizedBox(
                  height: 52,
                  child: OutlinedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: OutlinedButton.styleFrom(
                      backgroundColor: textButtonBg,
                      side: BorderSide.none,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: const Text(
                      'ပိတ်မည်',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
        ],
      ),
    );
  }
}