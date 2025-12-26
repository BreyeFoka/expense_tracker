import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/app_theme.dart';

class ImportMomoScreenNew extends StatefulWidget {
  const ImportMomoScreenNew({super.key});

  @override
  State<ImportMomoScreenNew> createState() => _ImportMomoScreenNewState();
}

class _ImportMomoScreenNewState extends State<ImportMomoScreenNew> {
  final _messageController = TextEditingController();
  bool _isProcessing = false;

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _pasteFromClipboard() async {
    final data = await Clipboard.getData(Clipboard.kTextPlain);
    if (data != null && data.text != null) {
      setState(() {
        _messageController.text = data.text!;
      });
    }
  }

  void _processMessage() {
    if (_messageController.text.trim().isEmpty) return;
    
    setState(() => _isProcessing = true);
    
    // Simulate processing
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        Navigator.pushNamed(context, '/review_transaction');
      }
    });
  }

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
                    'Import MoMo',
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
                    // Info Card
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppTheme.darkGreenCard,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: const BoxDecoration(
                              color: AppTheme.transportBlue,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.info_outline,
                              color: AppTheme.textWhite,
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'How to import',
                                  style: AppTheme.bodyLarge.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Go to your SMS app, copy the transaction message from your MoMo provider, and paste it in the box below.',
                                  style: AppTheme.bodyMedium.copyWith(
                                    fontSize: 14,
                                    height: 1.4,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 32),

                    // Text Area
                    Container(
                      height: 320,
                      decoration: BoxDecoration(
                        color: AppTheme.darkGreenCard,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: AppTheme.textGray.withOpacity(0.2),
                        ),
                      ),
                      child: Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: TextField(
                              controller: _messageController,
                              maxLines: null,
                              expands: true,
                              style: AppTheme.bodyMedium.copyWith(
                                color: AppTheme.textWhite,
                                fontSize: 14,
                              ),
                              decoration: InputDecoration(
                                hintText: 'Example: Payment made for GHS 45.00 to UBER RIDES. Current Balance: GHS 120.00. Reference: 123456...',
                                hintStyle: AppTheme.bodySmall.copyWith(
                                  color: AppTheme.textGray,
                                  fontSize: 13,
                                  height: 1.5,
                                ),
                                border: InputBorder.none,
                              ),
                              textAlignVertical: TextAlignVertical.top,
                            ),
                          ),
                          // Paste Button
                          Positioned(
                            bottom: 12,
                            right: 12,
                            child: GestureDetector(
                              onTap: _pasteFromClipboard,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 10,
                                ),
                                decoration: BoxDecoration(
                                  color: AppTheme.darkGreen,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: AppTheme.textGray.withOpacity(0.3),
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(
                                      Icons.content_paste,
                                      color: AppTheme.textWhite,
                                      size: 18,
                                    ),
                                    const SizedBox(width: 6),
                                    Text(
                                      'PASTE',
                                      style: AppTheme.labelMedium.copyWith(
                                        fontSize: 13,
                                        letterSpacing: 0.5,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Help Text
                    Center(
                      child: Text(
                        'Transaction details will be automatically extracted from the text.',
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

            // Process Button
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _messageController.text.trim().isNotEmpty && !_isProcessing
                      ? _processMessage
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.neonGreen,
                    foregroundColor: AppTheme.black,
                    disabledBackgroundColor: AppTheme.darkGreenCard,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 0,
                  ),
                  child: _isProcessing
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(AppTheme.black),
                          ),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.auto_fix_high, color: AppTheme.black, size: 22),
                            const SizedBox(width: 8),
                            Text(
                              'Process Message',
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
}
