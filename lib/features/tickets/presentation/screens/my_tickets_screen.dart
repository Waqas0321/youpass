import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/theme/tickets_screen_theme.dart';
import 'package:youpass/features/tickets/presentation/data/tickets_mock_data.dart';
import 'package:youpass/features/tickets/presentation/tickets_design_spec.dart';
import 'package:youpass/features/tickets/presentation/widgets/past_events_tab_widget.dart';
import 'package:youpass/features/tickets/presentation/widgets/upcoming_tickets_tab_widget.dart';

class MyTicketsScreen extends StatefulWidget {
  const MyTicketsScreen({super.key});

  @override
  State<MyTicketsScreen> createState() => MyTicketsScreenState();
}

class MyTicketsScreenState extends State<MyTicketsScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        surfaceTintColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(
            Icons.arrow_back,
            color: TicketsScreenTheme.accent(context),
            size: TicketsDesignSpec.px(
              context,
              TicketsDesignSpec.backIconSize,
            ),
          ),
        ),
        title: Text(
          AppStrings.drawerMyTickets(strings),
          style: TextStyle(
            fontSize: TicketsDesignSpec.px(
              context,
              TicketsDesignSpec.appBarTitleSize,
            ),
            fontWeight: FontWeight.w700,
            color: TicketsScreenTheme.accent(context),
          ),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(
            TicketsDesignSpec.px(context, 44),
          ),
          child: TabBar(
            controller: tabController,
            indicatorColor: TicketsScreenTheme.accent(context),
            indicatorWeight: 2.5,
            labelColor: TicketsScreenTheme.accent(context),
            unselectedLabelColor:
                Theme.of(context).colorScheme.onSurfaceVariant,
            labelStyle: TextStyle(
              fontSize: TicketsDesignSpec.px(
                context,
                TicketsDesignSpec.tabFontSize,
              ),
              fontWeight: FontWeight.w700,
              letterSpacing: 0.4,
            ),
            unselectedLabelStyle: TextStyle(
              fontSize: TicketsDesignSpec.px(
                context,
                TicketsDesignSpec.tabFontSize,
              ),
              fontWeight: FontWeight.w600,
              letterSpacing: 0.4,
            ),
            tabs: [
              Tab(text: AppStrings.ticketsTabUpcoming(strings)),
              Tab(text: AppStrings.ticketsTabPast(strings)),
            ],
          ),
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: [
          UpcomingTicketsTabWidget(tickets: TicketsMockData.upcoming(strings)),
          PastEventsTabWidget(events: TicketsMockData.past(strings)),
        ],
      ),
    );
  }
}
