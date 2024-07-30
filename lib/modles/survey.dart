class Survey {
  final String respondentId;
  final String respondentName;
  final String surveyId;
  final String date;
  final String startTime;
  final String endTime;
  final String score;
  final String status;
  final String totalScore;
  final String scorePercentage;

  Survey({
    required this.respondentId,
    required this.respondentName,
    required this.surveyId,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.score,
    required this.status,
    required this.totalScore,
    required this.scorePercentage,
  });

  factory Survey.fromFirestore(Map<String, dynamic> data) {
    return Survey(
      respondentId: data['respondent_id'],
      respondentName: data['respondent_name'],
      surveyId: data['survey_id'],
      date: data['date'],
      startTime: data['start_time'],
      endTime: data['end_time'],
      score: data['score'],
      status: data['status'],
      totalScore: data['total_score'],
      scorePercentage: data['score_percentage'],
    );
  }
}
