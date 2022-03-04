enum ExpenseCategory {
  food,
  grocery,
  bills,
  health,
  petrol,
  staffSalary,
  labourCharges,
  maintenance,
  rent,
}

extension ExpenseCategoryExtension on ExpenseCategory {
  String get value {
    switch (this) {
      case ExpenseCategory.food:
        return 'Food';
      case ExpenseCategory.grocery:
        return 'Grocery';
      case ExpenseCategory.bills:
        return 'Bills';
      case ExpenseCategory.health:
        return 'Health';
      case ExpenseCategory.petrol:
        return 'Petrol';
      case ExpenseCategory.staffSalary:
        return 'Staff Salary';
      case ExpenseCategory.labourCharges:
        return 'Labour Charges';
      case ExpenseCategory.maintenance:
        return 'Maintenance';
      case ExpenseCategory.rent:
        return 'Rent';
    }
  }
}

ExpenseCategory? parseToExpenseCategory(String val) {
  switch (val) {
    case 'Food':
      return ExpenseCategory.food;
    case 'Grocery':
      return ExpenseCategory.grocery;
    case 'Bills':
      return ExpenseCategory.bills;
    case 'Health':
      return ExpenseCategory.health;
    case 'Petrol':
      return ExpenseCategory.petrol;
    case 'Staff Salary':
      return ExpenseCategory.staffSalary;
    case 'Labour Charges':
      return ExpenseCategory.labourCharges;
    case 'Maintenance':
      return ExpenseCategory.maintenance;
    case 'Rent':
      return ExpenseCategory.rent;
  default:
      return null;
  }
}
