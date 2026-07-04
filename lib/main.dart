import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import 'features/download_screen.dart';
import 'features/vip_screen.dart';

void main() {
  runApp(const ProviderScope(child: GwinBayinApp()));
}

// --- RIVERPOD STATE NOTIFIERS ---

class ThemeNotifier extends StateNotifier<ThemeMode> {
  ThemeNotifier() : super(ThemeMode.dark);

  void toggleTheme(bool isDark) {
    state = isDark ? ThemeMode.dark : ThemeMode.light;
  }
}

final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeMode>((ref) {
  return ThemeNotifier();
});

final navigationProvider = StateNotifierProvider<NavigationNotifier, int>((
  ref,
) {
  return NavigationNotifier();
});

class NavigationNotifier extends StateNotifier<int> {
  NavigationNotifier() : super(0);

  void changeIndex(int index) => state = index;
}

// --- APPLICATION ENTRY ---

class GwinBayinApp extends ConsumerWidget {
  const GwinBayinApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);

    return MaterialApp(
      title: 'Gwin Bayin',
      debugShowCheckedModeBanner: false,
      themeMode: themeMode,
      // Light Theme Configuration
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: const Color(0xFFF3F4F6),
        colorScheme: const ColorScheme.light(
          primary: Color(0xFFE53935),
          surface: Colors.white,
          onSurface: Colors.black87,
        ),
      ),
      // Dark Theme Configuration
      darkTheme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF121315),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFFE53935),
          surface: Color(0xFF1E2022),
          onSurface: Colors.white,
        ),
      ),
      home: const MainShellScreen(),
    );
  }
}

// --- MAIN SHELL ---

class MainShellScreen extends ConsumerWidget {
  const MainShellScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentNavIndex = ref.watch(navigationProvider);
    final themeMode = ref.watch(themeProvider);
    final isDark = themeMode == ThemeMode.dark;

    // Define Screen Body Views
    final List<Widget> screens = [
      const HomeSliverView(),
      const VipVideosSliverView(),
      const DownloadsSliverView(),
      const SettingsSliverView(),
    ];

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            // Render Current Tab View
            IndexedStack(index: currentNavIndex, children: screens),

            // Shared Floating Bottom Navigation Layout
            const Positioned(
              left: 16,
              right: 16,
              bottom: 16,
              child: CustomFloatingNavBar(),
            ),
          ],
        ),
      ),
    );
  }
}

// --- HOME VIEW WITH CUSTOMSCROLLVIEW ---

class HomeSliverView extends StatelessWidget {
  const HomeSliverView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const SliverPadding(
          padding: EdgeInsets.fromLTRB(16, 20, 16, 0),
          sliver: SliverToBoxAdapter(
            child: Column(
              children: [
                HeaderProfileRow(),
                // SizedBox(height: 16),
                // VideoSearchBar(),
                SizedBox(height: 20),
                FeaturedCard(),
                SizedBox(height: 24),
              ],
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              const VideoHorizontalSection(
                title: 'Trending',
                count: 23,
                videoTitles: ['နမူနာ ထိတ်ပုံ', 'နမူနာ ထိတ်ပုံ'],
              ),
              const SizedBox(height: 24),
              const VideoHorizontalSection(
                title: 'KOREA-MMSUB',
                count: 39,
                videoTitles: ['နမူနာ ထိတ်ပုံ', 'နမူနာ ထိတ်ပုံ'],
              ),
              const SizedBox(height: 100), // Navigation spacing
            ]),
          ),
        ),
      ],
    );
  }
}

// --- NEW SETTINGS SCREEN UI (SLIVER-BASED) ---

class SettingsSliverView extends ConsumerWidget {
  const SettingsSliverView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);
    final isDark = themeMode == ThemeMode.dark;
    final surfaceColor = Theme.of(context).colorScheme.surface;

    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
          sliver: SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header with Theme Toggle Switch
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
                    CupertinoSwitch(
                      activeColor: const Color(0xFFE53935),
                      trackColor: Colors.grey.withOpacity(0.3),
                      value: isDark,
                      onChanged: (value) {
                        ref.read(themeProvider.notifier).toggleTheme(value);
                      },
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                // VIP Key Activation Card
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

                // "About" Section Header
                Text(
                  'About',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.grey[400] : Colors.grey[700],
                  ),
                ),
                const SizedBox(height: 12),

                // About Options Container Block
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
                const SizedBox(height: 100), // Spacing for bottom floating bar
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

// --- SHARED REFACTORED STATELESS UI COMPONENTS ---

class HeaderProfileRow extends StatelessWidget {
  const HeaderProfileRow({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.all(2),
              child: const Icon(
                Icons.g_mobiledata,
                color: Colors.red,
                size: 30,
              ),
            ),
            const SizedBox(width: 12),
            Text(
              'Gwin Bayin',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class VideoSearchBar extends StatelessWidget {
  const VideoSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    final surfaceColor = Theme.of(context).colorScheme.surface;
    return Container(
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: const TextField(
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: 'Search videos...',
          hintStyle: TextStyle(color: Colors.grey),
          prefixIcon: Icon(Icons.search, color: Colors.grey),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 14),
        ),
      ),
    );
  }
}

class FeaturedCard extends StatelessWidget {
  const FeaturedCard({super.key});

  @override
  Widget build(BuildContext context) {
    final surfaceColor = Theme.of(context).colorScheme.surface;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Featured',
            style: TextStyle(color: Colors.grey[400], fontSize: 14),
          ),
          const SizedBox(height: 6),
          Text(
            'အထူးရွေးချယ်ထားသော ဗီဒီယိုများ',
            style: TextStyle(
              color: isDark ? Colors.white : Colors.black87,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFE53935),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            icon: const Icon(Icons.play_arrow, size: 20),
            label: const Text(
              'Play',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}

class VideoHorizontalSection extends StatelessWidget {
  final String title;
  final int count;
  final List<String> videoTitles;

  const VideoHorizontalSection({
    super.key,
    required this.title,
    required this.count,
    required this.videoTitles,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                color: isDark ? Colors.white : Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              'View All',
              style: TextStyle(
                color: Color(0xFFE53935),
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: List.generate(videoTitles.length, (index) {
            return Expanded(
              child: Padding(
                padding: EdgeInsets.only(right: index == 0 ? 12.0 : 0),
                child: VideoThumbnailCard(title: videoTitles[index]),
              ),
            );
          }),
        ),
      ],
    );
  }
}

class VideoThumbnailCard extends StatelessWidget {
  final String title;
  const VideoThumbnailCard({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final surfaceColor = Theme.of(context).colorScheme.surface;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AspectRatio(
          aspectRatio: 1.5,
          child: Container(
            decoration: BoxDecoration(
              color: surfaceColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Center(child: Icon(Icons.play_arrow, size: 32)),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: TextStyle(
            color: isDark ? Colors.white : Colors.black,
            fontSize: 14,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 2),
        Text(
          '5.2K views • 2 days ago',
          style: TextStyle(color: Colors.grey[500], fontSize: 11),
        ),
      ],
    );
  }
}

// --- COMPACTED FLOATING NAVIGATION BAR WITH RIVERPOD CONNECTION ---

class CustomFloatingNavBar extends ConsumerWidget {
  const CustomFloatingNavBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(navigationProvider);
    final isDark = ref.watch(themeProvider) == ThemeMode.dark;

    return Container(
      height: 65,
      decoration: BoxDecoration(
        color: isDark
            ? const Color(0xFF1E2022).withOpacity(0.95)
            : Colors.white.withOpacity(0.95),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(
          color: isDark ? Colors.white10 : Colors.black12,
          width: 1.5,
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildItem(
            ref,
            index: 0,
            activeIndex: currentIndex,
            label: 'Home',
            icon: Icons.home_outlined,
            activeIcon: Icons.home,
          ),
          _buildItem(
            ref,
            index: 1,
            activeIndex: currentIndex,
            label: 'VIP',
            icon: Icons.reviews_sharp,
            activeIcon: Icons.workspace_premium,
          ),
          _buildItem(
            ref,
            index: 2,
            activeIndex: currentIndex,
            label: 'Downloads',
            icon: Icons.download_outlined,
            activeIcon: Icons.download,
          ),
          _buildItem(
            ref,
            index: 3,
            activeIndex: currentIndex,
            label: 'Setting',
            icon: Icons.person_outline,
            activeIcon: Icons.person,
          ),
        ],
      ),
    );
  }

  Widget _buildItem(
    WidgetRef ref, {
    required int index,
    required int activeIndex,
    required String label,
    required IconData icon,
    required IconData activeIcon,
  }) {
    final isSelected = activeIndex == index;
    return GestureDetector(
      onTap: () => ref.read(navigationProvider.notifier).changeIndex(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        decoration: isSelected
            ? BoxDecoration(
                color: const Color(0xFFE53935).withOpacity(0.12),
                borderRadius: BorderRadius.circular(20),
              )
            : null,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isSelected ? activeIcon : icon,
              color: isSelected ? const Color(0xFFE53935) : Colors.grey,
              size: 22,
            ),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? const Color(0xFFE53935) : Colors.grey,
                fontSize: 11,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
