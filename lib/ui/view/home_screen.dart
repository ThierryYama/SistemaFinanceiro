import 'package:financeiro/ui/widgets/summary_card.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isFilterVisible = false;

  void _toggleFilterVisibility() {
    setState(() {
      _isFilterVisible = !_isFilterVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Controle Financeiro',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(
              _isFilterVisible ? Icons.filter_list_off : Icons.filter_list,
            ),
            onPressed: _toggleFilterVisibility,
            tooltip: _isFilterVisible ? 'Ocultar Filtros' : 'Mostrar Filtros',
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.receipt_long),
            tooltip: 'Visualizar todas as transaçãoes',
          ),
        ],
      ),
      body: SummaryCard(totalIncome: 10, totalExpense: 100, balance: 10),
    );
  }
}
