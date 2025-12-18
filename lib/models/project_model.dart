import 'dart:convert';
import '../data/data.dart';


class Company {
  final String companyId;
  final String name;
  final String currency;
  final HeadOffice headOffice;
  final List<Project> projects;

  Company({
    required this.companyId,
    required this.name,
    required this.currency,
    required this.headOffice,
    required this.projects,
  });

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      companyId: json['companyId'] ?? '',
      name: json['name'] ?? '',
      currency: json['currency'] ?? '',
      headOffice: HeadOffice.fromJson(json['headOffice'] ?? {}),
      projects: (json['projects'] as List<dynamic>?)
          ?.map((p) => Project.fromJson(p))
          .toList() ??
          [],
    );
  }
}

class HeadOffice {
  final String address;
  final Contact contact;

  HeadOffice({required this.address, required this.contact});

  factory HeadOffice.fromJson(Map<String, dynamic> json) {
    return HeadOffice(
      address: json['address'] ?? '',
      contact: Contact.fromJson(json['contact'] ?? {}),
    );
  }
}

class Contact {
  final String phone;
  final String email;

  Contact({required this.phone, required this.email});

  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
      phone: json['phone'] ?? '',
      email: json['email'] ?? '',
    );
  }
}

class Project {
  final String projectId;
  final String name;
  final String status;
  final Timeline timeline;
  final Manager manager;
  final List<Team> teams;
  final Budget budget;
  final List<Task> tasks;
  final List<Payment> payments;
  final List<Risk> risks;

  Project({
    required this.projectId,
    required this.name,
    required this.status,
    required this.timeline,
    required this.manager,
    required this.teams,
    required this.budget,
    required this.tasks,
    required this.payments,
    required this.risks,
  });

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      projectId: json['projectId'] ?? '',
      name: json['name'] ?? '',
      status: json['status'] ?? '',
      timeline: Timeline.fromJson(json['timeline'] ?? {}),
      manager: Manager.fromJson(json['manager'] ?? {}),
      teams: (json['teams'] as List<dynamic>?)
          ?.map((t) => Team.fromJson(t))
          .toList() ??
          [],
      budget: Budget.fromJson(json['budget'] ?? {}),
      tasks: (json['tasks'] as List<dynamic>?)
          ?.map((t) => Task.fromJson(t))
          .toList() ??
          [],
      payments: (json['payments'] as List<dynamic>?)
          ?.map((p) => Payment.fromJson(p))
          .toList() ??
          [],
      risks: (json['risks'] as List<dynamic>?)
          ?.map((r) => Risk.fromJson(r))
          .toList() ??
          [],
    );
  }

  double get utilizationPercent {
    if (budget.total == 0) return 0.0;
    return (budget.spent / budget.total) * 100;
  }
}

class Timeline {
  final String startDate;
  final String endDate;
  final List<Milestone> milestones;

  Timeline({
    required this.startDate,
    required this.endDate,
    required this.milestones,
  });

  factory Timeline.fromJson(Map<String, dynamic> json) {
    return Timeline(
      startDate: json['startDate'] ?? '',
      endDate: json['endDate'] ?? '',
      milestones: (json['milestones'] as List<dynamic>?)
          ?.map((m) => Milestone.fromJson(m))
          .toList() ??
          [],
    );
  }
}

class Milestone {
  final String milestoneId;
  final String title;
  final String status;

  Milestone({
    required this.milestoneId,
    required this.title,
    required this.status,
  });

  factory Milestone.fromJson(Map<String, dynamic> json) {
    return Milestone(
      milestoneId: json['milestoneId'] ?? '',
      title: json['title'] ?? '',
      status: json['status'] ?? '',
    );
  }
}

class Manager {
  final String employeeId;
  final String name;
  final String designation;
  final String email;

  Manager({
    required this.employeeId,
    required this.name,
    required this.designation,
    required this.email,
  });

  factory Manager.fromJson(Map<String, dynamic> json) {
    return Manager(
      employeeId: json['employeeId'] ?? '',
      name: json['name'] ?? '',
      designation: json['designation'] ?? '',
      email: json['email'] ?? '',
    );
  }
}

class Team {
  final String teamId;
  final String name;
  final List<Member> members;

  Team({required this.teamId, required this.name, required this.members});

  factory Team.fromJson(Map<String, dynamic> json) {
    return Team(
      teamId: json['teamId'] ?? '',
      name: json['name'] ?? '',
      members: (json['members'] as List<dynamic>?)
          ?.map((m) => Member.fromJson(m))
          .toList() ??
          [],
    );
  }
}

class Member {
  final String name;
  final String role;

  Member({required this.name, required this.role});

  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
      name: json['name'] ?? '',
      role: json['role'] ?? '',
    );
  }
}

class Budget {
  final int total;
  final int spent;
  final List<BudgetCategory> categories;

  Budget({required this.total, required this.spent, required this.categories});

  factory Budget.fromJson(Map<String, dynamic> json) {
    return Budget(
      total: json['total'] ?? 0,
      spent: json['spent'] ?? 0,
      categories: (json['categories'] as List<dynamic>?)
          ?.map((c) => BudgetCategory.fromJson(c))
          .toList() ??
          [],
    );
  }
}

class BudgetCategory {
  final String name;
  final int allocated;
  final int spent;
  final List<SubCategory> subCategories;

  BudgetCategory({
    required this.name,
    required this.allocated,
    required this.spent,
    required this.subCategories,
  });

  factory BudgetCategory.fromJson(Map<String, dynamic> json) {
    return BudgetCategory(
      name: json['name'] ?? '',
      allocated: json['allocated'] ?? 0,
      spent: json['spent'] ?? 0,
      subCategories: (json['subCategories'] as List<dynamic>?)
          ?.map((s) => SubCategory.fromJson(s))
          .toList() ??
          [],
    );
  }
}

class SubCategory {
  final String name;
  final int allocated;
  final int spent;

  SubCategory({
    required this.name,
    required this.allocated,
    required this.spent,
  });

  factory SubCategory.fromJson(Map<String, dynamic> json) {
    return SubCategory(
      name: json['name'] ?? '',
      allocated: json['allocated'] ?? 0,
      spent: json['spent'] ?? 0,
    );
  }
}

class Task {
  final String taskId;
  final String title;
  final String assignedTeam;
  final String priority;
  final int progress;
  final List<SubTask> subTasks;
  final List<ActivityLog> activityLogs;

  Task({
    required this.taskId,
    required this.title,
    required this.assignedTeam,
    required this.priority,
    required this.progress,
    required this.subTasks,
    required this.activityLogs,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      taskId: json['taskId'] ?? '',
      title: json['title'] ?? '',
      assignedTeam: json['assignedTeam'] ?? '',
      priority: json['priority'] ?? '',
      progress: json['progress'] ?? 0,
      subTasks: (json['subTasks'] as List<dynamic>?)
          ?.map((s) => SubTask.fromJson(s))
          .toList() ??
          [],
      activityLogs: (json['activityLogs'] as List<dynamic>?)
          ?.map((a) => ActivityLog.fromJson(a))
          .toList() ??
          [],
    );
  }
}

class SubTask {
  final String subTaskId;
  final String title;
  final String status;

  SubTask({
    required this.subTaskId,
    required this.title,
    required this.status,
  });

  factory SubTask.fromJson(Map<String, dynamic> json) {
    return SubTask(
      subTaskId: json['subTaskId'] ?? '',
      title: json['title'] ?? '',
      status: json['status'] ?? '',
    );
  }
}

class ActivityLog {
  final String date;
  final String updatedBy;
  final String remark;

  ActivityLog({
    required this.date,
    required this.updatedBy,
    required this.remark,
  });

  factory ActivityLog.fromJson(Map<String, dynamic> json) {
    return ActivityLog(
      date: json['date'] ?? '',
      updatedBy: json['updatedBy'] ?? '',
      remark: json['remark'] ?? '',
    );
  }
}

class Payment {
  final String paymentId;
  final int amount;
  final String requestedBy;
  final String requestDate;
  final List<Invoice> invoices;
  final ApprovalFlow approvalFlow;

  Payment({
    required this.paymentId,
    required this.amount,
    required this.requestedBy,
    required this.requestDate,
    required this.invoices,
    required this.approvalFlow,
  });

  factory Payment.fromJson(Map<String, dynamic> json) {
    return Payment(
      paymentId: json['paymentId'] ?? '',
      amount: json['amount'] ?? 0,
      requestedBy: json['requestedBy'] ?? '',
      requestDate: json['requestDate'] ?? '',
      invoices: (json['invoices'] as List<dynamic>?)
          ?.map((i) => Invoice.fromJson(i))
          .toList() ??
          [],
      approvalFlow: ApprovalFlow.fromJson(json['approvalFlow'] ?? {}),
    );
  }
}

class Invoice {
  final String invoiceId;
  final String vendor;
  final int amount;

  Invoice({
    required this.invoiceId,
    required this.vendor,
    required this.amount,
  });

  factory Invoice.fromJson(Map<String, dynamic> json) {
    return Invoice(
      invoiceId: json['invoiceId'] ?? '',
      vendor: json['vendor'] ?? '',
      amount: json['amount'] ?? 0,
    );
  }
}

class ApprovalFlow {
  final String approvedBy;
  final String approvedDate;
  final String status;

  ApprovalFlow({
    required this.approvedBy,
    required this.approvedDate,
    required this.status,
  });

  factory ApprovalFlow.fromJson(Map<String, dynamic> json) {
    return ApprovalFlow(
      approvedBy: json['approvedBy'] ?? '',
      approvedDate: json['approvedDate'] ?? '',
      status: json['status'] ?? '',
    );
  }
}

class Risk {
  final String riskId;
  final String description;
  final String severity;
  final String mitigation;

  Risk({
    required this.riskId,
    required this.description,
    required this.severity,
    required this.mitigation,
  });

  factory Risk.fromJson(Map<String, dynamic> json) {
    return Risk(
      riskId: json['riskId'] ?? '',
      description: json['description'] ?? '',
      severity: json['severity'] ?? '',
      mitigation: json['mitigation'] ?? '',
    );
  }
}


class DataService {
  static Future<Company> loadCompanyData() async {
    await Future.delayed(const Duration(milliseconds: 50));
    final data = json.decode(companyJsonString);
    return Company.fromJson(data['company']);
  }
}