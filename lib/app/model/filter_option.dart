class FilterOption {
  final String id;
  final String label;
  final String type;
  final bool multiple;
  final List<String> options;

  FilterOption({
    required this.id,
    required this.label,
    required this.type,
    required this.multiple,
    required this.options,
  });

  factory FilterOption.fromJson(Map<String, dynamic> json) {
    return FilterOption(
      id: json['id'],
      label: json['label'],
      type: json['type'],
      multiple: json['multiple'],
      options: List<String>.from(json['options']),
    );
  }
}

class FilterConfig {
  final List<FilterOption> filters;

  FilterConfig({required this.filters});

  factory FilterConfig.fromJson(Map<String, dynamic> json) {
    return FilterConfig(
      filters: (json['filters'] as List)
          .map((filter) => FilterOption.fromJson(filter))
          .toList(),
    );
  }
}
