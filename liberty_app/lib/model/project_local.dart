class ProjectLocal {
  String title;
  DateTime startDate;
  DateTime endDate;
  String? dayLeft;
  double progress;

  ProjectLocal(
    this.title,
    this.startDate,
    this.endDate,
    this.progress, {
    this.dayLeft,
  });
}
