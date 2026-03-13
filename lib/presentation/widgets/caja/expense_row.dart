// lib/presentation/widgets/caja/expense_row.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../config/theme.dart';
import '../../../data/models/expense.dart';

class ExpenseRow extends StatelessWidget {
  final Expense      expense;
  final NumberFormat fmt;
  final DateFormat   timeFmt;
  final VoidCallback onDelete;

  const ExpenseRow({
    super.key,
    required this.expense,
    required this.fmt,
    required this.timeFmt,
    required this.onDelete,
  });

  static const _catColors = {
    ExpenseCategory.compras:  AppTheme.info,
    ExpenseCategory.facturas: AppTheme.warning,
    ExpenseCategory.personal: AppTheme.secondary,
    ExpenseCategory.otro:     AppTheme.textSecondary,
  };

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = _catColors[expense.category] ?? AppTheme.textSecondary;

    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              expense.category.label,
              style: TextStyle(
                fontSize: 11,
                color: color,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  expense.description.isNotEmpty
                      ? expense.description
                      : (expense.productName.isNotEmpty
                          ? expense.productName
                          : expense.category.label),
                  style: theme.textTheme.bodySmall,
                  overflow: TextOverflow.ellipsis,
                ),
                if (expense.quantity > 0)
                  Text(
                    '${expense.quantity} uds',
                    style: theme.textTheme.bodySmall
                        ?.copyWith(color: AppTheme.textSecondary),
                  ),
              ],
            ),
          ),
          Text(
            fmt.format(expense.amount),
            style: theme.textTheme.labelMedium
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 4),
          Text(
            timeFmt.format(expense.date),
            style: theme.textTheme.bodySmall
                ?.copyWith(color: AppTheme.textSecondary),
          ),
          IconButton(
            icon:    const Icon(Icons.delete_outline, size: 18),
            color:   AppTheme.error,
            onPressed: onDelete,
          ),
        ],
      ),
    );
  }
}
