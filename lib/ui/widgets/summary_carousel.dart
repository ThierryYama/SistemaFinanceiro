import 'package:financeiro/ui/widgets/summary_card.dart';
import 'package:financeiro/ui/widgets/summary_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SummaryCarousel extends StatefulWidget {
  final double totalIncome;
  final double totalExpense;

  const SummaryCarousel(
      {super.key, required this.totalExpense, required this.totalIncome});

  @override
  State<SummaryCarousel> createState() => _SummaryCarouselState();
}

class _SummaryCarouselState extends State<SummaryCarousel>
    with SingleTickerProviderStateMixin {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    _scaleAnimation = Tween<double>(begin: 0.9, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        AnimatedBuilder(
          animation: _scaleAnimation,
          builder: (context, child) {
            return Transform.scale(scale: _scaleAnimation.value, child: child);
          },
          child: SizedBox(
            height: 240,
            child: PageView.builder(
                controller: _pageController,
                physics: const BouncingScrollPhysics(),
                itemCount: 2,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });

                  HapticFeedback.lightImpact();
                },
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return Hero(
                      tag: 'summary1-card',
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: SummaryCard(
                            totalIncome: widget.totalIncome,
                            totalExpense: widget.totalExpense,
                            balance: widget.totalIncome - widget.totalExpense),
                      ),
                    );
                  } else {
                    return Hero(
                      tag: 'chart-widget',
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: SummaryChart(
                              totalIncome: widget.totalIncome,
                              totalExpense: widget.totalExpense),
                        ),
                      ),
                    );
                  }
                }),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            2,
            (index) => TweenAnimationBuilder(
              tween: Tween<double>(
                begin: 0.0,
                end: _currentPage == index ? 1.0 : 0.0,
              ),
              duration: const Duration(milliseconds: 300),
              builder: (context, double value, _) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  height: 8,
                  width: value * 24 + 8,
                  decoration: BoxDecoration(
                    color: _currentPage == index
                        ? Theme.of(context).colorScheme.primary
                        : Colors.grey.withValues(alpha: 0.4),
                    borderRadius: BorderRadius.circular(4),
                  ),
                );
              },
            ),
          ),
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Text(
            'Arraste para Visualizar o ${_currentPage == 0 ? "Grafico" : "Resumo"}',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade600,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      ],
    );
  }
}
