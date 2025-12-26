import 'package:web/web.dart';
import 'dart:js_interop';
import 'neo_web_hid.dart';

extension type JSHID._(EventTarget _) implements EventTarget {
  external JSPromise<JSArray<JSHIDDevice>> getDevices();
  external JSPromise<JSArray<JSHIDDevice>> requestDevice(
      JSHIDDeviceRequestOptions option);

  external EventHandler get onconnect;
  external EventHandler get ondisconnect;
  external set onconnect(EventHandler value);
  external set ondisconnect(EventHandler value);
  HID get toDart => HID(this);
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
  HIDDevice get toDart => HIDDevice(this);
}

extension type JSHIDConnectionEvent._(Event _) implements Event {
  external JSHIDDevice get device;
  HIDConnectionEvent get toDart => HIDConnectionEvent(this);
}

extension type JSHIDInputReportEvent._(Event _) implements Event {
  external JSDataView get data;
  external JSHIDDevice get device;
  external JSNumber get reportId;
  HIDInputReportEvent get toDart => HIDInputReportEvent(this);
}

extension type JSHIDCollection._(JSObject _) implements JSObject {
  external JSNumber get usagePage;
  external JSNumber get usage;
  external JSNumber get type;
  external JSArray<JSHIDCollection> get children;
  HIDCollection get toDart => HIDCollection(this);
}

extension type JSHIDDeviceRequestOptions._(JSObject _) implements JSObject {
  external factory JSHIDDeviceRequestOptions(
      {JSArray<JSHIDDeviceFilter> filters});
}

extension type JSHIDDeviceFilter._(JSObject _) implements JSObject {
  external factory JSHIDDeviceFilter({
    int? vendorId,
    int? productId,
    int? usagePage,
    int? usage,
  });
  external set vendorId(int value);
  external set productId(int value);
  external set usagePage(int value);
  external set usage(int value);
}
