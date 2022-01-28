import 'dart:async';

class BaseBloc {
  StreamController _streamControllerToast = StreamController<String>();

  Stream<dynamic> get showToastStream => _streamControllerToast.stream;

  StreamSink<dynamic> get showToastSink => _streamControllerToast.sink;

  dispose() {
    _streamControllerToast.close();
  }
}
