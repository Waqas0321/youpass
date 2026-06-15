import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:youpass/features/invitations/domain/entities/invitation_entity.dart';
import 'package:youpass/features/invitations/domain/entities/invitation_status.dart';
import 'package:youpass/features/invitations/domain/entities/invitation_tier.dart';
import 'package:youpass/features/invitations/domain/entities/invitations_feed_entity.dart';
import 'package:youpass/features/invitations/domain/entities/invitations_summary_entity.dart';
import 'package:youpass/features/invitations/domain/usecases/cancel_invitation_usecase.dart';
import 'package:youpass/features/invitations/domain/usecases/check_saved_payment_methods_usecase.dart';
import 'package:youpass/features/invitations/domain/usecases/confirm_invitation_usecase.dart';
import 'package:youpass/features/invitations/domain/usecases/fetch_invitation_detail_usecase.dart';
import 'package:youpass/features/invitations/domain/usecases/fetch_invitation_ticket_usecase.dart';
import 'package:youpass/features/invitations/domain/usecases/fetch_invitations_feed_usecase.dart';
import 'package:youpass/features/invitations/domain/usecases/fetch_invitations_summary_usecase.dart';
import 'package:youpass/features/invitations/domain/usecases/reject_invitation_usecase.dart';
import 'package:youpass/features/invitations/domain/usecases/save_payment_method_usecase.dart';
import 'package:youpass/features/invitations/presentation/providers/invitations_provider.dart';
import 'package:youpass/features/invitations/presentation/providers/invitations_status.dart';

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

  const testFeed = InvitationsFeedEntity(
    invitations: testInvitations,
    waitlistEntries: [],
  );

  const testSummary = InvitationsSummaryEntity(
    pendingCount: 1,
    newCount: 1,
    totalCount: 1,
  );

  setUp(() {
    mockRepository = MockInvitationsRepository();
    provider = InvitationsProvider(
      fetchInvitationsFeedUseCase: FetchInvitationsFeedUseCase(mockRepository),
      fetchInvitationsSummaryUseCase:
          FetchInvitationsSummaryUseCase(mockRepository),
      fetchInvitationDetailUseCase:
          FetchInvitationDetailUseCase(mockRepository),
      checkSavedPaymentMethodsUseCase:
          CheckSavedPaymentMethodsUseCase(mockRepository),
      confirmInvitationUseCase: ConfirmInvitationUseCase(mockRepository),
      rejectInvitationUseCase: RejectInvitationUseCase(mockRepository),
      cancelInvitationUseCase: CancelInvitationUseCase(mockRepository),
      fetchInvitationTicketUseCase: FetchInvitationTicketUseCase(mockRepository),
      savePaymentMethodUseCase: SavePaymentMethodUseCase(mockRepository),
    );
  });

  test('loadInvitations sets ready state with invitations', () async {
    when(() => mockRepository.fetchInvitationsFeed())
        .thenAnswer((_) async => testFeed);
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
    when(() => mockRepository.fetchInvitationsFeed())
        .thenAnswer((_) async => testFeed);
    when(() => mockRepository.fetchSummary())
        .thenAnswer((_) async => testSummary);
    when(() => mockRepository.hasSavedPaymentMethods())
        .thenAnswer((_) async => false);

    await provider.loadInvitations();
    await provider.ensureLoaded();

    verify(() => mockRepository.fetchInvitationsFeed()).called(1);
  });

  test('reset clears invitations state', () async {
    when(() => mockRepository.fetchInvitationsFeed())
        .thenAnswer((_) async => testFeed);
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

  test('rejectInvitation removes invitation and refreshes badge', () async {
    when(() => mockRepository.fetchInvitationsFeed())
        .thenAnswer((_) async => testFeed);
    when(() => mockRepository.fetchSummary())
        .thenAnswer((_) async => const InvitationsSummaryEntity(
              pendingCount: 0,
              newCount: 0,
              totalCount: 0,
            ));
    when(() => mockRepository.hasSavedPaymentMethods())
        .thenAnswer((_) async => false);
    when(() => mockRepository.rejectInvitation('inv-1'))
        .thenAnswer((_) async {});

    await provider.loadInvitations();
    final rejected = await provider.rejectInvitation('inv-1');

    expect(rejected, isTrue);
    expect(provider.invitations, isEmpty);
    expect(provider.invitationsBadgeCount, 0);
    verify(() => mockRepository.rejectInvitation('inv-1')).called(1);
    verify(() => mockRepository.fetchSummary()).called(2);
  });
}
