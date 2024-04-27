// ignore_for_file: sort_child_properties_last, avoid_print, prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable, avoid_init_to_null, must_call_super

import 'package:flutter/material.dart';

class CreateCarrera extends StatelessWidget {
  const CreateCarrera({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: TituloCreateCarrera(),
      content: TextFormField(
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Nombre',
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, 'Cancel'),
          child: const Text('spectacular'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, 'OK'),
          child: const Text('OK'),
        )
      ],
    );
  }
}

class TituloCreateCarrera extends StatelessWidget {
  const TituloCreateCarrera({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20),
      child: const Text('Agregar carrera'),
    );
  }
}
