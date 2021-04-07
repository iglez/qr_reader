import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/providers/scan_list_provider.dart';

class ScanTiles extends StatelessWidget {
  final String tipo;

  const ScanTiles({@required this.tipo});

  @override
  Widget build(BuildContext context) {

    final scanLisProvider =
        Provider.of<ScanListProvider>(context, listen: true);

    return ListView.builder(
      itemCount: scanLisProvider.scans.length,
      itemBuilder: (_, i) => Dismissible(
        key: UniqueKey(),
        background: Container(
          color: Colors.red,
        ),
        onDismissed: (DismissDirection direction) {
          Provider.of<ScanListProvider>(context, listen: false)
              .borrarScansPorId(scanLisProvider.scans[i].id);
        },
        child: ListTile(
          leading: Icon(
            this.tipo == 'http'
              ? Icons.home_outlined
              : Icons.map_outlined,
            color: Theme.of(context).primaryColor
          ),
          title: Text(scanLisProvider.scans[i].valor),
          subtitle: Text(scanLisProvider.scans[i].id.toString()),
          trailing: Icon(
            Icons.keyboard_arrow_right,
            color: Colors.grey,
          ),
          onTap: () =>
              print('Abrir.... ${scanLisProvider.scans[i].id.toString()}'),
        ),
      )
    );
  }
}
