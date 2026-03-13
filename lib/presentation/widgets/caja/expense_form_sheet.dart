// lib/presentation/widgets/caja/expense_form_sheet.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../config/theme.dart';
import '../../../data/models/expense.dart';
import '../../../data/models/product.dart';

class ExpenseFormSheet extends StatefulWidget {
  final List<Product>                  products;
  final Future<void> Function(Expense) onSave;

  const ExpenseFormSheet({
    super.key,
    required this.products,
    required this.onSave,
  });

  @override
  State<ExpenseFormSheet> createState() => _ExpenseFormSheetState();
}

class _ExpenseFormSheetState extends State<ExpenseFormSheet> {
  ExpenseCategory _category        = ExpenseCategory.compras;
  final _descCtrl                  = TextEditingController();
  final _amountCtrl                = TextEditingController();
  final _qtyCtrl                   = TextEditingController(text: '1');
  Product?         _selectedProduct;
  bool             _saving          = false;

  @override
  void dispose() {
    _descCtrl.dispose();
    _amountCtrl.dispose();
    _qtyCtrl.dispose();
    super.dispose();
  }

  bool get _isCompras => _category == ExpenseCategory.compras;

  Future<void> _save() async {
    final amount = double.tryParse(_amountCtrl.text.replaceAll(',', '.')) ?? 0;
    if (amount <= 0) return;

    setState(() => _saving = true);

    final expense = Expense()
      ..date        = DateTime.now()
      ..amount      = amount
      ..category    = _category
      ..description = _descCtrl.text.trim()
      ..productId   = (_isCompras && _selectedProduct != null) ? _selectedProduct!.id : 0
      ..productName = (_isCompras && _selectedProduct != null) ? _selectedProduct!.name : ''
      ..quantity    = _isCompras ? (int.tryParse(_qtyCtrl.text) ?? 1) : 0;

    await widget.onSave(expense);
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.fromLTRB(
        16, 16, 16, MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40, height: 4,
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: AppTheme.border,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),

            Text('Nuevo gasto', style: theme.textTheme.headlineSmall),
            const SizedBox(height: 16),

            Text('Categoría', style: theme.textTheme.labelLarge),
            const SizedBox(height: 8),
            Row(
              children: ExpenseCategory.values.map((cat) {
                const colors = {
                  ExpenseCategory.compras:  AppTheme.info,
                  ExpenseCategory.facturas: AppTheme.warning,
                  ExpenseCategory.personal: AppTheme.secondary,
                  ExpenseCategory.otro:     AppTheme.textSecondary,
                };
                final color    = colors[cat] ?? AppTheme.textSecondary;
                final selected = _category == cat;
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 6),
                    child: GestureDetector(
                      onTap: () => setState(() => _category = cat),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 150),
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: selected
                              ? color.withValues(alpha: 0.12)
                              : AppTheme.surface,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: selected ? color : AppTheme.border,
                            width: selected ? 1.5 : 1,
                          ),
                        ),
                        child: Text(
                          cat.label,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            color:      selected ? color : AppTheme.textSecondary,
                            fontWeight: selected ? FontWeight.w700 : FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: 16),

            if (_isCompras) ...[
              Text('Producto', style: theme.textTheme.labelLarge),
              const SizedBox(height: 8),
              DropdownButtonFormField<Product>(
                initialValue: _selectedProduct,
                hint: const Text('Selecciona un producto'),
                decoration: const InputDecoration(isDense: true),
                items: widget.products
                    .map((p) => DropdownMenuItem(
                          value: p,
                          child: Text('${p.name}  (stock: ${p.stock})'),
                        ))
                    .toList(),
                onChanged: (p) {
                  setState(() => _selectedProduct = p);
                  if (p?.costPrice != null) {
                    _amountCtrl.text =
                        ((p!.costPrice! * (int.tryParse(_qtyCtrl.text) ?? 1))
                                .toStringAsFixed(2));
                  }
                },
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _qtyCtrl,
                      decoration: const InputDecoration(
                        labelText: 'Cantidad *', isDense: true,
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      onChanged: (v) {
                        final qty  = int.tryParse(v) ?? 1;
                        final cost = _selectedProduct?.costPrice;
                        if (cost != null) {
                          _amountCtrl.text = (cost * qty).toStringAsFixed(2);
                          setState(() {});
                        }
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextFormField(
                      controller: _amountCtrl,
                      decoration: const InputDecoration(
                        labelText: 'Importe total (€) *', isDense: true,
                      ),
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[\d,.]')),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _descCtrl,
                decoration: const InputDecoration(
                  labelText: 'Descripción (opcional)', isDense: true,
                ),
              ),
            ] else ...[
              TextField(
                controller: _descCtrl,
                decoration: const InputDecoration(
                  labelText: 'Descripción', isDense: true,
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _amountCtrl,
                decoration: const InputDecoration(
                  labelText: 'Importe (€) *',
                  prefixIcon: Icon(Icons.euro),
                  isDense: true,
                ),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[\d,.]')),
                ],
              ),
            ],

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _saving ? null : _save,
                child: _saving
                    ? const SizedBox(
                        height: 20, width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2, color: Colors.white,
                        ),
                      )
                    : const Text('Registrar gasto'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
