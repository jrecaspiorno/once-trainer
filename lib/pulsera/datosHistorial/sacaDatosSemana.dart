import 'package:health/health.dart';

Future <List<HealthDataPoint>> MySacaDatosSemana(String tipo) async{
  var _healthKitOutput;
  var _healthDataList = List<HealthDataPoint>();
  bool _isAuthorized = false;

  // Sacamos el tipo de datos
  HealthDataType tipoEntrada;
    if(tipo == "WEIGHT")
      tipoEntrada = HealthDataType.WEIGHT;
    if(tipo == "HEART_RATE")
      tipoEntrada = HealthDataType.HEART_RATE;
    if(tipo == "ACTIVE_ENERGY_BURNED")
      tipoEntrada = HealthDataType.ACTIVE_ENERGY_BURNED;


    // Lista de variables
    List<HealthDataType> types = [
      HealthDataType.WEIGHT,
      HealthDataType.HEART_RATE,
      HealthDataType.ACTIVE_ENERGY_BURNED,
    ];


    DateTime endDate = DateTime.now();
    DateTime startDate = endDate.subtract(Duration(days: 7));

     Future.delayed(Duration(seconds: 2), () async {
      _isAuthorized = await Health.requestAuthorization();

      if (_isAuthorized) {

          try {
              List<HealthDataPoint> healthData = await Health
                  .getHealthDataFromType(startDate, endDate, tipoEntrada);
              _healthDataList.addAll(healthData);

          } catch (exception) {
            print("hola desde dentro");
            print(exception.toString());
          }
        //}

        for (var healthData in _healthDataList) {
          print("Data: $healthData");
        }
      }
      else {
        print('Not authorized');
      }
      print(_healthDataList);

      return _healthDataList;
    }).timeout(const Duration (seconds: 5), onTimeout: (){
        throw('Timeout');
     });
      // .timeout(const Duration (seconds: 5), onTimeout: () => _onTimeout());
      // .then((List<HealthDataPoint> lista) => lista);
  
    print("hola desde fuera");
    print(_healthDataList);
    //_healthDataList = then(_completer.future);
}

_onTimeout() => print("Time Out occurs");