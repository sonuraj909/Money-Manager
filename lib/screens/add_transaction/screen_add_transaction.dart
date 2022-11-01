import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_time_patterns.dart';
import 'package:money_manager/constants.dart';
import 'package:money_manager/db/category/category_db.dart';
import 'package:money_manager/db/transaction/transaction_db.dart';
import 'package:money_manager/models/category/category_model.dart';
import 'package:money_manager/models/transaction/transaction_model.dart';
import 'package:money_manager/screens/add_transaction/screen_add_transaction.dart';
import 'package:flutter/src/material/date_picker.dart';
import 'package:money_manager/screens/add_transaction/screen_add_transaction.dart';

import '../category/category_add_popup.dart';

class ScreenaddTranscation extends StatefulWidget {
  static const routeName = 'add-transaction';
  const ScreenaddTranscation({Key? key}) : super(key: key);

  @override
  State<ScreenaddTranscation> createState() => _ScreenaddTranscationState();
}

class _ScreenaddTranscationState extends State<ScreenaddTranscation> {
  DateTime? _selectedDate;
  CategoryType? _selectedCategorytype;
  CategoryModel? _selectedCategoryModel;
  String? _categoryID;

  final _purposeTextEditingController = TextEditingController();
  final _amountTextEditingController = TextEditingController();

  @override
  void initState() {
    _selectedCategorytype = CategoryType.income;
    super.initState();
  }

/*purpose
Date
amount
Income/Expense
categorytype
 */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back_ios_new_rounded),
                ),
              ),
              kHeight30,
              Text(
                'How much did you spend?',
                style: TextStyle(
                  fontSize: 20,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                ),
              ),
              kHeight,
              // purpose
              TextFormField(
                controller: _purposeTextEditingController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  hintText: 'Purpose',
                ),
              ),
              // amount
              TextFormField(
                controller: _amountTextEditingController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: 'Amount',
                ),
              ),
              kHeight,
              //calender
              TextButton.icon(
                onPressed: () async {
                  final _selectedDateTemp = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate:
                        DateTime.now().subtract(const Duration(days: 30)),
                    lastDate: DateTime.now(),
                  );
                  if (_selectedDateTemp == null) {
                    return;
                  } else {
                    print(_selectedDateTemp.toString());
                    setState(() {
                      _selectedDate = _selectedDateTemp;
                    });
                  }
                },
                icon: const Icon(Icons.calendar_today),
                label: Text(
                  _selectedDate == null
                      ? 'Select Date'
                      : _selectedDate!.toString(),
                ),
              ),
              kHeight,
              // category
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      Radio(
                        value: CategoryType.income,
                        groupValue: _selectedCategorytype,
                        onChanged: (newValue) {
                          setState(() {
                            _selectedCategorytype = CategoryType.income;
                            _categoryID = null;
                          });
                        },
                      ),
                      Text('Income'),
                    ],
                  ),
                  Row(
                    children: [
                      Radio(
                        value: CategoryType.expense,
                        groupValue: _selectedCategorytype,
                        onChanged: (newValue) {
                          setState(() {
                            _selectedCategorytype = CategoryType.expense;
                            _categoryID = null;
                          });
                        },
                      ),
                      Text('Expense'),
                    ],
                  ),
                ],
              ),
              kHeight,
              // category type
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  DropdownButton<String>(
                    hint: const Text('Select Category'),
                    value: _categoryID,
                    items: (_selectedCategorytype == CategoryType.income
                            ? CategoryDB().incomeCategoryListListener
                            : CategoryDB().expenseCategoryListListner)
                        .value
                        .map((e) {
                      return DropdownMenuItem(
                        value: e.id,
                        child: Text(
                          e.name,
                        ),
                        onTap: () {
                          _selectedCategoryModel = e;
                        },
                      );
                    }).toList(),
                    onChanged: (selectedValue) {
                      print(selectedValue);
                      setState(() {
                        _categoryID = selectedValue;
                      });
                    },
                    onTap: () {},
                  ),
                  ElevatedButton.icon(
                    label: Text('Cateogory'),
                    onPressed: () {
                      showCategoryAddPopup(context);
                    },
                    icon: Icon(Icons.add),
                  )
                ],
              ),
              kHeight,
              // submit
              ElevatedButton(
                onPressed: () {
                  addTransaction();
                },
                child: Text('Submit'),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> addTransaction() async {
    final _purposeText = _purposeTextEditingController.text;
    final _amountText = _amountTextEditingController.text;
    if (_purposeText.isEmpty) {
      return;
    }
    if (_amountText.isEmpty) {
      return;
    }
    if (_selectedDate == null) {
      return;
    }
    if (_categoryID == null) {
      return;
    }
    final _parsedAmount = double.tryParse(_amountText);
    if (_parsedAmount == null) {
      return;
    }
    if (_selectedCategoryModel == null) {
      return;
    }
    // _selectedDate
    //  _selectedCategorytype
    // _categoryID
    final _model = TransactionModel(
      purpose: _purposeText,
      amount: _parsedAmount,
      date: _selectedDate!,
      type: _selectedCategorytype!,
      category: _selectedCategoryModel!,
    );
    await TransactionDB.instance.addTransaction(_model);
    Navigator.of(context).pop();
    TransactionDB.instance.refresh();
  }
}
