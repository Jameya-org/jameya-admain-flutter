class DashboardModel {
  final KycStats kyc;
  final CustomersStats customers;
  final CirclesStats circles;
  final FeePolicyStats feePolicy;

  DashboardModel({
    required this.kyc,
    required this.customers,
    required this.circles,
    required this.feePolicy,
  });

  factory DashboardModel.fromJson(Map<String, dynamic> json) {
    return DashboardModel(
      kyc: KycStats.fromJson(json['kyc'] ?? {}),
      customers: CustomersStats.fromJson(json['customers'] ?? {}),
      circles: CirclesStats.fromJson(json['circles'] ?? {}),
      feePolicy: FeePolicyStats.fromJson(json['feePolicy'] ?? {}),
    );
  }
}

class KycStats {
  final int pendingReview;
  final int approvedToday;
  final int rejectedToday;

  KycStats({
    required this.pendingReview,
    required this.approvedToday,
    required this.rejectedToday,
  });

  factory KycStats.fromJson(Map<String, dynamic> json) {
    return KycStats(
      pendingReview: json['pendingReview'] ?? 0,
      approvedToday: json['approvedToday'] ?? 0,
      rejectedToday: json['rejectedToday'] ?? 0,
    );
  }
}

class CustomersStats {
  final int total;
  final KycStatusStats byKycStatus;

  CustomersStats({
    required this.total,
    required this.byKycStatus,
  });

  factory CustomersStats.fromJson(Map<String, dynamic> json) {
    return CustomersStats(
      total: json['total'] ?? 0,
      byKycStatus: KycStatusStats.fromJson(json['byKycStatus'] ?? {}),
    );
  }
}

class KycStatusStats {
  final int notStarted;
  final int pending;
  final int underReview;
  final int approved;
  final int rejected;

  KycStatusStats({
    required this.notStarted,
    required this.pending,
    required this.underReview,
    required this.approved,
    required this.rejected,
  });

  factory KycStatusStats.fromJson(Map<String, dynamic> json) {
    return KycStatusStats(
      notStarted: json['NOT_STARTED'] ?? 0,
      pending: json['PENDING'] ?? 0,
      underReview: json['UNDER_REVIEW'] ?? 0,
      approved: json['APPROVED'] ?? 0,
      rejected: json['REJECTED'] ?? 0,
    );
  }
}

class CirclesStats {
  final int upcoming;
  final int inProgress;
  final int completed;
  final int totalActiveMembers;

  CirclesStats({
    required this.upcoming,
    required this.inProgress,
    required this.completed,
    required this.totalActiveMembers,
  });

  factory CirclesStats.fromJson(Map<String, dynamic> json) {
    return CirclesStats(
      upcoming: json['upcoming'] ?? 0,
      inProgress: json['inProgress'] ?? 0,
      completed: json['completed'] ?? 0,
      totalActiveMembers: json['totalActiveMembers'] ?? 0,
    );
  }
}

class FeePolicyStats {
  final String version;
  final String effectiveFrom;
  final int durationMonths;

  FeePolicyStats({
    required this.version,
    required this.effectiveFrom,
    required this.durationMonths,
  });

  factory FeePolicyStats.fromJson(Map<String, dynamic> json) {
    return FeePolicyStats(
      version: json['version'] ?? '',
      effectiveFrom: json['effectiveFrom'] ?? '',
      durationMonths: json['durationMonths'] ?? 0,
    );
  }
}
