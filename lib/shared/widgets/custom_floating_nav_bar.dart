import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/state/navigation_notifier.dart';
import '../../app/state/theme_notifier.dart';

class CustomFloatingNavBar extends ConsumerWidget {
  final bool visible;
  final double height;

  const CustomFloatingNavBar({
    super.key,
    required this.visible,
    this.height = 65,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(navigationIndexProvider);
    final isDark = ref.watch(isDarkProvider);

    final content = Container(
      height: height,
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
            context,
            ref,
            index: 0,
            activeIndex: currentIndex,
            label: 'Home',
            icon: Icons.home_outlined,
            activeIcon: Icons.home,
          ),
          _buildItem(
            context,
            ref,
            index: 1,
            activeIndex: currentIndex,
            label: 'VIP',
            icon: Icons.reviews_sharp,
            activeIcon: Icons.workspace_premium,
          ),
          _buildItem(
            context,
            ref,
            index: 2,
            activeIndex: currentIndex,
            label: 'Downloads',
            icon: Icons.download_outlined,
            activeIcon: Icons.download,
          ),
          _buildItem(
            context,
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

    return AnimatedSlide(
      offset: visible ? Offset.zero : const Offset(0, 1.2),
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeOutCubic,
      child: AnimatedOpacity(
        opacity: visible ? 1 : 0,
        duration: const Duration(milliseconds: 160),
        curve: Curves.easeOutCubic,
        child: content,
      ),
    );
  }

  Widget _buildItem(
    BuildContext context,
    WidgetRef ref, {
    required int index,
    required int activeIndex,
    required String label,
    required IconData icon,
    required IconData activeIcon,
  }) {
    final isSelected = activeIndex == index;

    return GestureDetector(
      onTap: () => ref
          .read(navigationIndexProvider.notifier)
          .changeIndex(index),
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
                fontWeight:
                    isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

