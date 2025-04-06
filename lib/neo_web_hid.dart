import 'dart:typed_data';
import 'dart:js_interop';
import 'js_classes.dart';

@JS('navigator.hid')
external JSHID? get _hid;

bool canUseHid() => _hid != null;
HID? _instance;
HID get hid {
  if (_hid != null) {
    return _instance ??= HID(_hid!);
  }
  throw 'navigator.hid unavailable';
}

class HID {
  final JSHID _interop;
  HID(this._interop);
  Function(HIDConnectionEvent event)? _onconnect;
  Function(HIDConnectionEvent event)? _ondisconnect;

  Future<List<HIDDevice>> getDevices() => _interop
      .getDevices()
      .toDart
      .then((value) => value.toDart.map((e) => HIDDevice(e)).toList());
  Future<List<HIDDevice>> requestDevice(HIDDeviceRequestOptions option) =>
      _interop
          .requestDevice(option.toJS)
          .toDart
          .then((value) => value.toDart.map((e) => HIDDevice(e)).toList());
  void onConnect(Function(HIDConnectionEvent event) func) {
    _interop.onconnect = _onConnect.toJS;
    _onconnect = func;
  }

  void onDisconnect(Function(HIDConnectionEvent event) func) {
    _interop.ondisconnect = _onDisconnect.toJS;
    _ondisconnect = func;
  }

  void _onConnect(JSHIDConnectionEvent event) {
    if (_onconnect != null) {
      _onconnect!(event.toDart);
    }
  }

  void _onDisconnect(JSHIDConnectionEvent event) {
    if (_ondisconnect != null) {
      _ondisconnect!(event.toDart);
    }
  }
}

class HIDDevice {
  final JSHIDDevice _interop;
  HIDDevice(this._interop);

  bool get opened => _interop.opened.toDart;
  int get vendorId => _interop.vendorId.toDartInt;
  int get productId => _interop.productId.toDartInt;
  String get productName => _interop.productName.toDart;
  List<HIDCollection> get collections =>
      _interop.collections.toDart.map((e) => HIDCollection(e)).toList();

  Future open() => _interop.open().toDart;
  Future close() => _interop.close().toDart;
  Future forget() => _interop.forget().toDart;
  Future<ByteData> receiveFeatureReport(int reportId) => _interop
      .receiveFeatureReport(reportId.toJS)
      .toDart
      .then((value) => value.toDart);
  Future sendFeatureReport(int reportId, ByteData data) =>
      _interop.sendFeatureReport(reportId.toJS, data.toJS).toDart;
  Future sendReport(int reportId, ByteData data) =>
      _interop.sendReport(reportId.toJS, data.toJS).toDart;

  Function(HIDInputReportEvent event)? _oninputreport;

  void onInputReport(Function(HIDInputReportEvent event) func) {
    _interop.oninputreport = _onInputReport.toJS;
    _oninputreport = func;
  }

  void _onInputReport(JSHIDInputReportEvent event) {
    if (_oninputreport != null) {
      _oninputreport!(HIDInputReportEvent(event));
    }
  }
}

class HIDCollection {
  final JSHIDCollection _interop;
  HIDCollection(this._interop);

  int get usagePage => _interop.usagePage.toDartInt;
  int get usage => _interop.usage.toDartInt;
  int get type => _interop.type.toDartInt;
  List<HIDCollection> get children =>
      _interop.children.toDart.map((e) => HIDCollection(e)).toList();
}

class HIDInputReportEvent {
  final JSHIDInputReportEvent _interop;
  HIDInputReportEvent(this._interop);

  ByteData get data => _interop.data.toDart;
  HIDDevice get device => HIDDevice(_interop.device);
  int get reportId => _interop.reportId.toDartInt;
}

class HIDConnectionEvent {
  final JSHIDConnectionEvent _interop;
  HIDConnectionEvent(this._interop);
  HIDDevice get device => _interop.device.toDart;
}

/*
Examples:
final filter = HIDDeviceRequestOptions(filters: JSArray());

final filter = HIDDeviceRequestOptions(
  filters: [RequestOptionsFilter(vendorId: 0xF822)].toJS,
);
*/

class HIDDeviceRequestOptions {
  JSHIDDeviceRequestOptions? _interop;
  HIDDeviceRequestOptions({List<RequestOptionsFilter>? filters}) {
    _interop = JSHIDDeviceRequestOptions(filters: filters!.toJS);
  }
  JSHIDDeviceRequestOptions get toJS => _interop!;
}

extension type RequestOptionsFilter._(JSObject _) implements JSObject {
  external RequestOptionsFilter({
    int vendorId,
    int productId,
    int usage,
    int usagePage,
  });
}
