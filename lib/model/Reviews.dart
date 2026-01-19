class Review {
  final String id;
  final String productId;
  final String userId;
  final String userName;
  final String comment;
  final double rating;
  final DateTime date;

  Review({
    required this.userName,
    required this.comment,
    required this.rating,
    required this.date,
    required this.id,
    required this.productId,
    required this.userId,
  });
}
