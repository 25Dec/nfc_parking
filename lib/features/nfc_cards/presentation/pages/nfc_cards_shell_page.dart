import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/common/widgets/custom_top_app_bar.dart';
import '../../../../core/routes/app_route_constants.dart';
import '../../domain/entities/nfc_card_entity.dart';
import '../bloc/nfc_cards_bloc.dart';
import 'sub_pages/all_nfc_cards_page.dart';
import 'sub_pages/available_nfc_cards_page.dart';
import 'sub_pages/in_use_nfc_cards_page.dart';
import 'sub_pages/lost_nfc_cards_page.dart';

class NfcCardsShellPage extends StatefulWidget {
  const NfcCardsShellPage({super.key});

  @override
  State<NfcCardsShellPage> createState() => _NfcCardsShellPageState();
}

class _NfcCardsShellPageState extends State<NfcCardsShellPage> {
  List<Widget> tabBarView = [
    const AllNfcCardsPage(),
    const AvailableNfcCardsPage(),
    const InUseNfcCardsPage(),
    const LostNfcCardsPage(),
  ];

  @override
  void initState() {
    super.initState();
    BlocProvider.of<NfcCardsBloc>(context).add(
      GetAllNfcCardsEvent(),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<NfcCardEntity> cards = [];

    return BlocBuilder<NfcCardsBloc, NfcCardsState>(
      builder: (context, nfcCardsState) {
        if (nfcCardsState is DoneGettingAllNfcCardsState) {
          cards = nfcCardsState.cards;
        }
        return DefaultTabController(
          length: 4,
          child: Scaffold(
            appBar: CustomTopAppBar(
              routeName: AppPage.nfcCardsShell.toName,
              totalNumberOfCards: cards.length,
            ),
            body: TabBarView(children: tabBarView),
          ),
        );
      },
    );
  }
}
