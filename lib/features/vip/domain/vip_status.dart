class VipStatus {
  final bool isVip;
  final DateTime? expiresAt;

  const VipStatus({required this.isVip, required this.expiresAt});

  factory VipStatus.fromJson(Map<String, dynamic> json) {
    final isVip = (json['is_vip'] ?? false) == true;
    final expiresAtRaw = json['expires_at'];
    final expiresAt = expiresAtRaw is String && expiresAtRaw.isNotEmpty
        ? DateTime.tryParse(expiresAtRaw)
        : null;
    return VipStatus(isVip: isVip, expiresAt: expiresAt);
  }
}

