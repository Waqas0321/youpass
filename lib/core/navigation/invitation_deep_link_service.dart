class InvitationDeepLinkService {
  InvitationDeepLinkService._();

  static String? pendingInvitationId;

  static void setPendingInvitationId(String? invitationId) {
    pendingInvitationId = invitationId?.trim().isNotEmpty == true
        ? invitationId!.trim()
        : null;
  }

  static String? consumePendingInvitationId() {
    final value = pendingInvitationId;
    pendingInvitationId = null;
    return value;
  }

  static bool tryParseUri(Uri uri) {
    if (uri.scheme != 'youpass') {
      return false;
    }

    if (uri.host == 'invitations') {
      final id = uri.pathSegments.isNotEmpty ? uri.pathSegments.first : null;
      setPendingInvitationId(id);
      return id != null;
    }

    if (uri.pathSegments.length >= 2 && uri.pathSegments.first == 'invitations') {
      setPendingInvitationId(uri.pathSegments[1]);
      return true;
    }

    return false;
  }
}
