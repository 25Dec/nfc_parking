import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/common/widgets/custom_top_app_bar.dart';
import '../../../../core/routes/app_route_constants.dart';
import '../../../nfc_cards/presentation/bloc/nfc_cards_bloc.dart';
import '../../domain/entities/parking_ticket_entity.dart';
import '../bloc/parking_history_bloc.dart';
import 'sub_pages/oldest_parking_history_page.dart';
import 'sub_pages/recently_parking_history_page.dart';

class ParkingHistoryShellPage extends StatefulWidget {
  const ParkingHistoryShellPage({super.key});

  @override
  State<ParkingHistoryShellPage> createState() => _ParkingHistoryShellPageState();
}

class _ParkingHistoryShellPageState extends State<ParkingHistoryShellPage> {
  List<Widget> tabBarView = [
    const RecentlyParkingHistoryPage(),
    const OldestParkingHistoryPage(),
  ];

  @override
  Widget build(BuildContext context) {
    List<ParkingTicketEntity> vehicles = [];

    return MultiBlocListener(
      listeners: [
        BlocListener<NfcCardsBloc, NfcCardsState>(
          listener: (context, nfcCardsState) {},
        ),
        BlocListener<ParkingHistoryBloc, ParkingHistoryState>(
          listener: (context, parkingHistoryState) {},
        ),
      ],
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: CustomTopAppBar(
            routeName: AppPage.parkingHistoryShell.toName,
          ),
          body: TabBarView(children: tabBarView),
        ),
      ),
    );
  }
}
