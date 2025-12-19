import 'package:flutter/material.dart';
import '../models/project_model.dart';

class PaymentsApprovalsScreen extends StatelessWidget {
  final List<Project> allProjects;

  const PaymentsApprovalsScreen({super.key, required this.allProjects});

  @override
  Widget build(BuildContext context) {
    final List<Payment> allPayments = allProjects.expand((p) => p.payments).toList();

    return allPayments.isEmpty
        ? const Center(child: Text('No payment requests found.'))
        : ListView.builder(
      itemCount: allPayments.length,
      itemBuilder: (context, index) {
        final payment = allPayments[index];
        Color statusColor = payment.approvalFlow.status == 'Approved'
            ? Colors.green
            : payment.approvalFlow.status == 'Pending'
            ? Colors.orange
            : Colors.red;

        return Card(
          margin:
          const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          child: ExpansionTile(
            leading: Icon(
              payment.approvalFlow.status == 'Approved'
                  ? Icons.check_circle
                  : Icons.pending,
              color: statusColor,
            ),
            title: Text(
                'Request ID: ${payment.paymentId}',
                style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Amount: ${payment.amount.toStringAsFixed(0)} BDT',
                    style: TextStyle(
                        color: statusColor, fontWeight: FontWeight.w600)),
                Text('Status: ${payment.approvalFlow.status}'),
              ],
            ),
            children: [
              ListTile(
                title: const Text('Requested By'),
                trailing: Text(payment.requestedBy),
              ),
              ListTile(
                title: const Text('Request Date'),
                trailing: Text(payment.requestDate),
              ),
              ListTile(
                title: const Text('Approved By'),
                trailing: Text(payment.approvalFlow.approvedBy),
              ),
              ListTile(
                title: Text('Invoices (${payment.invoices.length})'),
                trailing: Text('${payment.invoices.fold<int>(0, (sum, i) => sum + i.amount).toStringAsFixed(0)} BDT'),
              ),
            ],
          ),
        );
      },
    );
  }
}