import 'package:financeiro/utils/formatter.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class SummaryChart extends StatelessWidget {
  final double totalIncome;
  final double totalExpense;

  const SummaryChart(
      {super.key, required this.totalIncome, required this.totalExpense});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Icon(
                Icons.pie_chart,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(width: 8),
              Text(
                'Receitas vs Despesas',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        if (totalIncome == 0 && totalExpense == 0)
          _buildEmptyState(context)
        else
          Container(
            height: 160,
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(flex: 3, child: _buildPieChart(context)),
                const SizedBox(width: 10),
                Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildLegendItem(
                        context,
                        'Receitas',
                        Theme.of(context).colorScheme.secondary,
                        totalIncome,
                      ),
                      const SizedBox(height: 16),
                      _buildLegendItem(context, 'Despesas',
                          Theme.of(context).colorScheme.tertiary, totalExpense),
                    ],
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildPieChart(BuildContext context) {
    return PieChart(
      PieChartData(
        sectionsSpace: 2,
        centerSpaceRadius: 30,
        sections: [
          PieChartSectionData(
            value: totalIncome,
            title: '',
            radius: 60,
            color: Theme.of(context).colorScheme.secondary,
            showTitle: false,
          ),
          PieChartSectionData(
            value: totalExpense,
            title: '',
            radius: 60,
            color: Theme.of(context).colorScheme.tertiary,
            showTitle: false,
          ),
        ],
        borderData: FlBorderData(show: false),
        pieTouchData: PieTouchData(enabled: false),
      ),
    );
  }

  Widget _buildLegendItem(
    BuildContext context,
    String title,
    Color color,
    double amount,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: [
            Container(width: 16, height: 16, color: color),
            const SizedBox(width: 8),
            Expanded(
              child: Text(title, style: Theme.of(context).textTheme.bodyLarge),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(width: 25),
            Text(
              Formatter.formatCurrency(amount),
              style: Theme.of(
                context,
              ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Container(
      height: 200,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.insert_chart, size:48, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            'Sem transações cadastradas',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
          ),
          const SizedBox(height: 8),
          Text(
            'Adicione transações para visualizar o gráfico',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }
}
