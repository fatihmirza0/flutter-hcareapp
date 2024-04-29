import 'package:flutter/material.dart';

void main() => runApp(SickInformation());

class Medicine {
  String name;

  Medicine(this.name);
}

class SickInformation extends StatefulWidget {
  @override
  _SickInformationState createState() => _SickInformationState();
}

class _SickInformationState extends State<SickInformation> {
  final List<String> kanGruplari = [
    'A Rh(+)',
    'A Rh(-)',
    'B Rh(+)',
    'B Rh(-)',
    'AB Rh(+)',
    'AB Rh(-)',
    '0 Rh(+)',
    '0 Rh(-)',
  ];

  final List<String> kaliciHastaliklar = [
    'Diyabet',
    'Hipertansiyon',
    'Kanser',
    'Astım',
    'Obezite',
    'Tiroid Hastalıkları',
    'Yüksek Kolesterol',
    // İstediğiniz kadar hastalık ekleyebilirsiniz
  ];

  final List<String> selectedKaliciHastaliklar = [];
  final List<String> ilaclar = [];
  final List<String> hastaliklar = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sağlık Bilgileri'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Kan Grubu',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10.0),
            DropdownButtonFormField<String>(
              items: kanGruplari.map((String kanGrubu) {
                return DropdownMenuItem<String>(
                  value: kanGrubu,
                  child: Text(kanGrubu),
                );
              }).toList(),
              onChanged: (String? value) {},
              decoration: const InputDecoration(
                hintText: 'Kan grubunuzu seçin',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20.0),
            const Text(
              'Kalıcı Hastalıklar',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10.0),
            Wrap(
              children: kaliciHastaliklar.map((String hastalik) {
                return Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: FilterChip(
                    label: Text(hastalik),
                    onSelected: (bool selected) {
                      setState(() {
                        if (selected) {
                          selectedKaliciHastaliklar.add(hastalik);
                        } else {
                          selectedKaliciHastaliklar.remove(hastalik);
                        }
                      });
                    },
                    selected: selectedKaliciHastaliklar.contains(hastalik),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 20.0),
            _buildIlaclarDropdown(),
            const SizedBox(height: 20.0),
            _not(),
            const SizedBox(height: 20.0),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Kaydetme işlemi
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                      vertical: 12.0, horizontal: 50.0),
                  backgroundColor: Colors.blueGrey[100],
                  elevation: 3, // Gölgelenme miktarı
                  shadowColor: Colors.black, // Gölgelenme rengi
                ),
                child: const Text(
                  'Kaydet',
                  style: TextStyle(fontSize: 18.0, color: Colors.black54),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildIlaclarDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Kullanılan İlaçlar',
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10.0),
        Wrap(
          children: ilaclar.map((String ilac) {
            return Padding(
              padding: const EdgeInsets.all(4.0),
              child: FilterChip(
                label: Text(ilac),
                onSelected: (_) {},
                selected: true,
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 10.0),
        ElevatedButton(
          onPressed: () {
            _showIlaclarDialog();
          },
          child: const Text('İlaç Ekle'),
        ),
      ],
    );
  }

  Future<void> _showIlaclarDialog() async {
    final TextEditingController ilacController = TextEditingController();

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('İlaç Ekle'),
          content: TextFormField(
            controller: ilacController,
            decoration: const InputDecoration(
              hintText: 'İlacı girin',
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                setState(() {
                  ilaclar.add(ilacController.text);
                });
                Navigator.of(context).pop();
              },
              child: const Text('Ekle'),
            ),
          ],
        );
      },
    );
  }

  Widget _not() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Eklemek İstediğiniz Notları Yazabilirsiniz',
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10.0),
        TextFormField(
          maxLines: 3,
          decoration: const InputDecoration(
            hintText: 'Eklemek İstediğiniz Notları Yazabilirsiniz',
            border: OutlineInputBorder(),
          ),
        ),
      ],
    );
  }
}
