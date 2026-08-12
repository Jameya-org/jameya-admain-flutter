class MemberDetailsModel {
  final String id;
  final String legalName;
  final String email;
  final String mobileNumber;
  final String status;
  final DateTime createdAt;

  final IdentityProfile identityProfile;
  final TrustScore trustScore;
  final PaymentsSummary paymentsSummary;

  final List<MembershipModel> memberships;
  final List<InstallmentModel> installments;

  MemberDetailsModel({
    required this.id,
    required this.legalName,
    required this.email,
    required this.mobileNumber,
    required this.status,
    required this.createdAt,
    required this.identityProfile,
    required this.trustScore,
    required this.paymentsSummary,
    required this.memberships,
    required this.installments,
  });

  factory MemberDetailsModel.fromJson(Map<String, dynamic> json) {
    return MemberDetailsModel(
      id: json['id']?.toString() ?? '',
      legalName: json['legalName']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      mobileNumber: json['mobileNumber']?.toString() ?? '',
      status: json['status']?.toString() ?? '',
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(),

      identityProfile: IdentityProfile.fromJson(
        json['identityProfile'] ?? {},
      ),

      trustScore: TrustScore.fromJson(
        json['trustScore'],
      ),

      paymentsSummary: PaymentsSummary.fromJson(
        json['paymentsSummary'],
      ),

      memberships: (json['memberships'] as List? ?? [])
          .map((e) => MembershipModel.fromJson(e))
          .toList(),

      installments: (json['installments'] as List? ?? [])
          .map((e) => InstallmentModel.fromJson(e))
          .toList(),
    );
  }
}

class IdentityProfile {
  final String nationalId;
  final String kycStatus;
  final String city;
  final String street;
  final String district;
  final DateTime dateOfBirth;

  IdentityProfile({
    required this.nationalId,
    required this.kycStatus,
    required this.city,
    required this.street,
    required this.district,
    required this.dateOfBirth,
  });

  factory IdentityProfile.fromJson(Map<String, dynamic> json) {
    final address = json['address'] ?? {};

    return IdentityProfile(
      nationalId:
      json['nationalIdentifierToken']?.toString() ?? '',
      kycStatus: json['kycStatus']?.toString() ?? '',
      city: address['city']?.toString() ?? '',
      street: address['streetAddress']?.toString() ?? '',
      district: address['governorate']?.toString() ?? '',
      dateOfBirth: json['dateOfBirth'] != null
          ? DateTime.parse(json['dateOfBirth'])
          : DateTime.now(),
    );
  }
}

class TrustScore {
  final int score;
  final int paymentCommitment;
  final int identityVerification;

  TrustScore({
    required this.score,
    required this.paymentCommitment,
    required this.identityVerification,
  });

  factory TrustScore.fromJson(
      Map<String, dynamic>? json,
      ) {
    return TrustScore(
      score: int.tryParse(
        json?['score']?.toString() ?? '',
      ) ??
          0,

      paymentCommitment: int.tryParse(
        json?['paymentCommitment']?.toString() ?? '',
      ) ??
          0,

      identityVerification: int.tryParse(
        json?['identityVerification']?.toString() ?? '',
      ) ??
          0,
    );
  }
}

class PaymentsSummary {
  final int total;
  final int paid;
  final int pending;
  final int overdue;

  PaymentsSummary({
    required this.total,
    required this.paid,
    required this.pending,
    required this.overdue,
  });

  factory PaymentsSummary.fromJson(
      Map<String, dynamic>? json,
      ) {
    return PaymentsSummary(
      total: int.tryParse(
        json?['total']?.toString() ?? '',
      ) ??
          0,

      paid: int.tryParse(
        json?['paid']?.toString() ?? '',
      ) ??
          0,

      pending: int.tryParse(
        json?['pending']?.toString() ?? '',
      ) ??
          0,

      overdue: int.tryParse(
        json?['overdue']?.toString() ?? '',
      ) ??
          0,
    );
  }
}

class MembershipModel {
  final String id;
  final String status;
  final int payoutPosition;

  final CircleModel circle;

  MembershipModel({
    required this.id,
    required this.status,
    required this.payoutPosition,
    required this.circle,
  });

  factory MembershipModel.fromJson(
      Map<String, dynamic> json) {
    return MembershipModel(
      id: json['id']?.toString() ?? '',
      status: json['status']?.toString() ?? '',
      payoutPosition: json['payoutPosition'] ?? 0,
      circle: CircleModel.fromJson(
        json['circle'] ?? {},
      ),
    );
  }
}

class CircleModel {
  final String id;
  final double amount;
  final int durationMonths;
  final String status;

  CircleModel({
    required this.id,
    required this.amount,
    required this.durationMonths,
    required this.status,
  });

  factory CircleModel.fromJson(
      Map<String, dynamic> json,
      ) {
    return CircleModel(
      id: json['id']?.toString() ?? '',

        amount: double.tryParse(
          json['amount']?.toString() ?? '',
        ) ?? 0,

      durationMonths: int.tryParse(
        json['durationMonths']?.toString() ?? '',
      ) ??
          0,

      status: json['status']?.toString() ?? '',
    );
  }
}

class InstallmentModel {
  final String id;
  final String membershipId;
  final String circleId;
  final int circleDurationMonths;
  final double circleAmount;

  final int cycleNumber;
  final double amount;
  final String status;

  final DateTime dueDate;
  final DateTime? paidDate;
  final String? paymentChannel;

  InstallmentModel({
    required this.id,
    required this.membershipId,
    required this.circleId,
    required this.circleDurationMonths,
    required this.circleAmount,
    required this.cycleNumber,
    required this.amount,
    required this.status,
    required this.dueDate,
    this.paidDate,
    this.paymentChannel,
  });

  factory InstallmentModel.fromJson(
      Map<String, dynamic> json,
      ) {
    return InstallmentModel(
      id: json['id']?.toString() ?? '',

      membershipId:
      json['membershipId']?.toString() ?? '',

      circleId:
      json['circleId']?.toString() ?? '',

      circleDurationMonths:
      (json['circleDurationMonths'] as num?)?.toInt() ?? 0,

      circleAmount:
      double.tryParse(
        json['circleAmount']?.toString() ?? '',
      ) ??
          0,

      cycleNumber:
      (json['cycleNumber'] as num?)?.toInt() ?? 0,

      amount:
      double.tryParse(
        json['amount']?.toString() ?? '',
      ) ??
          0,

      status:
      json['status']?.toString() ?? '',

      dueDate:
      DateTime.parse(json['dueDate']),

      paidDate:
      json['paidDate'] != null
          ? DateTime.tryParse(
        json['paidDate'].toString(),
      )
          : null,

      paymentChannel:
      json['paymentChannel']?.toString(),
    );
  }
}