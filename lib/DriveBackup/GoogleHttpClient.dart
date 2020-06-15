
import 'package:http/http.dart' as http;

class GoogleHttpClient extends http.BaseClient { 
  final http.Client _baseClient;
  Map<String, String> _headers;  
  GoogleHttpClient(this._headers,this._baseClient) : super();  
  @override  
  Future<http.StreamedResponse> send(http.BaseRequest request) { 
      request..headers.addAll(_headers);  
      return _baseClient.send(request);
  }
  @override  
  Future<http.Response> head(Object url, {Map<String, String> headers}) =>  
      super.head(url, headers: headers..addAll(_headers));  
}