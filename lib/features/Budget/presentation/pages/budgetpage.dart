import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/utils/Customcontainer.dart';
import '../../../../core/utils/CustomButton.dart';
import '../../../../core/utils/TextField.dart';
import '../../../../core/utils/dropdownFormField.dart';
import '../../../../core/utils/bottom_sheet_helper.dart';

class budgetpage extends StatefulWidget {
  const budgetpage({super.key});

  @override
  State<budgetpage> createState() => _budgetpageState();
}

class _budgetpageState extends State<budgetpage> {
  final TextEditingController budgetController = TextEditingController();

  final CollectionReference budgetsRef =
  FirebaseFirestore.instance.collection('budgets');

  String selectedCategory = "Food";
  final List<String> categories = ["Food", "Transport", "Shopping", "Bills"];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        titleSpacing: 20,
        toolbarHeight: 65,
        title: Text(
          "My Expenses",
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
        backgroundColor: Colors.black,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            height: 1,
            color: Colors.grey.withOpacity(0.4), // subtle border
          ),
        ),
      ),

      body: StreamBuilder<QuerySnapshot>(
        stream: budgetsRef.orderBy('createdAt', descending: true).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text("Error", style: TextStyle(color: Colors.white)),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: Color(0xFF72E369)),
            );
          }

          final docs = snapshot.data!.docs;

          if (docs.isEmpty) {
            return const Center(
              child: Text(
                "No Budgets Yet",
                style: TextStyle(color: Colors.white70),
              ),
            );
          }

          return ListView.builder(
            padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
            itemCount: docs.length,
            itemBuilder: (context, index) {
              final doc = docs[index];
              final data = doc.data() as Map<String, dynamic>;

              final total = data['total'] as num;
              final spent = data['spent'] as num;
              final progress = spent / total;

              return Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.06,
                  vertical: screenHeight * 0.01,
                ),
                child: Customcontainer(
                  title: data['title'],
                  remainingText:
                  "${(total - spent).toInt()} remaining",
                  progressText:
                  "${spent.toInt()} of ${total.toInt()}",
                  progressValue: progress,
                  onDelete: () => _deleteBudget(doc.id),
                  onEdit: () => _showEditBudgetBottomSheet(doc.id, data),
                ),
              );
            },
          );
        },
      ),

      floatingActionButton: CustomButton(
        text: "+ Add Budget",
        width: screenWidth * 0.45,
        height: screenHeight * 0.065,
        borderRadius: screenWidth * 0.05,
        onPressed: _showAddBudgetBottomSheet,
      ),
    );
  }

  void _showAddBudgetBottomSheet() {
    budgetController.clear();

    openCustomSheet(
      context: context,
      title: "Add Budget",
      fields: [
        CustomDropdownFormField(
          selectedCategory: selectedCategory,
          categories: categories,
          onChanged: (value) {
            setState(() => selectedCategory = value);
          },
        ),
        const SizedBox(height: 15),
        CustomTextField(
          label: "Budget Amount",
          controller: budgetController,
          keyboardType: TextInputType.number,
        ),
      ],
      actionText: "Save",
      onAction: () async {
        await budgetsRef.add({
          "title": selectedCategory,
          "total": double.parse(budgetController.text),
          "spent": 0,
          "createdAt": Timestamp.now(),
        });

        Navigator.pop(context);
      },
    );
  }

  void _showEditBudgetBottomSheet(
      String docId, Map<String, dynamic> data) {

    selectedCategory = data['title'];
    budgetController.text = data['total'].toString();

    openCustomSheet(
      context: context,
      title: "Edit Budget",
      fields: [
        CustomDropdownFormField(
          selectedCategory: selectedCategory,
          categories: categories,
          onChanged: (value) {
            setState(() => selectedCategory = value);
          },
        ),
        const SizedBox(height: 15),
        CustomTextField(
          label: "Budget Amount",
          controller: budgetController,
          keyboardType: TextInputType.number,
        ),
      ],
      actionText: "Update",
      onAction: () async {
        await budgetsRef.doc(docId).update({
          "title": selectedCategory,
          "total": double.parse(budgetController.text),
        });

        Navigator.pop(context);
      },
    );
  }

  void _deleteBudget(String docId) async {
    await budgetsRef.doc(docId).delete();
  }
}
