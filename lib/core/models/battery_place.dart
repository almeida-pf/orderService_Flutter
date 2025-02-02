enum Ventilation { naotem, arcondicionado, exautor }

enum Ilumination { normal, good, moderate, bad }

class BatteryPlace {
  final String id;
  final String? temp;
  final Ilumination? lights;
  final Ventilation? ventilation;
  final bool cleanPlace;
  final bool reverseKey;
  final bool inputFrame;
  final bool outputFrame;
  final bool hasMaterialsClose;
  final String? materialsClose;

  BatteryPlace({
    required this.id,
    required this.cleanPlace,
    required this.reverseKey,
    required this.inputFrame,
    required this.outputFrame,
    required this.hasMaterialsClose,
    this.temp,
    this.lights,
    this.ventilation,
    this.materialsClose,
  });

  factory BatteryPlace.fromJson(Map<String, dynamic> json, id) {
    return BatteryPlace(
      id: id,
      cleanPlace: json['cleanPlace'],
      reverseKey: json['reverseKey'],
      inputFrame: json['inputFrame'],
      outputFrame: json['outputFrame'],
      hasMaterialsClose: json['hasMaterialsClose'],
      temp: json['temp'] ?? '',
      lights: Ilumination.values.elementAt(json['lights']),
      ventilation: Ventilation.values.elementAt(json['ventilation']),
      materialsClose: json['materialsClose'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'cleanPlace': cleanPlace,
        'reverseKey': reverseKey,
        'inputFrame': inputFrame,
        'outputFrame': outputFrame,
        'hasMaterialsClose': hasMaterialsClose,
        'temp': temp,
        'lights': lights?.index ?? 0,
        'ventilation': ventilation?.index ?? 0,
        'materialsClose': materialsClose,
      };
}

// --------------------
//-----Identificador de local
//String? - Temperatura
//Opcional - Iluminação - Bom, razoavel e ruim 
//Enum? - Tipo de ventilação = Arcondicionado, exaustor e não possui ventilação
//Enum? - local limpo yes or not
//Enum - Possui chave reversora externa? bool 
//Enum - Quadro de entrada yes or not bool 
//Enum - Quadro de Saída yes or not bool 
//bool - Materiais depositados proximos ao equipamento. yes or not -> Se sim = String o que é.