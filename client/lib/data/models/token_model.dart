class TokenModel {
  final int parentId;
  final int amount;

  TokenModel({required this.parentId, required this.amount});

  factory TokenModel.fromJson(Map<String, dynamic> json) {
    return TokenModel(
      parentId: json['parent_id'],
      amount: json['amount'],
    );
  }
}
