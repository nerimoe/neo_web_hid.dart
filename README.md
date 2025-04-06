<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/tools/pub/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/to/develop-packages).
-->

## Intro

A new webhid wrapper for Flutter Web via package:web and dart:js_interop, refrenced this [woodemi/web_hid.dart](https://github.com/woodemi/web_hid.dart)

## Usage

```dart
if (!canUseHid()) return;

final requestOptions = HIDDeviceRequestOptions(
    filters: [RequestOptionsFilter(vendorId: 0x1234)]);

hid.requestDevice(requestOptions).then(
    (devices) {
        devices.First.open();
    }
)
```
