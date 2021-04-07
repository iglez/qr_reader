import 'package:flutter/material.dart';

class MapasPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (_, i) => ListTile(
        leading: Icon(Icons.map, color: Theme.of(context).primaryColor),
        title: Text('http://'),
        subtitle: Text('ID'),
        trailing: Icon(Icons.keyboard_arrow_right, color: Colors.grey,),
        onTap: () => print('Abrir....'),
      )
    );
  }
}
