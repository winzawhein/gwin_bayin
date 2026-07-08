import 'package:flutter/material.dart';

class VipSliverView extends StatelessWidget {
  final ScrollController controller;
  const VipSliverView({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final List<Map<String, String>> vipItems = [
      {'title': 'လီးချက်ကိမ်းတောစော်က', 'views': '3.1K'},
      {'title': 'လောလောဆယ် ကောင်မလေးပါပဲ', 'views': '1.1K'},
      {'title': 'လီးစုပ်ပေးတာကြိုက်တဲ့', 'views': '908'},
      {'title': 'ရုပ်ကလေးကအပြစ်ပြောစရာမရှိ', 'views': '954'},
      {'title': 'ဒီလောက်ကြီးကံအံလဲလီးမ', 'views': '117'},
      {'title': 'စော်ကအသစ်မို့လီးတံဘဲ', 'views': '120'},
      {'title': 'ချစ်စရာလဲကောင်းလီးပေး', 'views': '100'},
      {'title': 'မီးလင်းတာနဲ့ ခံချင်နေပြီး', 'views': '12.5K'},
      {'title': 'စော်လေးကို အနောက်ကနေ', 'views': '419'},
      {'title': 'အိမ်မှာနှစ်ယောက်ထဲ ရှိတုန်း', 'views': '2.3K'},
    ];

    return CustomScrollView(
      controller: controller,
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
          sliver: SliverToBoxAdapter(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(width: 32),
                const Text(
                  'VIP Videos',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFFFB300),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.search, color: Color(0xFFFFB300)),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          sliver: SliverGrid(
            gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 0.95,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final item = vipItems[index % vipItems.length];
                return VipVideoCard(
                  title: item['title']!,
                  views: item['views']!,
                  isDark: isDark,
                );
              },
              childCount: vipItems.length,
            ),
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 120)),
      ],
    );
  }
}

class VipVideoCard extends StatelessWidget {
  final String title;
  final String views;
  final bool isDark;

  const VipVideoCard({
    super.key,
    required this.title,
    required this.views,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E2022) : Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: const Color(0xFFFFB300).withOpacity(0.4),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          )
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    width: double.infinity,
                    color: isDark ? Colors.white10 : Colors.black12,
                    child: const Center(
                      child: Icon(
                        Icons.play_circle_fill_rounded,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 6.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: isDark ? Colors.white : Colors.black87,
                            height: 1.3,
                          ),
                        ),
                        Row(
                          children: [
                            Icon(Icons.visibility_outlined,
                                size: 14, color: Colors.grey[500]),
                            const SizedBox(width: 4),
                            Text(
                              '$views views',
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.grey[500],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              top: 6,
              right: 6,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFB300),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Text(
                  'VIP',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

