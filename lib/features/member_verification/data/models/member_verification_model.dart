enum DocumentVerificationStatus { pending, approved, rejected }
enum MemberVerificationStatusEnum { pending, approved, rejected }

class MemberDocumentModel {
  final String id;
  final String title;
  final String imageUrl;
  final String? localImagePath;
  DocumentVerificationStatus status;
  String? rejectionReason;
  bool isExpanded;

  MemberDocumentModel({
    required this.id,
    required this.title,
    required this.imageUrl,
    this.localImagePath,
    this.status = DocumentVerificationStatus.pending,
    this.rejectionReason,
    this.isExpanded = false,
  });

  MemberDocumentModel copyWith({
    String? id,
    String? title,
    String? imageUrl,
    String? localImagePath,
    DocumentVerificationStatus? status,
    String? rejectionReason,
    bool? isExpanded,
  }) {
    return MemberDocumentModel(
      id: id ?? this.id,
      title: title ?? this.title,
      imageUrl: imageUrl ?? this.imageUrl,
      localImagePath: localImagePath ?? this.localImagePath,
      status: status ?? this.status,
      rejectionReason: rejectionReason ?? this.rejectionReason,
      isExpanded: isExpanded ?? this.isExpanded,
    );
  }

  factory MemberDocumentModel.fromJson(Map<String, dynamic> json) {
    String docTitle = json['title'] ?? json['type'] ?? json['documentType'] ?? json['docType'] ?? 'مستند مرفق';
    if (docTitle == 'NATIONAL_ID' || docTitle == 'national_id') {
      docTitle = 'صورة البطاقة الشخصية';
    } else if (docTitle == 'PROOF_OF_INCOME' || docTitle == 'INCOME_PROOF' || docTitle == 'salary' || docTitle == 'income') {
      docTitle = 'إثبات الدخل / المرتب';
    } else if (docTitle == 'UTILITY_BILL') {
      docTitle = 'وصل مرافق';
    } else if (docTitle == 'PASSPORT') {
      docTitle = 'جواز السفر';
    }

    return MemberDocumentModel(
      id: json['id']?.toString() ?? '',
      title: docTitle,
      imageUrl: json['imageUrl'] ?? json['fileUrl'] ?? json['url'] ?? json['encryptedObjectRef'] ?? '',
      status: json['status'] == 'APPROVED'
          ? DocumentVerificationStatus.approved
          : json['status'] == 'REJECTED'
              ? DocumentVerificationStatus.rejected
              : DocumentVerificationStatus.pending,
      rejectionReason: json['rejectionReason'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'imageUrl': imageUrl,
      'localImagePath': localImagePath,
      'status': status.name.toUpperCase(),
      'rejectionReason': rejectionReason,
    };
  }
}

class MemberVerificationModel {
  final String id;
  final String name;
  final String phone;
  final String email;
  final String? avatarUrl;
  final String status;
  final List<MemberDocumentModel> documents;
  final double? estimatedAmount;
  final MemberVerificationStatusEnum verificationStatus;

  MemberVerificationModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
    this.avatarUrl,
    this.status = 'قيد الانتظار',
    required this.documents,
    this.estimatedAmount,
    this.verificationStatus = MemberVerificationStatusEnum.pending,
  });

  MemberVerificationModel copyWith({
    String? id,
    String? name,
    String? phone,
    String? email,
    String? avatarUrl,
    String? status,
    List<MemberDocumentModel>? documents,
    double? estimatedAmount,
    MemberVerificationStatusEnum? verificationStatus,
  }) {
    return MemberVerificationModel(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      status: status ?? this.status,
      documents: documents ?? this.documents,
      estimatedAmount: estimatedAmount ?? this.estimatedAmount,
      verificationStatus: verificationStatus ?? this.verificationStatus,
    );
  }

  factory MemberVerificationModel.fromJson(Map<String, dynamic> json) {
    final Map<String, dynamic> customerObj =
        json['customer'] is Map<String, dynamic>
            ? json['customer'] as Map<String, dynamic>
            : json;

    return MemberVerificationModel(
      id: customerObj['id']?.toString() ?? json['id']?.toString() ?? '',
      name: customerObj['name'] ??
          customerObj['fullName'] ??
          json['name'] ??
          'محمد احمد علي',
      phone: customerObj['phone'] ??
          customerObj['phoneNumber'] ??
          json['phone'] ??
          '01234567890',
      email: customerObj['email'] ?? json['email'] ?? 'ex@gmail.com',
      avatarUrl: customerObj['avatarUrl'] ??
          customerObj['profileImage'] ??
          json['avatarUrl'],
      status: _mapStatusToArabic(
          json['status']?.toString() ??
          (json['identityProfile'] is Map ? json['identityProfile']['kycStatus']?.toString() : null) ??
          customerObj['status']?.toString()
        ),
      documents: () {
        final parsedDocs = (json['documents'] as List<dynamic>?)
            ?.map((e) => MemberDocumentModel.fromJson(e as Map<String, dynamic>))
            .toList();
        if (parsedDocs != null && parsedDocs.isNotEmpty) {
          return parsedDocs;
        }
        // If json itself represents a document item (e.g. from GET /admin/kyc/pending-documents)
        if (json.containsKey('fileUrl') ||
            json.containsKey('url') ||
            json.containsKey('imageUrl') ||
            json.containsKey('documentType') ||
            json.containsKey('docType') ||
            json.containsKey('encryptedObjectRef') ||
            (json.containsKey('type') && json['type'] != null)) {
          final doc = MemberDocumentModel.fromJson(json);
          if (doc.id.isNotEmpty) {
            return [doc];
          }
        }
        return <MemberDocumentModel>[];
      }(),
      estimatedAmount:
          (json['estimatedAmount'] ?? json['maxMonthlyInstallmentLimit'] as num?)
              ?.toDouble(),
    );
  }

  static String _mapStatusToArabic(String? status) {
    switch (status) {
      case 'PENDING':
        return 'قيد الانتظار';
      case 'UNDER_REVIEW':
        return 'تحت المراجعة';
      case 'APPROVED':
        return 'تمت الموافقة';
      case 'REJECTED':
        return 'مرفوض';
      case 'ACTIVE':
        return 'نشط';
      case 'INACTIVE':
        return 'غير نشط';
      case 'SUSPENDED':
        return 'موقوف';
      case 'NOT_STARTED':
        return 'لم يبدأ بعد';
      case 'ELIGIBLE':
        return 'مؤهل';
      case 'INELIGIBLE':
        return 'غير مؤهل';
      case 'MANUAL_REVIEW':
        return 'مراجعة يدوية';
      default:
        return status ?? 'قيد الانتظار';
    }
  }
}
