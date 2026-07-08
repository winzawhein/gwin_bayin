import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/state/theme_notifier.dart';
import '../../../widgets/customize_switch.dart';

class SettingsSliverView extends ConsumerWidget {
  final ScrollController controller;
  const SettingsSliverView({super.key, required this.controller});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = ref.watch(isDarkProvider);
    final surfaceColor = Theme.of(context).colorScheme.surface;

    return CustomScrollView(
      controller: controller,
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
          sliver: SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Settings',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : Colors.black,
                      ),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.2),
                    CustomThemeSwitch(
                      value: isDark,
                      onChanged: (newValue) {
                        ref.read(isDarkProvider.notifier).setDark(newValue);
                      },
                    ),
                    // CupertinoSwitch(
                    //   activeColor: const Color(0xFFE53935),
                    //   trackColor: Colors.grey.withOpacity(0.3),
                    //   value: isDark,
                    //   onChanged: (value) {
                    //     ref.read(isDarkProvider.notifier).setDark(value);
                    //   },
                    // ),
                  ],
                ),
                const SizedBox(height: 24),

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: surfaceColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: isDark ? Colors.white24 : Colors.black26,
                            width: 2,
                          ),
                        ),
                        child: CircleAvatar(
                          radius: 24,
                          backgroundColor: isDark
                              ? Colors.black12
                              : Colors.black12,
                          child: const Icon(
                            Icons.vpn_key_rounded,
                            color: Color(0xFFFFD700),
                            size: 24,
                          ),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'VIP Key ထည့်ရန်',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: isDark ? Colors.white : Colors.black,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'VIP Key ရှိပါက ထည့်သွင်းရန် လိုအပ်ပါတယ်',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[500],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2979FF),
                          foregroundColor: Colors.white,
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 18,
                            vertical: 10,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: const Text(
                          'ဝင်မည်',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 28),
                Text(
                  'About',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.grey[400] : Colors.grey[700],
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  decoration: BoxDecoration(
                    color: surfaceColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      _buildSettingRow(
                        context,
                        icon: Icons.info_outline,
                        title: 'Version',
                        subtitle: '1.0.0',
                        showTrailing: false,
                      ),
                      Divider(
                        height: 1,
                        color: isDark ? Colors.white10 : Colors.black12,
                      ),
                      _buildSettingRow(
                        context,
                        icon: Icons.lock_outline,
                        title: 'ကြီးဆေးဝယ်မယ်',
                        subtitle: 'Store',
                        showTrailing: true,
                      ),
                      Divider(
                        height: 1,
                        color: isDark ? Colors.white10 : Colors.black12,
                      ),
                      _buildSettingRow(
                        context,
                        icon: Icons.menu_book_outlined,
                        title: 'About Us',
                        subtitle: 'App အကြောင်း',
                        showTrailing: true,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 140),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSettingRow(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required bool showTrailing,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: isDark ? Colors.white10 : Colors.black12,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              size: 22,
              color: isDark ? Colors.white70 : Colors.black87,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                ),
              ],
            ),
          ),
          if (showTrailing)
            Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey[600]),
        ],
      ),
    );
  }
}
