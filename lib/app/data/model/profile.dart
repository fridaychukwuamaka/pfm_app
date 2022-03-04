class Profile {
  double expense;
  double paidDebt ;
  double unpaidDebt ;

  Profile({
     this.expense = 0.0,
     this.paidDebt = 0.0,
     this.unpaidDebt = 0.0,
  });

  factory Profile.fromJson(Map val) {

    return Profile(
      expense: val['expense'] != null ? val['expense'].toDouble() : 0.0,
      paidDebt:  val['unpaidDebt'] != null ? val['unpaidDebt'].toDouble() : 0.0,
      unpaidDebt: val['paidDebt'] != null ? val['paidDebt'].toDouble() : 0.0,
    );
  }
}
