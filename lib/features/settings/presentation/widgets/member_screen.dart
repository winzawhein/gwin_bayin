
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/provider/device_provider.dart';
import '../../../../core/provider/video_repository.dart';


class VipMembershipScreen extends StatefulWidget {
  const VipMembershipScreen({Key? key}) : super(key: key);

  @override
  State<VipMembershipScreen> createState() => _VipMembershipScreenState();
}

class _VipMembershipScreenState extends State<VipMembershipScreen> {
  final TextEditingController _keyController = TextEditingController();

  // Color Palette based on the provided UI screenshots
  static const Color bgColor = Colors.black;
  static const Color primaryGold = Color(0xFFFFB800);
  static const Color inputBgColor = Color(0xFF3A3A3A);
  static const Color blueCardBg = Color(0xFF051937);
  static const Color goldCardBg = Color(0xFF231B07);
  
  // Contact button colors
  static const Color telegramColor = Color(0xFF26A6E5);
  static const Color viberColor = Color(0xFF7360F2);
  static const Color messengerColor = Color(0xFF3A9F46);

  @override
  void dispose() {
    _keyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: primaryGold),
          onPressed: () => Navigator.maybePop(context),
        ),
        title: const Text(
          'VIP Membership',
          style: TextStyle(
            color: primaryGold,
            fontSize: 22,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 10),
            
            // Crown Badge
            Container(
              width: 130,
              height: 130,
              decoration: const BoxDecoration(
                color: primaryGold,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.amberAccent,
                    blurRadius: 20,
                    spreadRadius: -2,
                  )
                ],
              ),
              child:  Icon(
                Icons.diamond,
                size: 65,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 24),

            // Title & Subtitle Text
            const Text(
              'VIP Membership',
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'VIP key ရိုက်ထည့်၍ Activate ကိုနှိပ်ပါ',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 24),

            // VIP Key Input Field
            Container(
              decoration: BoxDecoration(
                color: inputBgColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: TextField(
                controller: _keyController,
                style: const TextStyle(color: Colors.white, fontSize: 16),
                decoration: const InputDecoration(
                  hintText: 'VIP Key',
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 16),
                  prefixIcon: Icon(Icons.key, color: primaryGold),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 18, horizontal: 16),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Activate Button
            Consumer(
              builder: (context, ref, _) {
                return SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () async {

                      final rawKey = _keyController.text.trim();

                      if (rawKey.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            backgroundColor: Color(0xFFE53935),
                            content: Text('VIP Key မထည့်ထားပါ'),
                          ),
                        );
                        return;
                      }

                      try {
                        final deviceId = await ref.read(deviceIdProvider.future);
                        final durationDays = await ref
                            .read(videoRepositoryProvider)
                            .activateVipKey(
                              key: rawKey,
                              deviceId: deviceId,
                            );

                        if (!context.mounted) return;
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor:  inputBgColor,
                            content: Text(
                              durationDays,
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        );
                      } on Object catch (e) {
                        if (!context.mounted) return;
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: const Color(0xFFE53935),
                            content: Text(
                              e.toString().replaceAll('Exception: ', ''),
                            ),
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryGold,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Activate',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 24),

            // "Or" Divider Text
            Row(
              children: const [
                Expanded(child: Divider(color: Colors.white24, thickness: 1)),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    'သို့မဟုတ်',
                    style: TextStyle(color: Colors.white54, fontSize: 14),
                  ),
                ),
                Expanded(child: Divider(color: Colors.white24, thickness: 1)),
              ],
            ),
            const SizedBox(height: 24),

            // Admin Contact Blue Box
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: blueCardBg,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  const Icon(Icons.help_outline, color: telegramColor, size: 40),
                  const SizedBox(height: 12),
                  const Text(
                    'VIP key မရှိဘူးလား?',
                    style: TextStyle(
                      color: telegramColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'VIP Member ဝယ်ယူရန် Adminနှင့် ဆက်သွယ်ပါ',
                    style: TextStyle(color: Colors.white, fontSize: 14),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  
                  // Contact Buttons Grid/Rows
                  Row(
                    children: [
                      Expanded(
                        child: _buildSocialButton(
                          icon: Icons.send,
                          label: 'Telegram',
                          color: telegramColor,
                          onTap: () {},
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildSocialButton(
                          icon: Icons.chat_bubble,
                          label: 'Viber',
                          color: viberColor,
                          onTap: () {},
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  _buildSocialButton(
                    icon: Icons.comment,
                    label: 'Messenger',
                    color: messengerColor,
                    onTap: () {},
                    width: MediaQuery.of(context).size.width * 0.45,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // VIP Perks Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: goldCardBg,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: primaryGold.withOpacity(0.3), width: 1),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children:  [
                      Icon(Icons.diamond, color: primaryGold, size: 24),
                      SizedBox(width: 8),
                      Text(
                        'VIP အားသာချက်များ:',
                        style: TextStyle(
                          color: primaryGold,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  
                  // List of perks parsed exactly from your screenshot strings
                  _buildPerkItem('VIP ကြေး(၃)လ (၅၀၀၀) ကျပ်ဖြင့်'),
                  _buildPerkItem('ကြော်ငြာတွေကြည့်စရာမလိုတော့ပါ'),
                  _buildPerkItem('မြန်မာစာတန်းထိုးအောကားများ'),
                  _buildPerkItem('Pornhub Premium Video များ'),
                  _buildPerkItem('Onlyfans Video များ'),
                  _buildPerkItem('BDSM နဲ့ Public Agent များ'),
                  _buildPerkItem('မြန်မာချောင်းရိုက်နဲ့ဟုမ်းမိတ်များ'),
                  _buildPerkItem('Cele တွေရဲ့ Local Leak များ တဝကြီး ကြည့်ရှုနိုင်ပါပြီ'),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // Social Contact Helper Widget
  Widget _buildSocialButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
    double? width,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: width,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: Colors.white, size: 20),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Perks List Item Helper Widget
  Widget _buildPerkItem(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 3),
            child: Icon(Icons.check_circle, color: primaryGold, size: 18),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}