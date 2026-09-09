import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:youpass/staff_app/features/supervisor/presentation/providers/staff_supervisor_session_provider.dart';
import 'package:youpass/staff_app/features/supervisor/presentation/utils/exit_staff_supervisor_mode.dart';
import 'package:youpass/staff_app/routes/app_routes.dart';

void main() {
  testWidgets('exitStaffSupervisorMode locks session and pops dashboard', (
    tester,
  ) async {
    final session = StaffSupervisorSessionProvider()..unlock();

    await tester.pumpWidget(
      ChangeNotifierProvider.value(
        value: session,
        child: MaterialApp(
          home: Builder(
            builder: (context) {
              return Scaffold(
                body: ElevatedButton(
                  onPressed: () => Navigator.of(context).pushNamed(
                    StaffAppRoutes.supervisorAccessDashboard,
                  ),
                  child: const Text('open'),
                ),
              );
            },
          ),
          onGenerateRoute: (settings) {
            if (settings.name == StaffAppRoutes.supervisorAccessDashboard) {
              return MaterialPageRoute(
                settings: settings,
                builder: (context) => Scaffold(
                  body: ElevatedButton(
                    onPressed: () => exitStaffSupervisorMode(context),
                    child: const Text('exit'),
                  ),
                ),
              );
            }
            return null;
          },
        ),
      ),
    );

    await tester.tap(find.text('open'));
    await tester.pumpAndSettle();

    expect(find.text('exit'), findsOneWidget);
    expect(session.isUnlocked, isTrue);

    await tester.tap(find.text('exit'));
    await tester.pumpAndSettle();

    expect(find.text('open'), findsOneWidget);
    expect(find.text('exit'), findsNothing);
    expect(session.isUnlocked, isFalse);
  });

  testWidgets('exitStaffSupervisorMode pops unnamed dashboard routes', (
    tester,
  ) async {
    final session = StaffSupervisorSessionProvider()..unlock();

    await tester.pumpWidget(
      ChangeNotifierProvider.value(
        value: session,
        child: MaterialApp(
          home: Builder(
            builder: (context) {
              return Scaffold(
                body: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (dashboardContext) => Scaffold(
                          body: ElevatedButton(
                            onPressed: () =>
                                exitStaffSupervisorMode(dashboardContext),
                            child: const Text('exit'),
                          ),
                        ),
                      ),
                    );
                  },
                  child: const Text('open'),
                ),
              );
            },
          ),
        ),
      ),
    );

    await tester.tap(find.text('open'));
    await tester.pumpAndSettle();
    expect(find.text('exit'), findsOneWidget);

    await tester.tap(find.text('exit'));
    await tester.pumpAndSettle();

    expect(find.text('open'), findsOneWidget);
    expect(find.text('exit'), findsNothing);
    expect(session.isUnlocked, isFalse);
  });
}
