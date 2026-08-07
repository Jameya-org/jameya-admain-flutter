/// Response model for `POST /admin/circles` (HTTP 201).
/// The API returns the created circle in DRAFT status.
class CreateJameyaResponseModel {
  final String? id;
  final String? status; // e.g. "DRAFT"
  final String? message;

  const CreateJameyaResponseModel({
    this.id,
    this.status,
    this.message,
  });

  factory CreateJameyaResponseModel.fromJson(Map<String, dynamic> json) {
    return CreateJameyaResponseModel(
      id: json['id'] as String?,
      status: json['status'] as String?,
      message: json['message'] as String?,
    );
  }
}
