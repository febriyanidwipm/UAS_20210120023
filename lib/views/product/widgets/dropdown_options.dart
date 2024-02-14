class DropdownOption {
  final String value;
  final String label;

  DropdownOption(this.value, this.label);
  Map<String, dynamic> toMap() {
    return {
      'value': value,
    };
  }
}
