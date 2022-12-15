import 'package:flutter/material.dart';

class Bank {
  String? bank;
  String? loanCategory;
  String? loanName;
  String? targetApplicant;
  String? period;
  String? guarantor;
  String? interestRate;
  String? specialBenefits;
  String? link;

  Bank(
      {required this.bank,
      required this.loanCategory,
      required this.loanName,
      required this.targetApplicant,
      required this.period,
      required this.guarantor,
      required this.interestRate,
      required this.link,
      required this.specialBenefits});

  Bank.fromJson(Map<String, dynamic> json) {
    bank = json['bank'];
    loanCategory = json['loan_categories'];
    loanName = json['loan_name'];
    targetApplicant = json['target_applicant'];
    period = json['loan_repayment_period'];
    guarantor = json['guarantors'];
    specialBenefits = json['special_benefits'];
    interestRate = json['interest_rate'];
    link = json['link'];
  }
}
