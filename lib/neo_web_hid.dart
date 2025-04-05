import 'dart:typed_data';

import 'package:web/web.dart';
import 'dart:js_interop';

@JS('navigator.hid')
external JSHid? get hid;

bool canUseHid() => hid != null;

class Hid {}

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

  Function(HIDInputReportEvent event)? oninputreport;

  void onInputReport(Function(HIDInputReportEvent event) func) {
    _interop.oninputreport = _onInputReport.toJS;
    oninputreport = func;
  }

  void _onInputReport(JSHIDInputReportEvent event) {
    if (oninputreport != null) {
      oninputreport!(HIDInputReportEvent(event));
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

extension type JSHid._(EventTarget _) implements EventTarget {
  external JSPromise<JSArray<JSHIDDevice>> getDevices();
  external JSPromise<JSArray<JSHIDDevice>> requestDevice(JSArray option);

  external EventHandler get onconnect;
  external EventHandler get ondisconnect;
  external set onconnect(EventHandler value);
  external set ondisconnect(EventHandler value);
}

extension type JSHIDDevice._(EventTarget _) implements EventTarget {
  external JSBoolean get opened;
  external JSNumber get vendorId;
  external JSNumber get productId;
  external JSString get productName;
  external JSArray<JSHIDCollection> get collections;

  external JSPromise open();
  external JSPromise close();
  external JSPromise forget();
  external JSPromise<JSDataView> receiveFeatureReport(JSNumber reportId);
  external JSPromise sendFeatureReport(JSNumber reportId, JSDataView data);
  external JSPromise sendReport(JSNumber reportId, JSDataView data);

  external EventHandler get oninputreport;
  external set oninputreport(EventHandler value);
}

extension type JSHIDConnectionEvent._(Event _) implements Event {
  external JSHIDDevice get device;
}

extension type JSHIDInputReportEvent._(Event _) implements Event {
  external JSDataView get data;
  external JSHIDDevice get device;
  external JSNumber get reportId;
}

extension type JSHIDCollection._(JSObject _) implements JSObject {
  external JSNumber get usagePage;
  external JSNumber get usage;
  external JSNumber get type;
  external JSArray<JSHIDCollection> get children;
}

/*
Examples:
final filter = HIDDeviceRequestOptions(filters: JSArray());

final filter = HIDDeviceRequestOptions(
  filters: [RequestOptionsFilter(vendorId: 0xF822)].toJS,
);
*/

extension type HIDDeviceRequestOptions._(JSArray<JSAny?> filters)
    implements JSArray<JSAny?> {
  external HIDDeviceRequestOptions({JSArray<RequestOptionsFilter> filters});
}

extension type RequestOptionsFilter._(JSObject _) implements JSObject {
  external RequestOptionsFilter({
    int vendorId,
    int productId,
    int usage,
    int usagePage,
  });
}
