import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:youpass/features/invitations/domain/entities/invitation_entity.dart';
import 'package:youpass/features/invitations/domain/entities/invitation_status.dart';
import 'package:youpass/features/invitations/domain/entities/invitation_tier.dart';
import 'package:youpass/features/invitations/domain/entities/invitations_summary_entity.dart';
import 'package:youpass/features/invitations/domain/usecases/check_saved_payment_methods_usecase.dart';
import 'package:youpass/features/invitations/domain/usecases/confirm_invitation_usecase.dart';
import 'package:youpass/features/invitations/domain/usecases/fetch_invitation_ticket_usecase.dart';
import 'package:youpass/features/invitations/domain/usecases/fetch_invitations_summary_usecase.dart';
import 'package:youpass/features/invitations/domain/usecases/fetch_invitations_usecase.dart';
import 'package:youpass/features/invitations/domain/usecases/reject_invitation_usecase.dart';
import 'package:youpass/features/invitations/domain/usecases/save_payment_method_usecase.dart';
import 'package:youpass/features/invitations/presentation/providers/invitations_provider.dart';

import '../../mocks/mock_invitations_repository.dart';

void main() {
  late MockInvitationsRepository mockRepository;
  late InvitationsProvider provider;

  const testInvitations = [
    InvitationEntity(
      id: 'inv-1',
      eventTitle: 'YouFest 2026',
      locationLabel: 'Santiago',
      dateTimeLabel: 'Jul 4',
      imageAssetPath: '',
      tier: InvitationTier.vip,
      status: InvitationStatus.pending,
    ),
  ];

  const testSummary = InvitationsSummaryEntity(
    pendingCount: 1,
    newCount: 1,
    totalCount: 1,
  );

  setUp(() {
    mockRepository = MockInvitationsRepository();
    provider = InvitationsProvider(
      fetchInvitationsUseCase: FetchInvitationsUseCase(mockRepository),
      fetchInvitationsSummaryUseCase:
          FetchInvitationsSummaryUseCase(mockRepository),
      checkSavedPaymentMethodsUseCase:
          CheckSavedPaymentMethodsUseCase(mockRepository),
      confirmInvitationUseCase: ConfirmInvitationUseCase(mockRepository),
      rejectInvitationUseCase: RejectInvitationUseCase(mockRepository),
      fetchInvitationTicketUseCase: FetchInvitationTicketUseCase(mockRepository),
      savePaymentMethodUseCase: SavePaymentMethodUseCase(mockRepository),
    );
  });

  test('loadInvitations sets ready state with invitations', () async {
    when(() => mockRepository.fetchInvitations())
        .thenAnswer((_) async => testInvitations);
    when(() => mockRepository.fetchSummary())
        .thenAnswer((_) async => testSummary);
    when(() => mockRepository.hasSavedPaymentMethods())
        .thenAnswer((_) async => false);

    await provider.loadInvitations();

    expect(provider.status, InvitationsStatus.ready);
    expect(provider.invitations, testInvitations);
    expect(provider.invitationsBadgeCount, 1);
  });

  test('ensureLoaded skips reload when already ready', () async {
    when(() => mockRepository.fetchInvitations())
        .thenAnswer((_) async => testInvitations);
    when(() => mockRepository.fetchSummary())
        .thenAnswer((_) async => testSummary);
    when(() => mockRepository.hasSavedPaymentMethods())
        .thenAnswer((_) async => false);

    await provider.loadInvitations();
    await provider.ensureLoaded();

    verify(() => mockRepository.fetchInvitations()).called(1);
  });

  test('reset clears invitations state', () async {
    when(() => mockRepository.fetchInvitations())
        .thenAnswer((_) async => testInvitations);
    when(() => mockRepository.fetchSummary())
        .thenAnswer((_) async => testSummary);
    when(() => mockRepository.hasSavedPaymentMethods())
        .thenAnswer((_) async => true);

    await provider.loadInvitations();
    provider.reset();

    expect(provider.status, InvitationsStatus.initial);
    expect(provider.invitations, isEmpty);
    expect(provider.hasPaymentMethod, isFalse);
    expect(provider.invitationsBadgeCount, 0);
  });
}
