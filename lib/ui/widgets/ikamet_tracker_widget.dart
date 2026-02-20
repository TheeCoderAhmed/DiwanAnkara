import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yc_ankara_app/l10n/app_localizations.dart';
import 'package:intl/intl.dart';

class IkametTrackerWidget extends StatefulWidget {
  const IkametTrackerWidget({super.key});

  @override
  State<IkametTrackerWidget> createState() => _IkametTrackerWidgetState();
}

class _IkametTrackerWidgetState extends State<IkametTrackerWidget> {
  DateTime? _expiryDate;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadExpiryDate();
  }

  Future<void> _loadExpiryDate() async {
    final prefs = await SharedPreferences.getInstance();
    final dateString = prefs.getString('ikamet_expiry_date');
    if (dateString != null) {
      setState(() {
        _expiryDate = DateTime.parse(dateString);
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _saveExpiryDate(DateTime date) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('ikamet_expiry_date', date.toIso8601String());
    setState(() {
      _expiryDate = date;
    });
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: now.add(const Duration(days: 180)),
      firstDate: now,
      lastDate: now.add(const Duration(days: 3650)), // 10 years
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.dark(
              primary: const Color(0xFF0D9488),
              surface: const Color(0xFF1E293B),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      await _saveExpiryDate(picked);
    }
  }

  int get _daysRemaining {
    if (_expiryDate == null) return 0;
    final now = DateTime.now();
    return _expiryDate!.difference(now).inDays;
  }

  Color get _statusColor {
    final days = _daysRemaining;
    if (days > 90) return Colors.green;
    if (days > 30) return Colors.orange;
    return Colors.red;
  }

  double get _progress {
    if (_expiryDate == null) return 0;
    const maxDays = 365.0; // Assume 1 year ikamet
    return (_daysRemaining / maxDays).clamp(0.0, 1.0);
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const SizedBox(
        height: 150,
        child: Center(child: CircularProgressIndicator()),
      );
    }

    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDark
              ? [
                  const Color(0xFF1E293B).withValues(alpha: 0.8),
                  const Color(0xFF334155).withValues(alpha: 0.6),
                ]
              : [
                  Colors.white.withValues(alpha: 0.9),
                  Colors.grey.shade50.withValues(alpha: 0.8),
                ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDark
              ? Colors.white.withValues(alpha: 0.1)
              : Colors.grey.withValues(alpha: 0.2),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: _expiryDate == null ? _buildSetDateView() : _buildCountdownView(),
    ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.1, end: 0);
  }

  Widget _buildSetDateView() {
    return Column(
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xFF0D9488).withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                LucideIcons.calendar,
                color: Color(0xFF0D9488),
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Text(
              AppLocalizations.of(context).ikametTracker,
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Text(
          AppLocalizations.of(context).ikametNoDateSet,
          style: TextStyle(color: Colors.grey.shade600),
        ),
        const SizedBox(height: 16),
        ElevatedButton.icon(
          onPressed: _pickDate,
          icon: const Icon(LucideIcons.calendar),
          label: Text(AppLocalizations.of(context).ikametSetDate),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF0D9488),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCountdownView() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: _statusColor.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    LucideIcons.calendar,
                    color: _statusColor,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  AppLocalizations.of(context).ikametTracker,
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            IconButton(
              onPressed: _pickDate,
              icon: const Icon(LucideIcons.settings, size: 20),
              color: Colors.grey.shade600,
            ),
          ],
        ),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Circular Progress
            SizedBox(
              width: 100,
              height: 100,
              child: CircularProgressIndicator(
                value: _progress,
                strokeWidth: 8,
                backgroundColor: Colors.grey.withValues(alpha: 0.2),
                valueColor: AlwaysStoppedAnimation<Color>(_statusColor),
              ),
            ),
            const SizedBox(width: 24),
            // Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$_daysRemaining ${AppLocalizations.of(context).days}',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: _statusColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    AppLocalizations.of(context).ikametExpiresIn,
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    DateFormat.yMd(
                      Localizations.localeOf(context).languageCode,
                    ).format(_expiryDate!),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: _statusColor.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      _daysRemaining > 90
                          ? AppLocalizations.of(context).ikametSafe
                          : _daysRemaining > 30
                          ? AppLocalizations.of(context).ikametWarning
                          : AppLocalizations.of(context).ikametUrgent,
                      style: TextStyle(
                        color: _statusColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
