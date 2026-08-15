class StaffProfile {
  const StaffProfile({
    required this.id,
    required this.name,
    required this.phone,
    required this.status,
    required this.permissionIds,
    this.roleLabel,
    this.zoneLabel,
  });

  final String id;
  final String name;
  final String phone;
  final String status;
  final List<String> permissionIds;
  final String? roleLabel;
  final String? zoneLabel;

  factory StaffProfile.fromJson(Map<String, dynamic> json) {
    final role = json['role'];
    final zone = json['zone'];
    final permissions = json['permission_ids'];

    return StaffProfile(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      phone: json['phone'] as String? ?? '',
      status: json['status'] as String? ?? 'online',
      permissionIds: permissions is List
          ? permissions.map((item) => item.toString()).toList()
          : const [],
      roleLabel: role is Map ? role['label'] as String? : null,
      zoneLabel: zone is Map ? zone['label'] as String? : null,
    );
  }
}

class StaffSession {
  const StaffSession({
    required this.accessToken,
    required this.staff,
    this.sessionId,
    this.expiresAt,
  });

  final String accessToken;
  final StaffProfile staff;
  final String? sessionId;
  final String? expiresAt;

  factory StaffSession.fromJson(Map<String, dynamic> json) {
    return StaffSession(
      accessToken: json['access_token'] as String? ?? '',
      sessionId: json['session_id'] as String?,
      expiresAt: json['expires_at'] as String?,
      staff: StaffProfile.fromJson(
        json['staff'] as Map<String, dynamic>? ?? const {},
      ),
    );
  }
}
