import 'package:flutter/material.dart';
import '../models/project_model.dart';
import '../widgets/summary_card.dart';

class DashboardScreen extends StatelessWidget {
  final Company company;

  const DashboardScreen({super.key, required this.company});

  @override
  Widget build(BuildContext context) {
    final totalProjects = company.projects.length;
    final totalBudget = company.projects
        .fold<int>(0, (sum, project) => sum + project.budget.total);
    final totalSpent = company.projects
        .fold<int>(0, (sum, project) => sum + project.budget.spent);
    final totalTasks = company.projects
        .fold<int>(0, (sum, project) => sum + project.tasks.length);
    final totalPendingApprovals = company.projects.fold<int>(0, (sum, project) => sum +
            project.payments.where((p) => p.approvalFlow.status == 'Pending').length);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Welcome to ${company.name}',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade800,
            ),
          ),
          const SizedBox(height: 20),

          Card(
            color: Colors.blue.shade50,
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Aggregated Summary',
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold)),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.account_balance_wallet,
                        color: Colors.green),
                    title: const Text('Total Budget'),
                    trailing: Text(totalBudget.toString(),
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  ListTile(
                    leading:
                    const Icon(Icons.payments_outlined, color: Colors.red),
                    title: const Text('Total Spent'),
                    trailing: Text(totalSpent.toString(),
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),

          Text('Quick Summary',
              style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 10),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            children: [
              SummaryCard(
                title: 'Total Projects',
                value: totalProjects.toString(),
                icon: Icons.business,
                color: Colors.deepPurple,
              ),
              SummaryCard(
                title: 'Total Tasks',
                value: totalTasks.toString(),
                icon: Icons.checklist,
                color: Colors.orange,
              ),
              SummaryCard(
                title: 'In Progress',
                value: company.projects
                    .where((p) => p.status == 'In Progress')
                    .length
                    .toString(),
                icon: Icons.trending_up,
                color: Colors.teal,
              ),
              SummaryCard(
                title: 'Pending Approvals',
                value: totalPendingApprovals.toString(),
                icon: Icons.access_time,
                color: Colors.red,
              ),
            ],
          ),
        ],
      ),
    );
  }
}