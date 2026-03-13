// lib/presentation/widgets/caja/expense_category_breakdown.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../config/theme.dart';
import '../../../data/models/expense.dart';
import '../../controllers/expense_controller.dart';

class ExpenseCategoryBreakdown extends StatelessWidget {
  final ExpenseController expenseCtrl;
  final NumberFormat      fmt;

  const ExpenseCategoryBreakdown({
    super.key,
    required this.expenseCtrl,
    required this.fmt,
  });

  static const _colors = {
    ExpenseCategory.compras:  AppTheme.info,
    ExpenseCategory.facturas: AppTheme.warning,
    ExpenseCategory.personal: AppTheme.secondary,
    ExpenseCategory.otro:     AppTheme.textSecondary,
  };

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Gastos por categoría', style: theme.textTheme.labelLarge),
          const SizedBox(height: 8),
          ...ExpenseCategory.values.map((cat) {
            final amount = expenseCtrl.totalByCategory(cat);
            if (amount == 0) return const SizedBox.shrink();
            final color = _colors[cat] ?? AppTheme.textSecondary;
            return Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                children: [
                  Container(
                    width: 10, height: 10,
                    decoration: BoxDecoration(
                      color: color, shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(cat.label, style: theme.textTheme.bodySmall),
                  ),
                  Text(
                    fmt.format(amount),
                    style: theme.textTheme.labelMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
