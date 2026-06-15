class ConfirmInvitationParams {
  const ConfirmInvitationParams({
    this.acceptChargeTerms = false,
    this.paymentMethodId,
  });

  final bool acceptChargeTerms;
  final String? paymentMethodId;
}
