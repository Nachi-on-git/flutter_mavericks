class AppraisalStep {
  final String imageUrl;
  final String title;
  String? description;
  String? empType;

  AppraisalStep({
    required this.imageUrl,
    required this.title,
    this.description,
    this.empType
  });
}