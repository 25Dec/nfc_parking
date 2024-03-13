import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/common/widgets/custom_text_button.dart';
import '../../../../../core/res/app_colors.dart';
import '../../../../../core/routes/app_route_constants.dart';
import '../../../../../core/utils/core_utils.dart';
import '../../../../nfc_cards/presentation/bloc/nfc_cards_bloc.dart';
import '../../../domain/entities/parking_ticket_entity.dart';
import '../../bloc/parking_history_bloc.dart';
import '../../widgets/parking_ticket.dart';

class RecentlyParkingHistoryPage extends StatefulWidget {
  const RecentlyParkingHistoryPage({super.key});

  @override
  State<RecentlyParkingHistoryPage> createState() => _RecentlyParkingHistoryPageState();
}

class _RecentlyParkingHistoryPageState extends State<RecentlyParkingHistoryPage> {
  @override
  void initState() {
    super.initState();
    getRecentlyParkingHistory();
  }

  Future<void> getRecentlyParkingHistory() async {}

  void onAddParkingTicket() {}

  @override
  Widget build(BuildContext context) {
    List<ParkingTicketEntity> parkingTickets = [];

    return MultiBlocListener(
      listeners: [
        BlocListener<NfcCardsBloc, NfcCardsState>(
          listener: (context, nfcCardsState) async {
            if (nfcCardsState is NfcAvailableState) {
              GoRouter.of(context).pushNamed(AppPage.scanLicensePlate.toName);
            } else if (nfcCardsState is NfcNotAvailableState) {
              CoreUtils.showCustomDialog(
                context,
                title: "NFC Is Not Enabled!",
                content: "Please enable NFC to use this feature.",
                confirmText: "Confirm",
              );
            }
          },
        ),
        BlocListener<ParkingHistoryBloc, ParkingHistoryState>(
          listener: (context, parkingHistoryState) async {},
        )
      ],
      child: RefreshIndicator(
        onRefresh: getRecentlyParkingHistory,
        child: Scaffold(
          body: parkingTickets.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: ListView.builder(
                    itemCount: parkingTickets.length,
                    itemBuilder: (_, index) => ParkingTicket(
                      data: parkingTickets[index],
                    ),
                  ),
                )
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 300,
                        height: 300,
                        child: Image.asset(
                          "assets/images/empty_bird.jpg",
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        "There Are No Parking Ticket Yet!",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 8),
                      CustomTextButton(
                        onPressed: onAddParkingTicket,
                        text: "Click here to add a new parking ticket",
                        textColor: AppColors.green,
                      )
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
