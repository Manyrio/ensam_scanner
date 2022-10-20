import 'package:decorated_icon/decorated_icon.dart';
import 'package:ensam_scanner/models/user.dart';
import 'package:ensam_scanner/states/scan_state.dart';
import 'package:ensam_scanner/utils.dart';
import 'package:flutter/material.dart';

class ScanUserTile extends StatelessWidget {

  ScannedUser? scannedUser;
  ScanUserTile({this.scannedUser, super.key});

  @override
  Widget build(BuildContext context) {

    String description = getDifference(scannedUser!.date);

    return SizedBox(
      height: 55,
      child: Row(
        children: [

          const SizedBox(width: 20),

          Icon(Icons.person_outlined, color: Theme.of(context).hintColor,),

          const SizedBox(width: 15),
          Expanded(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(scannedUser!.userModel!.name ?? '', style: TextStyle(fontWeight: FontWeight.w600),),
                  Text(description, style: TextStyle(color: Theme.of(context).hintColor, fontSize: 12),)
                ]
            ),
          ),
          const SizedBox(width: 20)

        ],
      ),
    );

  }

}

class ScanAppBar extends StatelessWidget {

  const ScanAppBar({super.key});

  @override
  Widget build(BuildContext context) {

    return AppBar(
      backgroundColor: Theme.of(context).backgroundColor.withOpacity(.0),
      elevation: 0,
      foregroundColor: Theme.of(context).accentColor,
      automaticallyImplyLeading: false,
      shadowColor: Theme.of(context).dividerColor,
      title: Row(
        children: [

          const ScanIcon(),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 2),
              child: Text(
                "Scan",
                maxLines: 1,
                overflow: TextOverflow.clip,
                softWrap: false,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: Colors.white,
                  shadows: [
                    BoxShadow(
                        color: Colors.black.withOpacity(.8),
                        offset: const Offset(0.0, 0.0),
                        blurRadius: 8.0,
                        spreadRadius: 0
                    )
                  ],
                ),
              ),
            ),
          ),

        ],
      ),
      actions: const [ScanSearch()],
    );

  }

}

class ScanSearch extends StatelessWidget {

  const ScanSearch({super.key});

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.only(right: 5, bottom: .5),
      child: Center(
        child: Container(
          height: 45, width: 45,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: Material(
            type: MaterialType.transparency,
            borderRadius: const BorderRadius.all(Radius.circular(25.0)),
            child: InkWell(
                borderRadius: const BorderRadius.all(Radius.circular(25.0)),
                onTap: () {},
                child: Center(
                    child: DecoratedIcon(
                      Icons.search,
                      color: Colors.white,
                      size: 22.0,
                      shadows: [
                        BoxShadow(
                            color: Colors.black.withOpacity(.8),
                            offset: const Offset(0.0, 0.0),
                            blurRadius: 8.0,
                            spreadRadius: 0
                        )
                      ],
                    )
                )
            ),
          ),
        ),
      ),
    );

  }

}

class ScanIcon extends StatelessWidget {

  const ScanIcon({super.key});

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.only(right: 15, bottom: .5),
      child: Center(
        child: Container(
          height: 45, width: 45,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: Center(
              child: DecoratedIcon(
                Icons.qr_code_scanner,
                color: Colors.white,
                size: 22.0,
                shadows: [
                  BoxShadow(
                      color: Colors.black.withOpacity(.8),
                      offset: const Offset(0.0, 0.0),
                      blurRadius: 8.0,
                      spreadRadius: 0
                  )
                ],
              )
          ),
        ),
      ),
    );

  }

}

class GrabbingWidget extends StatelessWidget {

  ScanState state;
  GrabbingWidget(this.state, {super.key});

  @override
  Widget build(BuildContext context) {

    ScannedUser? lastUser = state.getLastScan();

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(.3),
              offset: const Offset(0.0, 0.0),
              blurRadius: 8.0,
              spreadRadius: 0
          )
        ],
        borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          Container(
            margin: const EdgeInsets.only(top: 10),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Theme.of(context).dividerColor,
              borderRadius: BorderRadius.circular(5),
            ),
          ),

          Row(
            children: [

              const SizedBox(width: 20),
              Icon(Icons.bar_chart_outlined, color: Theme.of(context).hintColor,),
              const SizedBox(width: 15),
              (lastUser != null) ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(lastUser.userModel!.name ?? '', style: const TextStyle(fontWeight: FontWeight.w600),),
                    Text('Dernier scan', style: TextStyle(color: Theme.of(context).hintColor, fontSize: 12),),
                  ]
              ) : Text(
                  "En attente d'un scan",
                  style: TextStyle(color: Theme.of(context).hintColor)
              ),
              const SizedBox(width: 20)
            ],
          ),

          const Divider(height: 1,)
        ],
      ),
    );
  }
}