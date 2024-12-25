extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}

extension WilayaParsing on String {
  String serialize() {
    return replaceAll(RegExp(r'^\d+-\s*'), '');
  }

  static String deserialize(String wilaya) {
    return switch (wilaya) {
      'Adrar' => '1- Adrar',
      'Chlef' => '2- Chlef',
      'Laghouat' => '3- Laghouat',
      'Oum El Bouaghi' => '4- Oum El Bouaghi',
      'Batna' => '5- Batna',
      'Béjaïa' => '6- Béjaïa',
      'Biskra' => '7- Biskra',
      'Béchar' => '8- Béchar',
      'Blida' => '9- Blida',
      'Bouira' => '10- Bouira',
      'Tamanghasset' => '11- Tamanghasset',
      'Tébessa' => '12- Tébessa',
      'Tlemcen' => '13- Tlemcen',
      'Tiaret' => '14- Tiaret',
      'Tizi Ouzou' => '15- Tizi Ouzou',
      'Alger' => '16- Alger',
      'Djelfa' => '17- Djelfa',
      'Jijel' => '18- Jijel',
      'Sétif' => '19- Sétif',
      'Saïda' => '20- Saïda',
      'Skikda' => '21- Skikda',
      'Sidi Bel Abbès' => '22- Sidi Bel Abbès',
      'Annaba' => '23- Annaba',
      'Guelma' => '24- Guelma',
      'Constantine' => '25- Constantine',
      'Médéa' => '26- Médéa',
      'Mostaganem' => '27- Mostaganem',
      'M\'Sila' => '28- M\'Sila',
      'Mascara' => '29- Mascara',
      'Ouargla' => '30- Ouargla',
      'Oran' => '31- Oran',
      'El Bayadh' => '32- El Bayadh',
      'Illizi' => '33- Illizi',
      'Bordj Bou Arréridj' => '34- Bordj Bou Arréridj',
      'Boumerdès' => '35- Boumerdès',
      'El Tarf' => '36- El Tarf',
      'Tindouf' => '37- Tindouf',
      'Tissemsilt' => '38- Tissemsilt',
      'El Oued' => '39- El Oued',
      'Khenchela' => '40- Khenchela',
      'Souk Ahras' => '41- Souk Ahras',
      'Tipaza' => '42- Tipaza',
      'Mila' => '43- Mila',
      'Aïn Defla' => '44- Aïn Defla',
      'Naâma' => '45- Naâma',
      'Aïn Témouchent' => '46- Aïn Témouchent',
      'Ghardaïa' => '47- Ghardaïa',
      'Relizane' => '48- Relizane',
      'Timimoun' => '49- Timimoun',
      'Bordj Badji Mokhtar' => '50- Bordj Badji Mokhtar',
      'Ouled Djellal' => '51- Ouled Djellal',
      'Béni Abbès' => '52- Béni Abbès',
      'Salah' => '53- Salah',
      'Guezzam' => '54- Guezzam',
      'Touggourt' => '55- Touggourt',
      'Djanet' => '56- Djanet',
      'M\'Ghair' => '57- M\'Ghair',
      'Meniaa' => '58- Meniaa',
      _ => wilaya,
    };
  }
}
