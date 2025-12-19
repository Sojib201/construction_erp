import 'package:flutter/material.dart';
import '../models/project_model.dart';

class TasksTeamsScreen extends StatelessWidget {
  final Project? project;
  final List<Project> allProjects;
  final bool isDetailView;

  const TasksTeamsScreen({
    super.key,
    this.project,
    this.allProjects = const [],
    this.isDetailView = false,
  }) : assert(project != null || allProjects.length > 0);

  @override
  Widget build(BuildContext context) {

    final List<Task> tasks = isDetailView ? project!.tasks : allProjects.expand((p) => p.tasks).toList();

    final Map<String, List<Task>> tasksByStatus = {};
    for (var task in tasks) {
      final status = task.progress == 100 ? 'Completed' : 'In Progress';
      tasksByStatus.putIfAbsent(status, () => []).add(task);
    }

    final List<Team> teams = isDetailView
        ? project!.teams
        : allProjects.expand((p) => p.teams).toSet().toList();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Tasks',
              style: Theme.of(context).textTheme.headlineSmall),
          const Divider(),
          ...tasksByStatus.entries.map((entry) => _buildStatusGroup(
              context, entry.key, entry.value)),

          const SizedBox(height: 30),

          Text('Assigned Teams',
              style: Theme.of(context).textTheme.headlineSmall),
          const Divider(),
          if (teams.isEmpty)
            const Text('No teams assigned.', style: TextStyle(fontStyle: FontStyle.italic)),
          ...teams.map((team) => _buildTeamCard(context, team)),
        ],
      ),
    );
  }

  Widget _buildStatusGroup(
      BuildContext context, String status, List<Task> tasks) {
    return ExpansionTile(
      title: Text('$status Tasks (${tasks.length})',
          style: const TextStyle(fontWeight: FontWeight.bold)),
      children: tasks.map((task) => _buildTaskTile(context, task)).toList(),
    );
  }

  Widget _buildTaskTile(BuildContext context, Task task) {
    Color priorityColor = Colors.grey;
    if (task.priority == 'High') {
      priorityColor = Colors.red.shade700;
    } else if (task.priority == 'Medium') {
      priorityColor = Colors.orange.shade700;
    } else if (task.priority == 'Low') {
      priorityColor = Colors.green.shade700;
    }

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: priorityColor,
          child: Text(task.priority[0],
              style: const TextStyle(color: Colors.white)),
        ),
        title: Text(task.title),
        subtitle: Text('Assigned: ${task.assignedTeam}'),
        trailing: SizedBox(
          width: 60,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('${task.progress}%', style: const TextStyle(fontSize: 12)),
              LinearProgressIndicator(
                value: task.progress / 100,
                backgroundColor: Colors.grey.shade300,
                valueColor: AlwaysStoppedAnimation<Color>(priorityColor),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTeamCard(BuildContext context, Team team) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      elevation: 1,
      child: ExpansionTile(
        leading: const Icon(Icons.group, color: Colors.blue),
        title: Text(team.name,
            style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text('${team.members.length} Members'),
        children: team.members
            .map((member) => ListTile(
          contentPadding: const EdgeInsets.only(left: 30),
          leading: const Icon(Icons.person, size: 18),
          title: Text(member.name),
          trailing: Text(member.role),
        ))
            .toList(),
      ),
    );
  }
}