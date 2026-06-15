enum InvitationProductKind {
  free,
  guaranteedPass,
  discounted,
}

extension InvitationProductKindX on InvitationProductKind {
  String get apiValue {
    switch (this) {
      case InvitationProductKind.free:
        return 'free';
      case InvitationProductKind.guaranteedPass:
        return 'guaranteed_pass';
      case InvitationProductKind.discounted:
        return 'discounted';
    }
  }

  static InvitationProductKind? fromApi(String? value) {
    switch (value?.toLowerCase()) {
      case 'free':
        return InvitationProductKind.free;
      case 'guaranteed_pass':
        return InvitationProductKind.guaranteedPass;
      case 'discounted':
        return InvitationProductKind.discounted;
      default:
        return null;
    }
  }
}
