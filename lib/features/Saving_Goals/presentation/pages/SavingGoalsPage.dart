import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled4/features/Expenses/data/savings_local_datasource.dart';
import '../../../../core/utils/Custom_bottom_sheet.dart';
import '../../../../core/utils/Customcontainer.dart';
import '../../../../core/utils/TextField.dart';
import '../../../../core/utils/bottom_sheet_helper.dart';
import '../../../../core/utils/customButton.dart';
import '../../../../core/utils/dropdownFormField.dart';
import '../../../../core/utils/summaryContainer.dart';
import '../../../Expenses/domain/entities/savingGoals.dart';

class SavingGoalspage extends StatefulWidget {
  const SavingGoalspage({super.key});

  @override
  State<SavingGoalspage> createState() => _SavingGoalspageState();
}

class _SavingGoalspageState extends State<SavingGoalspage> {
  final goalController = TextEditingController();
  final amountController = TextEditingController();
  final targetDate = TextEditingController();

  void _openEditGoalSheet(SavingGoal goal) {
    goalController.text = goal.title;
    amountController.text = goal.targetAmount.toString();
    targetDate.text = "${goal.targetDate.day}-${goal.targetDate.month}-${goal.targetDate.year}";

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    openCustomSheet(
      context: context,
      title: "Edit Expense",
      fields: [
        CustomTextField(
          label: "Goal",
          isPassword: false,
          controller: goalController,
        ),
        SizedBox(height: screenHeight * 0.015),
        CustomTextField(
          label: "Amount",
          isPassword: false,
          controller: amountController,
          keyboardType: TextInputType.phone,
        ),
        SizedBox(height: screenHeight * 0.015),
        CustomTextField(
          label: "Target Date",
          controller: targetDate,
          onTap: () async {
            final pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2100),
              builder: (context, child) {
                return Theme(
                  data: Theme.of(context).copyWith(
                    colorScheme: ColorScheme.dark(
                      primary: Colors.green,
                      onPrimary: Colors.white,
                      surface: const Color(0xFF101010),
                      onSurface: Colors.white,
                    ),
                    dialogBackgroundColor: const Color(0xFF101010),
                  ),
                  child: child!,
                );
              },
            );
            if (pickedDate != null) {
              setState(() {
                targetDate.text =
                    "${pickedDate.day}-${pickedDate.month}-${pickedDate.year}";
              });
            }
          },
        ),
      ],
      actionText: "Save",
      onAction: () {
        Navigator.of(context).pop();
      },
    );
  }

  void _openAddGoalSheet() {
    final screenHeight = MediaQuery.of(context).size.height;

    goalController.clear();
    amountController.clear();
    targetDate.clear();

    openCustomSheet(
      context: context,
      title: "Add Expense",
      fields: [
        CustomTextField(
          label: "Goal",
          isPassword: false,
          controller: goalController,
        ),
        SizedBox(height: screenHeight * 0.015),
        CustomTextField(
          label: "Amount",
          isPassword: false,
          controller: amountController,
          keyboardType: TextInputType.phone,
        ),
        SizedBox(height: screenHeight * 0.015),
        CustomTextField(
          label: "Date",
          controller: targetDate,
          onTap: () async {
            final pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2100),
              builder: (context, child) {
                return Theme(
                  data: Theme.of(context).copyWith(
                    colorScheme: ColorScheme.dark(
                      primary: Colors.green,
                      onPrimary: Colors.white,
                      surface: const Color(0xFF101010),
                      onSurface: Colors.white,
                    ),
                    dialogBackgroundColor: const Color(0xFF101010),
                  ),
                  child: child!,
                );
              },
            );
            if (pickedDate != null) {
              setState(() {
                targetDate.text =
                    "${pickedDate.day}-${pickedDate.month}-${pickedDate.year}";
              });
            }
          },
        ),
      ],
      actionText: "Save",
      // onAction: _saveExpense,
      onAction: () {
        Navigator.of(context).pop();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        titleSpacing: screenWidth * 0.05,
        toolbarHeight: screenHeight * 0.08,
        title: Text(
          "Saving Goals",
          style: TextStyle(color: Colors.white, fontSize: screenWidth * 0.06),
        ),
        backgroundColor: Colors.black,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(screenHeight * 0.001),
          child: Container(
            height: screenHeight * 0.001,
            color: Colors.grey.withOpacity(0.4),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(screenWidth * 0.04),
        child: Column(
          children: [
            SummaryCard(title: "Total Saved", value: "\$110.56"),
            SizedBox(height: screenHeight * 0.02),
            Expanded(
              child: ListView.builder(
                itemCount: savingGoals.length,
                itemBuilder: (_, index) {
                  final e = savingGoals[index];
                  return Padding(
                    padding: EdgeInsets.only(bottom: screenHeight * 0.015),
                    child: Customcontainer(
                      title: e.title,
                      remainingText: "${(e.targetAmount - e.currentAmount).toStringAsFixed(0)} remaining",
                      remainingFontSize: 14,
                      progressText:   "${e.currentAmount.toStringAsFixed(0)} / ${e.targetAmount.toStringAsFixed(0)} EG",
                      progressValue: e.progress,
                      targetDate:
                          "${e.targetDate.day}/${e.targetDate.month}/${e.targetDate.year}",

                      statusText: e.status,

                      onEdit: () => _openEditGoalSheet(e),
                      onDelete: () {},
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),

      floatingActionButton: Padding(
        padding: EdgeInsets.only(
          left: screenWidth * 0.04,
          bottom: screenHeight * 0.0,
        ),
        child: CustomButton(
          text: "+ Add Goal",
          width: screenWidth * 0.45,
          height: screenHeight * 0.065,
          onPressed: _openAddGoalSheet,
          borderRadius: screenWidth * 0.05,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
