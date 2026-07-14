// Copyright 2013 The Flutter Authors
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import UIKit

/// A protocol which provides the user interface idiom (phone, pad, etc.).
/// It exists to allow replacing UIDevice in tests.
protocol DeviceTypeProvider {
  /// Returns the interface idiom for the device.
  var userInterfaceIdiom: UIUserInterfaceIdiom { get }
}

/// A default implementation of DeviceTypeProvider.
///
/// By default it reads the interface idiom from the current device via
/// UIDevice. The idiom is constant for the process lifetime, so callers on the
/// main thread can resolve it once and pass it in to avoid reading UIDevice on
/// a background queue (which can trigger Main Thread Checker warnings).
@objc public class DefaultDeviceTypeProvider: NSObject, DeviceTypeProvider {
  private let cachedUserInterfaceIdiom: UIUserInterfaceIdiom

  /// Creates a provider that reads the interface idiom from the current device.
  /// Must be called on the main thread.
  @objc public override init() {
    cachedUserInterfaceIdiom = UIDevice.current.userInterfaceIdiom
  }

  /// Creates a provider with a pre-resolved interface idiom.
  @objc public init(userInterfaceIdiom: UIUserInterfaceIdiom) {
    cachedUserInterfaceIdiom = userInterfaceIdiom
  }

  @objc public var userInterfaceIdiom: UIUserInterfaceIdiom {
    return cachedUserInterfaceIdiom
  }
}
