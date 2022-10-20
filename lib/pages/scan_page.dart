import 'package:ensam_scanner/models/user.dart';
import 'package:ensam_scanner/states/scan_state.dart';
import 'package:ensam_scanner/widgets/scan_widgets.dart';
import 'package:flutter/material.dart';

import 'package:scan/scan.dart';
import 'package:provider/provider.dart';
import 'package:snapping_sheet/snapping_sheet.dart';

class ScanPage extends StatefulWidget {
  @override
  _ScanPage createState() => _ScanPage();
}

class _ScanPage extends State<ScanPage> with TickerProviderStateMixin {

  ScanController controller = ScanController();
  late List<SnappingPosition> snappingPositions;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    snappingPositions = [
      const SnappingPosition.factor(
        positionFactor: 0.0,
        snappingDuration: Duration(milliseconds: 300),
        grabbingContentOffset: GrabbingContentOffset.top,
      ),
      const SnappingPosition.factor(
        snappingDuration: Duration(milliseconds: 300),
        positionFactor: 0.5,
      ),
      SnappingPosition.pixels(
        grabbingContentOffset: GrabbingContentOffset.bottom,
        snappingDuration: const Duration(milliseconds: 300),
        positionPixels: MediaQuery.of(context).size.height-MediaQuery.of(context).padding.top-65,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {

    return Consumer<ScanState>(

        child: Column(
          children: [
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text('Historique de scan', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18)),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text('Retrouve ici tous les scans que tu as effectué pendant la session actuelle',
                  style: TextStyle(color: Theme.of(context).hintColor, fontSize: 12)),
            ),
            const SizedBox(height: 5),
          ],
        ),

        builder: (context, state, child) {

          return Scaffold(
              extendBodyBehindAppBar: true,
              appBar: PreferredSize(
                preferredSize: const Size.fromHeight(70),
                child: Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: <Color>[
                          Colors.black.withOpacity(.65),
                          Colors.black.withOpacity(.0),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      )
                  ),
                  child: const ScanAppBar(),
                ),
              ),
              backgroundColor: Colors.black,
              body: SnappingSheet(
                grabbingHeight: 65,
                snappingPositions: snappingPositions,
                grabbing: GrabbingWidget(state),
                sheetBelow: SnappingSheetContent(
                    draggable: true,
                    child: Container(
                      color: Colors.white,
                      child: Material(
                        type: MaterialType.transparency,
                        child: ListView(
                          padding: EdgeInsets.zero,
                          children: [

                            child ?? Container(),

                            ListView.builder(
                              shrinkWrap: true,
                              primary: false,
                              padding: EdgeInsets.zero,
                              itemBuilder: (context, index) {
                                return ScanUserTile(scannedUser: state.history[index]);
                              },
                              itemCount: state.history.length,
                            ),

                          ],
                        ),
                      ),
                    )
                ),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: ScanView(
                    controller: controller,
                    scanAreaScale: .75,
                    scanLineColor: Colors.green.shade400,
                    onCapture: (data) async {
                      UserModel? scannedUser = await state.newScan(context, data);

                      controller.resume();
                    },
                  ),
                ),
              )
          );
        }
    );
  }
}