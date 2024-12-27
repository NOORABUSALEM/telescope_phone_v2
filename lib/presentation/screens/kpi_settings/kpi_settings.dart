import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:telescope_phone_v2/core/extensions/translation_extension/Translation_extension.dart';

class KpiSettings extends StatelessWidget {
  const KpiSettings({super.key});

  final bool? isActive = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text((context).trans("KPI Settings")),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SettingsCard(
                title: (context).trans("Disable Notifications"),
                trailing:
                    Switch(value: isActive == false, onChanged: (value) {}),
              ),
              const Gap(20),
              SettingsCard(
                title: (context).trans("Set Alarm"),
                onTap: () {},
                trailing: const Icon(Icons.arrow_forward_ios_rounded),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SettingsCard extends StatelessWidget {
  SettingsCard({super.key, required this.title, this.trailing, this.onTap});

  final String title;
  void Function()? onTap;
  Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: ListTile(
        title: Text((context).trans(title)),
        onTap: onTap,
        trailing: trailing,
      ),
    );
  }
}
