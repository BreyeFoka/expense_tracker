import 'dart:ui';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class NewBudgetScreen extends StatefulWidget {
  const NewBudgetScreen({super.key});

  @override
  State<NewBudgetScreen> createState() => _NewBudgetScreenState();
}

class _NewBudgetScreenState extends State<NewBudgetScreen> {
  bool isCurrentMonth = true;

  final Map<String, BudgetData> _budgets = {
    '1': BudgetData(
        'Groceries', 300.0, 200.0, Icons.shopping_basket, AppTheme.foodOrange),
    '2': BudgetData(
        'Transport', 50.0, 45.0, Icons.directions_bus, AppTheme.transportBlue),
    '3': BudgetData('Entertainment', 100.0, 80.0, Icons.movie,
        AppTheme.entertainmentPurple),
    '4': BudgetData('Housing', 550.0, 550.0, Icons.home, Colors.pink),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.darkGreen,
      appBar: AppBar(
        backgroundColor: AppTheme.darkGreen,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppTheme.textWhite),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'November Budget',
          style: TextStyle(
            color: AppTheme.textWhite,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit, color: AppTheme.neonGreen),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Month Toggle
                  Row(
                    children: [
                      Expanded(
                        child: _buildMonthTab('CURRENT MONTH', isCurrentMonth),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildMonthTab('NEXT MONTH', !isCurrentMonth),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),

                  // Budget Summary Card
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: AppTheme.darkGreenCard,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  'Total Monthly Budget',
                                  style: TextStyle(
                                    color: AppTheme.textGray,
                                    fontSize: 14,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  '\$1,200.00',
                                  style: TextStyle(
                                    color: AppTheme.textWhite,
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: AppTheme.neonGreen,
                                  width: 4,
                                ),
                              ),
                              child: const Center(
                                child: Icon(
                                  Icons.account_balance_wallet,
                                  color: AppTheme.neonGreen,
                                  size: 28,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 25),
                        const Text(
                          '\$340.00',
                          style: TextStyle(
                            color: AppTheme.neonGreen,
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text(
                          'AMOUNT REMAINING',
                          style: TextStyle(
                            color: AppTheme.textGray,
                            fontSize: 12,
                            letterSpacing: 1.2,
                          ),
                        ),
                        const SizedBox(height: 15),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: LinearProgressIndicator(
                            value: 0.72,
                            backgroundColor: AppTheme.darkGreen,
                            valueColor: const AlwaysStoppedAnimation<Color>(
                                AppTheme.neonGreen),
                            minHeight: 10,
                          ),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/analytics');
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppTheme.textWhite,
                              foregroundColor: AppTheme.darkGreen,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(Icons.bar_chart, size: 20),
                                SizedBox(width: 8),
                                Text(
                                  'Analyze Spending',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 25),

                  // Categories Section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Categories',
                        style: TextStyle(
                          color: AppTheme.textWhite,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/manage_categories');
                        },
                        child: const Text(
                          'Manage',
                          style: TextStyle(
                            color: AppTheme.neonGreen,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),

                  // Category Budget Cards
                  ..._budgets.entries.map((entry) {
                    final data = entry.value;
                    final percentage =
                        ((data.spent / data.budget) * 100).toInt();
                    String status;
                    Color statusColor;
                    Color progressColor;

                    if (percentage >= 100) {
                      status = 'Paid';
                      statusColor = AppTheme.textGray;
                      progressColor = AppTheme.textGray;
                    } else if (percentage >= 85) {
                      status = 'Careful';
                      statusColor = AppTheme.warningOrange;
                      progressColor = AppTheme.warningOrange;
                    } else {
                      status = 'On Track';
                      statusColor = AppTheme.neonGreen;
                      progressColor = AppTheme.neonGreen;
                    }

                    return Container(
                      margin: const EdgeInsets.only(bottom: 15),
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: AppTheme.darkGreenCard,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: data.color.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Icon(data.icon,
                                    color: data.color, size: 24),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      data.name,
                                      style: const TextStyle(
                                        color: AppTheme.textWhite,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      '\$${data.spent.toStringAsFixed(0)} spent of \$${data.budget.toStringAsFixed(0)}',
                                      style: const TextStyle(
                                        color: AppTheme.textGray,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    '$percentage%',
                                    style: const TextStyle(
                                      color: AppTheme.textWhite,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    status,
                                    style: TextStyle(
                                      color: statusColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: LinearProgressIndicator(
                              value: (data.spent / data.budget).clamp(0.0, 1.0),
                              backgroundColor: AppTheme.darkGreen,
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(progressColor),
                              minHeight: 8,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),

                  // Add New Category Button with Dashed Border
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/manage_categories');
                    },
                    child: CustomPaint(
                      painter: _DashedRectPainter(
                        color: AppTheme.textGray.withOpacity(0.3),
                        strokeWidth: 2,
                        gap: 10,
                      ),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        width: double.infinity,
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.add_circle_outline,
                                color: AppTheme.textGray, size: 24),
                            SizedBox(width: 8),
                            Text(
                              'Add New Category',
                              style: TextStyle(
                                color: AppTheme.textGray,
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 80),
                ],
              ),
            ),
          ),

          // Bottom Navigation
          _buildBottomNav(context, 1),
        ],
      ),
    );
  }

  Widget _buildMonthTab(String title, bool isActive) {
    return GestureDetector(
      onTap: () {
        setState(() {
          // In a real app, this would switch data for the month
          if (title == 'CURRENT MONTH') {
            isCurrentMonth = true;
          } else {
            isCurrentMonth = false;
          }
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: isActive ? AppTheme.neonGreen : AppTheme.darkGreenCard,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              color: isActive ? AppTheme.darkGreen : AppTheme.textGray,
              fontSize: 13,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNav(BuildContext context, int currentIndex) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.darkGreenCard,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildNavItem(Icons.home, 'Home', 0, currentIndex, () {
                Navigator.pushNamed(context, '/');
              }),
              _buildNavItem(Icons.account_balance, 'Budget', 1, currentIndex,
                  () {
                // Already on Budget
              }),
              _buildNavItem(Icons.bar_chart, 'Track', 2, currentIndex, () {
                Navigator.pushNamed(context, '/statistics');
              }),
              _buildNavItem(Icons.person, 'Profile', 3, currentIndex, () {
                Navigator.pushNamed(context, '/profile');
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index, int currentIndex,
      VoidCallback onTap) {
    final isActive = index == currentIndex;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isActive ? AppTheme.neonGreen : AppTheme.textGray,
              size: 24,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: isActive ? AppTheme.neonGreen : AppTheme.textGray,
                fontSize: 11,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BudgetData {
  final String name;
  final double budget;
  final double spent;
  final IconData icon;
  final Color color;

  BudgetData(this.name, this.budget, this.spent, this.icon, this.color);
}

class _DashedRectPainter extends CustomPainter {
  final double strokeWidth;
  final Color color;
  final double gap;

  _DashedRectPainter({
    this.strokeWidth = 2.0,
    this.color = Colors.grey,
    this.gap = 5.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint dashedPaint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    double x = size.width;
    double y = size.height;

    // Draw rounded rect with path
    Path path = Path();
    path.addRRect(RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, x, y),
      const Radius.circular(18), // Match container radius
    ));

    Path dashedPath = Path();

    // Convert path to dashed path
    for (PathMetric pathMetric in path.computeMetrics()) {
      double distance = 0.0;
      while (distance < pathMetric.length) {
        dashedPath.addPath(
          pathMetric.extractPath(distance, distance + 10), // Dash length 10
          Offset.zero,
        );
        distance += 10 + gap; // Dash length + gap
      }
    }

    canvas.drawPath(dashedPath, dashedPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
