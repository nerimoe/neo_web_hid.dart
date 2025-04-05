import 'package:web/web.dart';
import 'dart:js_interop';

@JS('navigator.hid')
external Hid? get _hid;

bool canUseHid() => _hid != null;

extension type Hid._(EventTarget _) implements EventTarget {
  external JSPromise<JSArray<HIDDevice>> getDevices();
  external JSPromise<JSArray<HIDDevice>> requestDevice(JSArray option);

  external EventHandler get onconnect;
  external EventHandler get ondisconnect;
  external set onconnect(EventHandler value);
  external set ondisconnect(EventHandler value);
}

extension type HIDDevice._(EventTarget _) implements EventTarget {
  external bool get opened;
  external int get vendorId;
  external int get productId;
  external String get productName;
  external JSArray<Collection> get collections;

  external JSPromise open();
  external JSPromise close();
  external JSPromise forget();
  external JSPromise<JSDataView> receiveFeatureReport(int reportId);
  external JSPromise sendFeatureReport(int reportId, JSDataView data);
  external JSPromise sendReport(int reportId, JSDataView data);

  external EventHandler get oninputreport;
  external set oninputreport(EventHandler value);
}

extension type HIDConnectionEvent._(Event _) implements Event {
  external HIDDevice get device;
}

extension type HIDInputReportEvent._(Event _) implements Event {
  external JSDataView get data;
  external HIDDevice get device;
  external int get reportId;
}

extension type Collection._(JSObject _) implements JSObject {
  external int get usagePage;
  external int get usage;
  external int get type;
  external JSArray<Collection> get children;
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
