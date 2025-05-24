import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/poi.dart';
import '../providers/poi_provider.dart';

class AddPOIScreen extends StatefulWidget {
  static const routeName = '/add-poi';
  const AddPOIScreen({super.key});

  @override
  State<AddPOIScreen> createState() => _AddPOIScreenState();
}

class _AddPOIScreenState extends State<AddPOIScreen> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _description = '';
  double _latitude = 0.0;
  double _longitude = 0.0;

  void _saveForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Provider.of<POIProvider>(context, listen: false).addPoint(
        POI(
          name: _name,
          description: _description,
          latitude: _latitude,
          longitude: _longitude,
        ),
      );
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Adicionar Ponto')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Nome'),
                onSaved: (val) => _name = val!,
                validator: (val) => val!.isEmpty ? 'Informe o nome' : null,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Descrição'),
                onSaved: (val) => _description = val!,
                validator: (val) => val!.isEmpty ? 'Informe a descrição' : null,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Latitude'),
                keyboardType: TextInputType.number,
                onSaved: (val) => _latitude = double.parse(val!),
                validator: (val) => val!.isEmpty ? 'Informe a latitude' : null,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Longitude'),
                keyboardType: TextInputType.number,
                onSaved: (val) => _longitude = double.parse(val!),
                validator: (val) => val!.isEmpty ? 'Informe a longitude' : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveForm,
                child: const Text('Salvar'),
              )
            ],
          ),
        ),
      ),
    );
  }
}