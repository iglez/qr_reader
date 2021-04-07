import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/providers/scan_list_provider.dart';

class MapasPage extends StatelessWidget {
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
          child: ListTile(
            leading: Icon(Icons.map, color: Theme.of(context).primaryColor),
            title: Text(scanLisProvider.scans[i].valor),
            subtitle: Text(scanLisProvider.scans[i].id.toString()),
            trailing: Icon(
              Icons.keyboard_arrow_right,
              color: Colors.grey,
            ),
            onTap: () =>
                print('Abrir.... ${scanLisProvider.scans[i].id.toString()}'),
          ),
        ));
  }
}
