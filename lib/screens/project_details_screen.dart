import 'package:flutter/material.dart';
import 'package:tcl_erp/screens/task_team_screen.dart';
import '../models/project_model.dart';

class ProjectDetailsScreen extends StatelessWidget {
  final Project project;

  const ProjectDetailsScreen({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(project.name),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Info'),
              Tab(text: 'Budget'),
              Tab(text: 'Tasks/Teams'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildInfoTab(context),
            _buildBudgetTab(context),
            TasksTeamsScreen(project: project, isDetailView: true),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoTab(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInfoCard(
            title: 'Status',
            value: project.status,
            icon: Icons.info_outline,
            color: project.status == 'Completed' ? Colors.green : Colors.blue,
          ),
          _buildInfoCard(
            title: 'Start Date',
            value: project.timeline.startDate,
            icon: Icons.calendar_today,
            color: Colors.teal,
          ),
          _buildInfoCard(
            title: 'End Date',
            value: project.timeline.endDate,
            icon: Icons.calendar_month,
            color: Colors.red,
          ),
          _buildInfoCard(
            title: 'Project Manager',
            value: project.manager.name,
            icon: Icons.person,
            color: Colors.deepPurple,
          ),
          const SizedBox(height: 10),
          Text('Manager Email: ${project.manager.email}',
              style: const TextStyle(fontSize: 14, color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _buildInfoCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: Icon(icon, color: color),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        trailing: Text(value, style: TextStyle(color: color)),
      ),
    );
  }

  Widget _buildBudgetTab(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Budget Overview',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const Divider(),
          ListTile(
            title: const Text('Total Budget'),
            trailing: Text('${project.budget.total.toStringAsFixed(0)} ${project.manager.employeeId.startsWith('CMP') ? 'BDT' : ''}', // Simplified BDT check
                style: TextStyle( color: Colors.green)),
          ),
          ListTile(
            title: const Text('Total Spent'),
            trailing: Text('${project.budget.spent.toStringAsFixed(0)} ${project.manager.employeeId.startsWith('CMP') ? 'BDT' : ''}',
                style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.red)),
          ),
          const Divider(height: 30),
          const Text('Budget Breakdown by Category',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ...project.budget.categories.map((category) =>
              _buildBudgetCategoryTile(category, context)),
        ],
      ),
    );
  }

  Widget _buildBudgetCategoryTile(BudgetCategory category, BuildContext context) {
    return ExpansionTile(
      title: Text(category.name,
          style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(
          'Allocated: ${category.allocated.toStringAsFixed(0)}, Spent: ${category.spent.toStringAsFixed(0)}'),
      children: category.subCategories.isEmpty
          ? [
        const Padding(
          padding: EdgeInsets.only(left: 15.0, bottom: 8),
          child: Text('No Sub-Categories'),
        )
      ]
          : category.subCategories
          .map((sub) => ListTile(
        contentPadding: const EdgeInsets.only(left: 30),
        title: Text(sub.name),
        subtitle: Text(
            'Allocated: ${sub.allocated.toStringAsFixed(0)}, Spent: ${sub.spent.toStringAsFixed(0)}'),
      ))
          .toList(),
    );
  }
}