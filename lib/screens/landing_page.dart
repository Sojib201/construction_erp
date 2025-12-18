import 'package:flutter/material.dart';
import 'package:tcl_erp/screens/payment_approval_screen.dart';
import 'package:tcl_erp/screens/project_list_screen.dart';
import 'package:tcl_erp/screens/task_team_screen.dart';

import '../models/project_model.dart';
import 'dashboard_screen.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  late Future<Company> _companyData;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _companyData = DataService.loadCompanyData();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Company>(
      future: _companyData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            body: Center(child: Text('Error loading data: ${snapshot.error}')),
          );
        } else if (snapshot.hasData) {
          final Company company = snapshot.data!;
          final List<Widget> widgetOptions = <Widget>[
            DashboardScreen(company: company),
            ProjectListScreen(projects: company.projects),
            TasksTeamsScreen(allProjects: company.projects),
            PaymentsApprovalsScreen(allProjects: company.projects),
          ];

          return Scaffold(
            appBar: AppBar(
              title: Text(company.name),
              elevation: 0,
            ),
            body: widgetOptions[_selectedIndex],
            bottomNavigationBar: BottomNavigationBar(
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.dashboard),
                  label: 'Dashboard',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.list),
                  label: 'Projects',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.assignment),
                  label: 'Tasks/Teams',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.payment),
                  label: 'Payments',
                ),
              ],
              currentIndex: _selectedIndex,
              selectedItemColor: Colors.blue,
              unselectedItemColor: Colors.grey,
              onTap: _onItemTapped,
            ),
          );
        } else {
          return const Scaffold(
            body: Center(child: Text('No data found.')),
          );
        }
      },
    );
  }
}