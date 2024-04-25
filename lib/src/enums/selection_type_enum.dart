library src.enums.selection_type;

///
enum DateSelectionType {
  singleDate,
  multipleDates,
  dateRange,
}

///
extension DateSelectionTypeState on DateSelectionType {
  bool get isSingleDate => this == DateSelectionType.singleDate;
  bool get isMultiDates => this == DateSelectionType.multipleDates;
  bool get isDateRange => this == DateSelectionType.dateRange;
}
