library src.enums.selection_type;

///
enum DateSelectionType {
  singleDate,
  multiDates,
  dateRange,
}

///
extension DateSelectionTypeState on DateSelectionType {
  bool get isSingleDate => this == DateSelectionType.singleDate;
  bool get isMultiDates => this == DateSelectionType.multiDates;
  bool get isDateRange => this == DateSelectionType.dateRange;
}
