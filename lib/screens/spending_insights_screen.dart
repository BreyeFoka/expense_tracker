import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../theme/app_theme.dart';

class SpendingInsightsScreen extends StatefulWidget {
  const SpendingInsightsScreen({super.key});

  @override
  State<SpendingInsightsScreen> createState() => _SpendingInsightsScreenState();
}

class _SpendingInsightsScreenState extends State<SpendingInsightsScreen> {
  String _selectedPeriod = 'Weekly';

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
          'Spending Insights',
          style: TextStyle(
            color: AppTheme.textWhite,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: AppTheme.textWhite),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Period Tabs
            Row(
              children: [
                _buildPeriodTab('Weekly'),
                const SizedBox(width: 12),
                _buildPeriodTab('Monthly'),
                const SizedBox(width: 12),
                _buildPeriodTab('Semester'),
              ],
            ),
            const SizedBox(height: 20),

            // Total Spent Card
            Container(
              width: double.infinity,
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
                      const Text(
                        'TOTAL SPENT',
                        style: TextStyle(
                          color: AppTheme.textGray,
                          fontSize: 11,
                          letterSpacing: 1.5,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppTheme.neonGreen.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Icon(
                              Icons.trending_down,
                              color: AppTheme.neonGreen,
                              size: 14,
                            ),
                            SizedBox(width: 4),
                            Text(
                              '-12% vs last week',
                              style: TextStyle(
                                color: AppTheme.neonGreen,
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    '\$450.00',
                    style: TextStyle(
                      color: AppTheme.textWhite,
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      height: 1.1,
                    ),
                  ),
                  const SizedBox(height: 8),
                  RichText(
                    text: const TextSpan(
                      style: TextStyle(fontSize: 13, height: 1.3),
                      children: [
                        TextSpan(
                          text: 'You are ',
                          style: TextStyle(color: AppTheme.textGray),
                        ),
                        TextSpan(
                          text: '\$50 under budget',
                          style: TextStyle(
                            color: AppTheme.neonGreen,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        TextSpan(
                          text: ' this week.',
                          style: TextStyle(color: AppTheme.textGray),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),

            // Spending Trend
            const Text(
              'Spending Trend',
              style: TextStyle(
                color: AppTheme.textWhite,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 15),

            // Daily Activity Bar Chart
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppTheme.darkGreenCard,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Daily Activity',
                        style: TextStyle(
                          color: AppTheme.textGray,
                          fontSize: 14,
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: const Size(0, 0),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: Row(
                          children: const [
                            Text(
                              'Details',
                              style: TextStyle(
                                color: AppTheme.neonGreen,
                                fontSize: 13,
                              ),
                            ),
                            SizedBox(width: 4),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: AppTheme.neonGreen,
                              size: 12,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 200,
                    child: BarChart(
                      BarChartData(
                        alignment: BarChartAlignment.spaceAround,
                        maxY: 300,
                        barTouchData: BarTouchData(
                          enabled: true,
                          touchTooltipData: BarTouchTooltipData(
                            tooltipBorder:
                                const BorderSide(color: AppTheme.neonGreen),
                            tooltipPadding: const EdgeInsets.all(8),
                            getTooltipColor: (group) => AppTheme.neonGreen,
                            getTooltipItem: (group, groupIndex, rod, rodIndex) {
                              return BarTooltipItem(
                                '\$${rod.toY.toInt()}',
                                const TextStyle(
                                  color: AppTheme.darkGreen,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              );
                            },
                          ),
                        ),
                        titlesData: FlTitlesData(
                          show: true,
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: (value, meta) {
                                const days = [
                                  'M',
                                  'T',
                                  'W',
                                  'T',
                                  'F',
                                  'S',
                                  'S'
                                ];
                                if (value.toInt() >= 0 &&
                                    value.toInt() < days.length) {
                                  return Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Text(
                                      days[value.toInt()],
                                      style: TextStyle(
                                        color: value.toInt() == 4
                                            ? AppTheme.neonGreen
                                            : AppTheme.textGray,
                                        fontSize: 12,
                                        fontWeight: value.toInt() == 4
                                            ? FontWeight.bold
                                            : FontWeight.normal,
                                      ),
                                    ),
                                  );
                                }
                                return const Text('');
                              },
                            ),
                          ),
                          leftTitles: const AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                          topTitles: const AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                          rightTitles: const AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                        ),
                        borderData: FlBorderData(show: false),
                        gridData: const FlGridData(show: false),
                        barGroups: [
                          _buildBarGroup(0, 45),
                          _buildBarGroup(1, 65),
                          _buildBarGroup(2, 155),
                          _buildBarGroup(3, 85),
                          _buildBarGroup(4, 250), // Friday - highlighted
                          _buildBarGroup(5, 75),
                          _buildBarGroup(6, 68),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),

            // Savings Opportunity Card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppTheme.darkGreenCard,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppTheme.neonGreen.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.savings,
                      color: AppTheme.neonGreen,
                      size: 28,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Savings Opportunity',
                          style: TextStyle(
                            color: AppTheme.textWhite,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 6),
                        RichText(
                          text: const TextSpan(
                            style: TextStyle(fontSize: 13, height: 1.4),
                            children: [
                              TextSpan(
                                text: "You've spent ",
                                style: TextStyle(color: AppTheme.textGray),
                              ),
                              TextSpan(
                                text: "20% less",
                                style: TextStyle(
                                  color: AppTheme.neonGreen,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              TextSpan(
                                text:
                                    " on coffee this week! Keep it up to save an extra \$15 by Sunday.",
                                style: TextStyle(color: AppTheme.textGray),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),

            // Top Categories
            const Text(
              'Top Categories',
              style: TextStyle(
                color: AppTheme.textWhite,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 15),

            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppTheme.darkGreenCard,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  // Donut Chart
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: Stack(
                      children: [
                        PieChart(
                          PieChartData(
                            sectionsSpace: 2,
                            centerSpaceRadius: 35,
                            sections: [
                              PieChartSectionData(
                                value: 180,
                                color: AppTheme.neonGreen,
                                radius: 20,
                                title: '',
                              ),
                              PieChartSectionData(
                                value: 112,
                                color: AppTheme.booksBlue,
                                radius: 20,
                                title: '',
                              ),
                              PieChartSectionData(
                                value: 90,
                                color: AppTheme.transportBlue.withOpacity(0.6),
                                radius: 20,
                                title: '',
                              ),
                              PieChartSectionData(
                                value: 68,
                                color: AppTheme.textGray.withOpacity(0.3),
                                radius: 20,
                                title: '',
                              ),
                            ],
                          ),
                        ),
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                'Top',
                                style: TextStyle(
                                  color: AppTheme.textGray,
                                  fontSize: 11,
                                ),
                              ),
                              Text(
                                'Food',
                                style: TextStyle(
                                  color: AppTheme.neonGreen,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 30),
                  // Category List
                  Expanded(
                    child: Column(
                      children: [
                        _buildCategoryItem('Food', 180, AppTheme.neonGreen),
                        const SizedBox(height: 12),
                        _buildCategoryItem('Books', 112, AppTheme.booksBlue),
                        const SizedBox(height: 12),
                        _buildCategoryItem('Transport', 90,
                            AppTheme.transportBlue.withOpacity(0.6)),
                        const SizedBox(height: 12),
                        _buildCategoryItem(
                            'Others', 68, AppTheme.textGray.withOpacity(0.3)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),

            // Top Spenders
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Top Spenders',
                  style: TextStyle(
                    color: AppTheme.textWhite,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    'View all',
                    style: TextStyle(
                      color: AppTheme.neonGreen,
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            _buildSpenderItem(
              icon: Icons.restaurant,
              color: AppTheme.foodOrange,
              name: 'Campus Burger',
              date: 'Yesterday',
              category: 'Food',
              amount: 24.50,
            ),
            _buildSpenderItem(
              icon: Icons.menu_book,
              color: AppTheme.booksBlue,
              name: 'University Bookstore',
              date: 'Tue, Oct 24',
              category: 'Education',
              amount: 85.00,
            ),
            _buildSpenderItem(
              icon: Icons.movie,
              color: AppTheme.entertainmentPurple,
              name: 'Netflix Subscription',
              date: 'Mon, Oct 23',
              category: 'Entertainment',
              amount: 15.99,
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),

      bottomNavigationBar: _buildBottomNav(context, 2),
    );
  }

  Widget _buildPeriodTab(String label) {
    final isSelected = _selectedPeriod == label;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedPeriod = label;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.neonGreen : AppTheme.darkGreenCard,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? AppTheme.darkGreen : AppTheme.textGray,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  BarChartGroupData _buildBarGroup(int x, double value) {
    final isHighlighted = x == 4; // Friday
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: value,
          color: isHighlighted
              ? AppTheme.neonGreen
              : AppTheme.neonGreen.withOpacity(0.3),
          width: 28,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(6),
            topRight: Radius.circular(6),
          ),
        ),
      ],
      showingTooltipIndicators: isHighlighted ? [0] : [],
    );
  }

  Widget _buildCategoryItem(String name, double amount, Color color) {
    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            name,
            style: const TextStyle(
              color: AppTheme.textWhite,
              fontSize: 14,
            ),
          ),
        ),
        Text(
          '\$${amount.toInt()}',
          style: const TextStyle(
            color: AppTheme.textWhite,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildSpenderItem({
    required IconData icon,
    required Color color,
    required String name,
    required String date,
    required String category,
    required double amount,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.darkGreenCard,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    color: AppTheme.textWhite,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '$date • $category',
                  style: const TextStyle(
                    color: AppTheme.textGray,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Text(
            '-\$${amount.toStringAsFixed(2)}',
            style: const TextStyle(
              color: AppTheme.textWhite,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
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
                Navigator.pushReplacementNamed(context, '/');
              }),
              _buildNavItem(
                  Icons.account_balance, 'Budget', 1, currentIndex, () {
                Navigator.pushNamed(context, '/budget');
              }),
              _buildNavItem(Icons.bar_chart, 'Track', 2, currentIndex, () {
                // Already on Track
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
