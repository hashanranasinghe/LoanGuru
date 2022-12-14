import 'package:bank_loan/api/bankapi.dart';
import 'package:bank_loan/api/constant.dart';
import 'package:bank_loan/screens/suggetionscreen.dart';
import 'package:bank_loan/widgets/customdropdown.dart';
import 'package:flutter/material.dart';
import '../api/validator.dart';
import '../widgets/button.dart';
import '../widgets/input_field.dart';

class FilterScreen extends StatefulWidget {
  static const routName = 'filter-screen';
  const FilterScreen({Key? key}) : super(key: key);

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  late List<String> bankNames = [];
  late List<String> categories = [];
  @override
  void initState() {
    // TODO: implement initState
    BankApi.ReadBankNames().then((value) {
      print(value.toString());
      setState(() {
        bankNames = value;
        print(bankNames);
      });
    });
    super.initState();
  }

  final _form = GlobalKey<FormState>();
  TextEditingController jobPosition = TextEditingController();
  TextEditingController interestRate = TextEditingController();

  final loan_category = [
    "Home loan",
    "Personal Loan",
    "Quick & Easy Loan",
    "Vehicle loan",
    "Educational loan",
    "Professional loans",
    "Gold Loan Pawning",
    "Leasing",
    "Business loan"
  ];
  final period = [
    "up to 5 years",
    "up to 7 years",
    "up to 10 years",
  ];

  String? value;
  String? lValue;
  String? yValue;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Find a Loan',
          style: TextStyle(
              fontSize: 40, fontWeight: FontWeight.w600, color: primaryColor),
        ),
        _buildJobPosition(),
        _buildInterestRate(),
        // CustomDropDown(
        //   valueList: bankNames.map(buildMenus).toList(),
        //   function: (value) => setState(() {
        //     this.value=value;
        //   }),
        //   text: value,
        //   hint: "Bank",
        // ),

        // Form(
        //   key: _form,
        //   child: CustomDropDown(
        //     validator: (lValue){
        //       if(lValue=="null"){
        //         print("=========");
        //       }
        //     },
        //     valueList: loan_category.map(buildMenus).toList(),
        //     function: (lValue) => setState(() {
        //       this.lValue = lValue;
        //
        //     }),
        //     text: lValue,
        //     hint: "Loan Category",
        //   ),
        // ),
        Form(
          key: _form,
          child: Container(
            margin: EdgeInsets.symmetric(
                vertical: size.height * 0.01, horizontal: size.width * 0.01),
            width: size.width * 0.74,
            padding: EdgeInsets.symmetric(
                vertical: size.height * 0.01, horizontal: size.width * 0.02),
            decoration: BoxDecoration(
              border: Border.all(color: primaryColor),
              borderRadius: BorderRadius.circular(12),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButtonFormField<String>(
                validator: (value) {
                  if (value == null) {
                    return 'Loan category is required';
                  }
                  return null;
                },
                decoration: InputDecoration(border: InputBorder.none),
                hint: Text('Loan Category'),
                isExpanded: true,
                iconSize: 36,
                icon: Icon(
                  Icons.arrow_drop_down,
                  color: Colors.black,
                ),
                value: lValue,
                items: loan_category.map(buildMenus).toList(),
                onChanged: (lValue) => setState(() {
                  this.lValue = lValue;
                }),
              ),
            ),
          ),
        ),
        CustomDropDown(
          valueList: period.map(buildMenus).toList(),
          function: (yValue) => setState(() {
            this.yValue = yValue;
          }),
          text: yValue,
          hint: "Period",
        ),
        _buildSubmitButton()
      ],
    ));
  }

  DropdownMenuItem<String> buildMenus(String item) => DropdownMenuItem(
      value: item,
      child: Text(
        item,
      ));

  Widget _buildJobPosition() {
    return InputField(
      controller: jobPosition,
      textInputType: TextInputType.text,
      text: "Job position",
    );
  }

  Widget _buildInterestRate() {
    return InputField(
      controller: interestRate,
      textInputType: TextInputType.number,
      text: "Interest rate",
    );
  }

  Widget _buildSubmitButton() {
    return ButtonField(
        function: () async {
          if (_form.currentState!.validate()) {
            print(value);
            print(lValue);
            print(yValue);
            print(jobPosition.text);
            print(interestRate.text);
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SuggestionScreen(
                      value: value.toString(),
                      lValue: lValue.toString(),
                      yValue: yValue
                          .toString()
                          .replaceAll(new RegExp(r'[^0-9]'), ''),
                      jobPosition: jobPosition.text,
                      ineterestRate: interestRate.text),
                ));
          }
        },
        text: "Submit");
  }
}
