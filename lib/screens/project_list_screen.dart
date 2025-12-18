import 'package:flutter/material.dart';
import 'package:tcl_erp/screens/project_details_screen.dart';
import '../models/project_model.dart';

class ProjectListScreen extends StatelessWidget {
  final List<Project> projects;

  const ProjectListScreen({super.key, required this.projects});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: projects.length,
      itemBuilder: (context, index) {
        final project = projects[index];
        final utilization = project.utilizationPercent;

        Color statusColor = Colors.grey;
        if (project.status == 'Completed') {
          statusColor = Colors.green;
        } else if (project.status == 'In Progress') {
          statusColor = Colors.blue;
        } else if (project.status == 'Planning') {
          statusColor = Colors.orange;
        }

        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          child: ListTile(
            title: Text(project.name,
                style: const TextStyle(fontWeight: FontWeight.bold)),

            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: statusColor, width: 0.5),
                  ),
                  child: Text(
                    project.status,
                    style: TextStyle(color: statusColor, fontSize: 12),
                  ),
                ),
                const SizedBox(height: 4),
                Text('Manager: ${project.manager.name}'),
                const SizedBox(height: 8),

                Text(
                  'Budget Utilization: ${utilization.toStringAsFixed(1)}%',
                  style: const TextStyle(fontSize: 12),
                ),
                LinearProgressIndicator(
                  value: utilization / 100,
                  backgroundColor: Colors.grey.shade300,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    utilization < 70 ? Colors.green : utilization < 95 ? Colors.orange : Colors.red,
                  ),
                ),
                const SizedBox(height: 4),
              ],
            ),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) =>
                      ProjectDetailsScreen(project: project),
                ),
              );
            },
          ),
        );
      },
    );
  }
}