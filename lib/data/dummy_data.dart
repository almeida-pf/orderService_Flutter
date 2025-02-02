import 'package:orders_project/core/models/battery.dart';
import 'package:orders_project/core/models/company_client.dart';

import '../core/models/nobreak.dart';
import '../core/models/battery_place.dart';

class DummyData {
  static Battery batteryData = Battery(
    id: '5454',
    rightPlace: 'Local de armazenamento limpo e adequado.',
    rightPlaceImage: 'path',
    manufacture: 'BateriasTops',
    capacity: '5kW',
    model: 'Modelo 23434',
    bank: 5,
    batteryForBank: 23,
    charger: Charger(voltage: 0.5, current: 3),
    manufacturingDate: DateTime.now(),
    hasBreaker: true,
    whatType: BatteryType.estacionaria,
  );

  static BatteryPlace placeData = BatteryPlace(
    id: '1',
    cleanPlace: true,
    reverseKey: true,
    inputFrame: false,
    outputFrame: false,
    hasMaterialsClose: true,
  );

  static Nobreak nobreakData = Nobreak(
    id: '1',
    display: true,
    nobreakWasOpened: true,
    hasCommunicationBoard: false,
    upsCurrent: UPSCurrent(input: '1', output: '2'),
    voltage: Voltage(input: '1', output: '2'),
    frequencyEquip: 'frequencyEquip',
  );

  static CompanyClient companyClient = CompanyClient(
    id: '1',
    name: 'Casas Bahia',
    tradingName: 'Magazine Luiza',
    district: 'district',
    city: 'city',
    address: 'address',
    cnpj: 14324234232,
    stateRegistration: 1212121212,
  );
}
