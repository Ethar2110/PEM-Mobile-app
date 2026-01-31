import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/Custom_bottom_sheet.dart';
import '../../../../core/utils/Customcontainer.dart';
import '../../../../core/utils/TextField.dart';
import '../../../../core/utils/bottom_sheet_helper.dart';
import '../../../../core/utils/customButton.dart';
import '../../../../core/utils/dropdownFormField.dart';
import '../../../../core/utils/summaryContainer.dart';
import '../../domain/entities/expense.dart';
import '../bloc/expense_cubit.dart';

class Expensespage extends StatefulWidget {
  const Expensespage({super.key});

  @override
  State<Expensespage> createState() => _ExpensespageState();
}

class _ExpensespageState extends State<Expensespage> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  final ExpenseDate = TextEditingController();
  final detailsController = TextEditingController();


  String selectedCategory = "Food";

  final List<String> categories = [
    "Food",
    "Transport",
    "Entertainment",
    "Shopping",
  ];

  // void _saveExpense() {
  //   if (titleController.text.isEmpty || amountController.text.isEmpty) {
  //     return;
  //   }
  //
  //   final expense = Expense(
  //     id: DateTime.now().toString(),
  //     title: titleController.text,
  //     category: selectedCategory,
  //     details: detailsController,
  //     date: DateTime.now(),
  //     amount: double.parse(amountController.text),
  //   );
  // }

  void _openEditExpenseSheet(Expense expense) {
    detailsController.text = expense.details;
    titleController.text = expense.title;
    amountController.text = expense.amount.toString();
    ExpenseDate.text = "${expense.date.day}-${expense.date.month}-${expense.date.year}";
    selectedCategory = expense.category;

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    openCustomSheet(
      context: context,
      title: "Edit Expense",
          fields: [
            CustomDropdownFormField(
              selectedCategory: selectedCategory,
              categories: categories,
              onChanged: (value) {
                setState(() {
                  selectedCategory = value;
                  titleController.text = value;
                });
              },
            ),
            SizedBox(height: screenHeight * 0.015),
            CustomTextField(
              label: "Details",
              isPassword: false,
              controller: detailsController,
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
              controller: ExpenseDate,
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
                    ExpenseDate.text =
                    "${pickedDate.day}-${pickedDate.month}-${pickedDate.year}";
                  });
                }
              },
            )
          ],
          actionText: "Save",
          onAction: () {
            Navigator.of(context).pop();
          },
        );

  }

  void _openAddExpenseSheet() {
    final screenHeight = MediaQuery.of(context).size.height;

    detailsController.clear();
    amountController.clear();
    ExpenseDate.clear();

    openCustomSheet(
      context: context,
      title: "Add Expense",
          fields: [
            CustomDropdownFormField(
              selectedCategory: selectedCategory,
              categories: categories,
              onChanged: (value) {
                setState(() {
                  selectedCategory = value;
                  titleController.text = value; // optional
                });
              },
            ),
            SizedBox(height: screenHeight * 0.015),
            CustomTextField(
              label: "Details",
              isPassword: false,
              controller: detailsController,
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
              controller: ExpenseDate,
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
                          primary:  Color(0xFF72E369),
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
                    ExpenseDate.text =
                    "${pickedDate.day}-${pickedDate.month}-${pickedDate.year}";
                  });
                }
              },
            )
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
          "My Expenses",
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
            SummaryCard(
              title: "Total Spent this month",
              value: "110.56",
            ),
            SizedBox(height: screenHeight * 0.02),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Recent Transactions",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: screenWidth * 0.05,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
            Expanded(
              child: BlocBuilder<ExpenseCubit, List<Expense>>(
                builder: (context, expenses) {
                  return ListView.builder(
                    itemCount: expenses.length,
                    itemBuilder: (_, index) {
                      final e = expenses[index];
                      return Padding(
                        padding: EdgeInsets.only(bottom: screenHeight * 0.015),
                        child: Customcontainer(
                          title: e.details,
                          remainingText: "${e.date.day}.${e.category}",
                          remainingFontSize: 16,
                          price: e.amount.toStringAsFixed(2),
                          onEdit: () => _openEditExpenseSheet(e),
                          onDelete: () {},
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding:EdgeInsets.only(
          left: screenWidth * 0.04,
          bottom: screenHeight * 0.10,
        ),
        child: CustomButton(
          text: "+ Add Expense",
          width: screenWidth * 0.45,
          height: screenHeight * 0.065,
          onPressed: _openAddExpenseSheet,
          borderRadius: screenWidth * 0.05,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
