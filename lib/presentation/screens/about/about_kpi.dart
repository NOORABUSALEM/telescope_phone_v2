import 'package:flutter/material.dart';
import 'package:telescope_phone_v2/core/extensions/translation_extension/Translation_extension.dart';

import '../../../data/models/kpiInfo.dart';

class AboutKpi extends StatelessWidget {
  const AboutKpi({super.key});

  @override
  Widget build(BuildContext context) {
    // Retrieve KpiInfo object from arguments
    KpiInfo kpiItem =
    ModalRoute.of(context)!.settings.arguments as KpiInfo;

    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text((context).trans("About KPI")),
        centerTitle: true,
        automaticallyImplyLeading: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0), // Add padding
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // KPI Description
            Text(
              kpiItem.getLocalizedDescription(context),
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 30),

            // Data Source Section
             Text((context).trans( "Data Source:"),
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              kpiItem.source ?? (context).trans( "Unknown"),
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 30),

            // How to Measure Section
             Text(
              (context).trans( "How to Measure:"),
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            const Text(
              "Track the number of customers who deactivate their subscriptions over a specific period (e.g., month, quarter).",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 30),

            // Formula Section
            const Text(
              "Formula:",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            const Text(
              r"""
              Churn Rate = (Customers Lost During a Period / Total Customers at the Beginning of the Period) × 100
              """,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
