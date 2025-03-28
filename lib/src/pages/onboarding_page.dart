import 'package:flutter/material.dart';
import 'package:doculite/src/generated/l10n.dart';
import 'package:doculite/src/pages/home_page.dart';
import 'package:doculite/src/utils/toast_utils.dart';
import 'package:flutter_animate/flutter_animate.dart';

/// 首次使用引导页面
class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> _onboardingData = [
    {
      'title': '欢迎使用 DocuLite',
      'description': '一款轻量高效的文档管理工具，助您轻松处理文件。',
      'icon': '📂',
    },
    {
      'title': 'PDF 工具',
      'description': '支持 PDF 转换和合并，提升工作效率。',
      'icon': '📜',
    },
    {
      'title': 'OCR 识别',
      'description': '将图片转为文字，快速提取信息。',
      'icon': '🔍',
    },
  ];

  void _nextPage() {
    if (_currentPage < _onboardingData.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomePage()),
      );
      ToastUtils.show(context, '欢迎体验 DocuLite！');
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) => setState(() => _currentPage = index),
                itemCount: _onboardingData.length,
                itemBuilder: (context, index) {
                  final data = _onboardingData[index];
                  return Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          data['icon']!,
                          style: const TextStyle(fontSize: 80),
                        ).animate().scale(duration: 500.ms),
                        const SizedBox(height: 32),
                        Text(
                          data['title']!,
                          style: Theme.of(context).textTheme.headlineMedium,
                          textAlign: TextAlign.center,
                        ).animate().fadeIn(duration: 300.ms),
                        const SizedBox(height: 16),
                        Text(
                          data['description']!,
                          style: Theme.of(context).textTheme.bodyLarge,
                          textAlign: TextAlign.center,
                        ).animate().fadeIn(duration: 300.ms, delay: 200.ms),
                      ],
                    ),
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _onboardingData.length,
                (index) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentPage == index
                        ? Theme.of(context).primaryColor
                        : Colors.grey,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: _nextPage,
              child: Text(_currentPage == _onboardingData.length - 1 ? '开始使用' : '下一步'),
            ).animate().scale(duration: 200.ms).then().shakeX(amount: 2),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
