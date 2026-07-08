class VersionCheckDto {
  final bool updateRequired;
  final bool forceUpdate;
  final String? latestVersion;

  const VersionCheckDto({
    required this.updateRequired,
    required this.forceUpdate,
    required this.latestVersion,
  });

  factory VersionCheckDto.fromJson(Map<String, dynamic> json) {
    return VersionCheckDto(
      updateRequired: (json['update_required'] ?? false) == true,
      forceUpdate: (json['force_update'] ?? false) == true,
      latestVersion: json['latest_version'] as String?,
    );
  }
}

