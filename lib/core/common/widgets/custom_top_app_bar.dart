import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../features/nfc_cards/presentation/bloc/nfc_cards_bloc.dart';
import '../../res/app_colors.dart';
import '../../routes/app_route_constants.dart';
import 'custom_icon_button.dart';

class CustomTopAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String routeName;
  final bool hasTabBar;
  final int totalNumberOfCards;
  final int totalNumberOfVehicles;
  final int totalNumberOfStaff;

  const CustomTopAppBar({
    super.key,
    required this.routeName,
    this.hasTabBar = false,
    this.totalNumberOfCards = 0,
    this.totalNumberOfVehicles = 0,
    this.totalNumberOfStaff = 0,
  });

  @override
  State<CustomTopAppBar> createState() => _CustomTopAppBarState();

  @override
  Size get preferredSize {
    return routeName == AppPage.nfcCardsShell.toName ||
            routeName == AppPage.parkingHistoryShell.toName
        ? const Size.fromHeight(110)
        : const Size.fromHeight(60);
  }
}

class _CustomTopAppBarState extends State<CustomTopAppBar> {
  final TextStyle textStyle = const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );

  void checkIfNfcAvailable() {
    BlocProvider.of<NfcCardsBloc>(context).add(
      CheckIfNfcAvailableEvent(),
    );

    if (widget.routeName == AppPage.parkingHistoryShell.toName) {
      GoRouter.of(context).pushNamed(AppPage.scanLicensePlate.toName);
    }
  }

  Widget? title() {
    if (widget.routeName == AppPage.nfcCardsShell.toName) {
      return Text(
        "Total Number Of Cards: ${widget.totalNumberOfCards}",
        style: textStyle,
      );
    } else if (widget.routeName == AppPage.parkingHistoryShell.toName) {
      return Text(
        "Total Number Of Vehicles: ${widget.totalNumberOfVehicles}",
        style: textStyle,
      );
    } else if (widget.routeName == AppPage.staff.toName) {
      return Text(
        "Total Number Of Staff: ${widget.totalNumberOfStaff}",
        style: textStyle,
      );
    } else if (widget.routeName == AppPage.signUpStaffAccount.toName) {
      return Text(
        "Create Staff Account",
        style: textStyle,
      );
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> tabs = widget.routeName == AppPage.nfcCardsShell.toName
        ? const [
            Tab(child: Text("All")),
            Tab(child: Text("Available")),
            Tab(child: Text("In Use")),
            Tab(child: Text("Lost")),
          ]
        : const [
            Tab(child: Text("Recently")),
            Tab(child: Text("Oldest")),
          ];

    return BlocListener<NfcCardsBloc, NfcCardsState>(
      listener: (context, nfcCardsState) async {},
      child: AppBar(
        title: title(),
        backgroundColor: AppColors.white2,
        actions: [
          if (widget.routeName != AppPage.signUpStaffAccount.toName)
            CustomIconButton(
              icon: Icons.add,
              onPressed: checkIfNfcAvailable,
            ),
          const SizedBox(width: 16)
        ],
        bottom: widget.routeName == AppPage.nfcCardsShell.toName ||
                widget.routeName == AppPage.parkingHistoryShell.toName
            ? TabBar(
                tabs: tabs,
              )
            : null,
      ),
    );
  }
}
