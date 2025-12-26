import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class ReviewScanScreen extends StatefulWidget {
  const ReviewScanScreen({super.key});

  @override
  State<ReviewScanScreen> createState() => _ReviewScanScreenState();
}

class _ReviewScanScreenState extends State<ReviewScanScreen> {
  String _merchant = 'Target Market';
  String _amount = '42.85';
  DateTime _selectedDate = DateTime(2023, 10, 24);
  String _selectedCategory = 'Shopping';
  String _note = 'Weekly groceries';

  final List<Map<String, dynamic>> _categories = [
    {'name': 'Food', 'icon': Icons.restaurant, 'color': AppTheme.foodOrange},
    {'name': 'Shopping', 'icon': Icons.shopping_bag, 'color': AppTheme.shoppingPink},
    {'name': 'Transport', 'icon': Icons.directions_bus, 'color': AppTheme.transportBlue},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.darkGreen,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: AppTheme.textWhite),
                    onPressed: () => Navigator.pop(context),
                  ),
                  Text(
                    'Review Scan',
                    style: AppTheme.headingMedium.copyWith(fontSize: 20),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Discard',
                      style: AppTheme.bodyMedium.copyWith(
                        color: AppTheme.errorRed,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Receipt Preview
                    Container(
                      height: 180,
                      decoration: BoxDecoration(
                        color: AppTheme.darkGreenCard,
                        borderRadius: BorderRadius.circular(16),
                        image: DecorationImage(
                          image: const AssetImage('assets/images/receipt_placeholder.png'),
                          fit: BoxFit.cover,
                          colorFilter: ColorFilter.mode(
                            Colors.black.withOpacity(0.7),
                            BlendMode.darken,
                          ),
                        ),
                      ),
                      child: Stack(
                        children: [
                          Center(
                            child: Icon(
                              Icons.receipt_long,
                              size: 60,
                              color: AppTheme.textGray.withOpacity(0.5),
                            ),
                          ),
                          Positioned(
                            top: 12,
                            right: 12,
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.5),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.zoom_in,
                                color: AppTheme.textWhite,
                                size: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Info text
                    Text(
                      'We\'ve extracted these details. Please verify.',
                      style: AppTheme.bodyMedium.copyWith(fontSize: 14),
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 24),

                    // Amount Section
                    Center(
                      child: Column(
                        children: [
                          Text(
                            'TOTAL AMOUNT',
                            style: AppTheme.bodySmall.copyWith(
                              color: AppTheme.textGray,
                              fontSize: 12,
                              letterSpacing: 1.2,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 12),
                                child: Text(
                                  '\$',
                                  style: TextStyle(
                                    color: AppTheme.textGray,
                                    fontSize: 32,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Text(
                                _amount,
                                style: const TextStyle(
                                  color: AppTheme.neonGreen,
                                  fontSize: 56,
                                  fontWeight: FontWeight.bold,
                                  height: 1,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 32),

                    // Merchant
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppTheme.darkGreenCard,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: AppTheme.darkGreen,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(
                              Icons.store,
                              color: AppTheme.textGray,
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'MERCHANT',
                                  style: AppTheme.bodySmall.copyWith(
                                    fontSize: 10,
                                    color: AppTheme.textGray,
                                    letterSpacing: 1,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  _merchant,
                                  style: AppTheme.bodyLarge.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Icon(
                            Icons.edit_outlined,
                            color: AppTheme.textGray,
                            size: 20,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Date
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppTheme.darkGreenCard,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: AppTheme.darkGreen,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(
                              Icons.calendar_today,
                              color: AppTheme.textGray,
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'DATE',
                                  style: AppTheme.bodySmall.copyWith(
                                    fontSize: 10,
                                    color: AppTheme.textGray,
                                    letterSpacing: 1,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Oct 24, 2023',
                                  style: AppTheme.bodyLarge,
                                ),
                              ],
                            ),
                          ),
                          const Icon(
                            Icons.arrow_forward_ios,
                            color: AppTheme.textGray,
                            size: 16,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Category Section
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Category',
                          style: AppTheme.labelMedium,
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            'View All',
                            style: AppTheme.bodyMedium.copyWith(
                              color: AppTheme.neonGreen,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    // Category Pills
                    Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: _categories.map((category) {
                        final isSelected = _selectedCategory == category['name'];
                        return GestureDetector(
                          onTap: () => setState(() => _selectedCategory = category['name']),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                            decoration: BoxDecoration(
                              color: isSelected ? AppTheme.neonGreen : AppTheme.darkGreenCard,
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  category['icon'],
                                  color: isSelected ? AppTheme.black : AppTheme.textGray,
                                  size: 20,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  category['name'],
                                  style: TextStyle(
                                    color: isSelected ? AppTheme.black : AppTheme.textWhite,
                                    fontSize: 14,
                                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),

                    const SizedBox(height: 24),

                    // Note
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppTheme.darkGreenCard,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.edit_note,
                            color: AppTheme.textGray,
                            size: 24,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'NOTE',
                                  style: AppTheme.bodySmall.copyWith(
                                    fontSize: 10,
                                    color: AppTheme.textGray,
                                    letterSpacing: 1,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  _note,
                                  style: AppTheme.bodyLarge,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),

            // Bottom Buttons
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                children: [
                  // Retake Button
                  Expanded(
                    flex: 1,
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        side: BorderSide(color: AppTheme.textGray.withOpacity(0.3)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.camera_alt, color: AppTheme.textWhite, size: 20),
                          const SizedBox(width: 8),
                          Text(
                            'Retake',
                            style: AppTheme.bodyMedium.copyWith(
                              color: AppTheme.textWhite,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(width: 16),

                  // Confirm Button
                  Expanded(
                    flex: 2,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Expense added from scan!'),
                            backgroundColor: AppTheme.successGreen,
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.neonGreen,
                        foregroundColor: AppTheme.black,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.check, color: AppTheme.black, size: 20),
                          const SizedBox(width: 8),
                          Text(
                            'Confirm & Save',
                            style: AppTheme.buttonText.copyWith(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
