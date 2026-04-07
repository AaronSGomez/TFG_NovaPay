// lib/presentation/widgets/caja/top_products_card.dart
import 'package:flutter/material.dart';
import '../../../config/theme.dart';

class TopProductsCard extends StatelessWidget {
  final Map<String, int> products;
  const TopProductsCard({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final sorted = products.entries.toList()..sort((a, b) => b.value.compareTo(a.value));
    final top = sorted.where((e) => e.value > 0).take(5).toList();
    final maxVal = top.isEmpty ? 0 : top.first.value;

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
          Text('Más vendidos hoy', style: theme.textTheme.labelLarge),
          const SizedBox(height: 8),
          if (top.isEmpty)
            Text(
              'Aún no hay productos vendidos hoy.',
              style: theme.textTheme.bodySmall?.copyWith(color: AppTheme.textSecondary),
            ),
          ...top.map(
            (e) => Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                children: [
                  SizedBox(
                    width: 100,
                    child: Text(e.key, style: theme.textTheme.bodySmall, overflow: TextOverflow.ellipsis),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                        value: maxVal <= 0 ? 0 : (e.value / maxVal).clamp(0, 1),
                        minHeight: 8,
                        backgroundColor: AppTheme.border,
                        color: AppTheme.primary,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text('${e.value}', style: theme.textTheme.labelMedium?.copyWith(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
