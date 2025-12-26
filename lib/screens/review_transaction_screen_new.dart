import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class ReviewTransactionScreenNew extends StatefulWidget {
  const ReviewTransactionScreenNew({super.key});

  @override
  State<ReviewTransactionScreenNew> createState() => _ReviewTransactionScreenNewState();
}

class _ReviewTransactionScreenNewState extends State<ReviewTransactionScreenNew> {
  String _transactionType = 'Expense'; // 'Expense' or 'Income'
  String _amount = '45.00';
  String _currency = 'GHS';
  String _merchant = 'UBER RIDES';
  DateTime _selectedDate = DateTime(2023, 10, 24);
  TimeOfDay _selectedTime = const TimeOfDay(hour: 14, minute: 30);
  String _selectedCategory = 'Transportation';
  String _referenceId = '17384920432';

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
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: AppTheme.textWhite),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Review Transaction',
                    style: AppTheme.headingMedium.copyWith(fontSize: 20),
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
                    // Amount Card
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: AppTheme.darkGreenCard,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          Text(
                            'PARSED AMOUNT',
                            style: AppTheme.bodySmall.copyWith(
                              fontSize: 12,
                              color: AppTheme.textGray,
                              letterSpacing: 1.5,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                _currency,
                                style: TextStyle(
                                  color: AppTheme.textGray,
                                  fontSize: 28,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                _amount,
                                style: const TextStyle(
                                  color: AppTheme.textWhite,
                                  fontSize: 48,
                                  fontWeight: FontWeight.bold,
                                  height: 1,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          // Type Toggle
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _buildTypeToggle('Expense'),
                              const SizedBox(width: 16),
                              _buildTypeToggle('Income'),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Merchant/Recipient
                    Text(
                      'Merchant / Recipient',
                      style: AppTheme.labelMedium.copyWith(
                        fontSize: 14,
                        color: AppTheme.textGray,
                      ),
                    ),
                    const SizedBox(height: 12),
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
                            child: Text(
                              _merchant,
                              style: AppTheme.bodyLarge.copyWith(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
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

                    const SizedBox(height: 24),

                    // Date and Time Row
                    Row(
                      children: [
                        // Date
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Date',
                                style: AppTheme.labelMedium.copyWith(
                                  fontSize: 14,
                                  color: AppTheme.textGray,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: AppTheme.darkGreenCard,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.calendar_today,
                                      color: AppTheme.textGray,
                                      size: 20,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      'Oct 24, 2023',
                                      style: AppTheme.bodyLarge.copyWith(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(width: 16),

                        // Time
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Time',
                                style: AppTheme.labelMedium.copyWith(
                                  fontSize: 14,
                                  color: AppTheme.textGray,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: AppTheme.darkGreenCard,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.access_time,
                                      color: AppTheme.textGray,
                                      size: 20,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      '14:30',
                                      style: AppTheme.bodyLarge.copyWith(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    // Category
                    Text(
                      'Category',
                      style: AppTheme.labelMedium.copyWith(
                        fontSize: 14,
                        color: AppTheme.textGray,
                      ),
                    ),
                    const SizedBox(height: 12),
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
                              Icons.directions_bus,
                              color: AppTheme.transportBlue,
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              _selectedCategory,
                              style: AppTheme.bodyLarge.copyWith(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          const Icon(
                            Icons.check,
                            color: AppTheme.neonGreen,
                            size: 20,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Reference ID
                    Text(
                      'Reference ID',
                      style: AppTheme.labelMedium.copyWith(
                        fontSize: 14,
                        color: AppTheme.textGray,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppTheme.darkGreenCard,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.tag,
                            color: AppTheme.textGray,
                            size: 20,
                          ),
                          const SizedBox(width: 12),
                          Text(
                            _referenceId,
                            style: AppTheme.bodyLarge.copyWith(
                              fontSize: 14,
                              fontFamily: 'monospace',
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 32),

                    // Help Text
                    Center(
                      child: Text(
                        'Verify details before saving. You can edit this later.',
                        style: AppTheme.bodySmall.copyWith(
                          fontSize: 13,
                          color: AppTheme.textGray,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Confirm Button
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Transaction imported successfully!'),
                        backgroundColor: AppTheme.successGreen,
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.neonGreen,
                    foregroundColor: AppTheme.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.check_circle, color: AppTheme.black, size: 22),
                      const SizedBox(width: 8),
                      Text(
                        'Confirm & Save Expense',
                        style: AppTheme.buttonText.copyWith(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTypeToggle(String type) {
    final isSelected = _transactionType == type;
    return GestureDetector(
      onTap: () => setState(() => _transactionType = type),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isSelected ? AppTheme.neonGreen : Colors.transparent,
              border: Border.all(
                color: isSelected ? AppTheme.neonGreen : AppTheme.textGray,
                width: 2,
              ),
            ),
            child: isSelected
                ? const Icon(
                    Icons.circle,
                    color: AppTheme.black,
                    size: 12,
                  )
                : null,
          ),
          const SizedBox(width: 8),
          Text(
            type,
            style: TextStyle(
              color: isSelected ? AppTheme.neonGreen : AppTheme.textGray,
              fontSize: 16,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
