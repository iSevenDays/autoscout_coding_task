// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

#if os(OSX)
  import AppKit.NSImage
  internal typealias AssetColorTypeAlias = NSColor
  internal typealias AssetImageTypeAlias = NSImage
#elseif os(iOS) || os(tvOS) || os(watchOS)
  import UIKit.UIImage
  internal typealias AssetColorTypeAlias = UIColor
  internal typealias AssetImageTypeAlias = UIImage
#endif

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
internal enum Assets {
  internal static let accentColor = ColorAsset(name: "AccentColor")
  internal static let colorAppleDark = ColorAsset(name: "ColorAppleDark")
  internal static let colorAppleLight = ColorAsset(name: "ColorAppleLight")
  internal static let colorBlueBerryDark = ColorAsset(name: "ColorBlueBerryDark")
  internal static let colorBlueBerryLight = ColorAsset(name: "ColorBlueBerryLight")
  internal static let colorCherryDark = ColorAsset(name: "ColorCherryDark")
  internal static let colorCherryLight = ColorAsset(name: "ColorCherryLight")
  internal static let colorGooseberryDark = ColorAsset(name: "ColorGooseberryDark")
  internal static let colorGooseberryLight = ColorAsset(name: "ColorGooseberryLight")
  internal static let colorGrapefruitDark = ColorAsset(name: "ColorGrapefruitDark")
  internal static let colorGrapefruitLight = ColorAsset(name: "ColorGrapefruitLight")
  internal static let colorLemonDark = ColorAsset(name: "ColorLemonDark")
  internal static let colorLemonLight = ColorAsset(name: "ColorLemonLight")
  internal static let colorLimeDark = ColorAsset(name: "ColorLimeDark")
  internal static let colorLimeLight = ColorAsset(name: "ColorLimeLight")
  internal static let colorMangoDark = ColorAsset(name: "ColorMangoDark")
  internal static let colorMangoLight = ColorAsset(name: "ColorMangoLight")
  internal static let colorPearDark = ColorAsset(name: "ColorPearDark")
  internal static let colorPearLight = ColorAsset(name: "ColorPearLight")
  internal static let colorPlumDark = ColorAsset(name: "ColorPlumDark")
  internal static let colorPlumLight = ColorAsset(name: "ColorPlumLight")
  internal static let colorPomegranateDark = ColorAsset(name: "ColorPomegranateDark")
  internal static let colorPomegranateLight = ColorAsset(name: "ColorPomegranateLight")
  internal static let colorStrawberryDark = ColorAsset(name: "ColorStrawberryDark")
  internal static let colorStrawberryLight = ColorAsset(name: "ColorStrawberryLight")
  internal static let colorWatermelonDark = ColorAsset(name: "ColorWatermelonDark")
  internal static let colorWatermelonLight = ColorAsset(name: "ColorWatermelonLight")
  internal static let apple = ImageAsset(name: "apple")
  internal static let blueberry = ImageAsset(name: "blueberry")
  internal static let cherry = ImageAsset(name: "cherry")
  internal static let gooseberry = ImageAsset(name: "gooseberry")
  internal static let grapefruit = ImageAsset(name: "grapefruit")
  internal static let lemon = ImageAsset(name: "lemon")
  internal static let lime = ImageAsset(name: "lime")
  internal static let mango = ImageAsset(name: "mango")
  internal static let pear = ImageAsset(name: "pear")
  internal static let plum = ImageAsset(name: "plum")
  internal static let pomegranate = ImageAsset(name: "pomegranate")
  internal static let strawberry = ImageAsset(name: "strawberry")
  internal static let watermelon = ImageAsset(name: "watermelon")
  internal static let logo = ImageAsset(name: "logo")
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

internal struct ColorAsset {
  internal fileprivate(set) var name: String

  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, OSX 10.13, *)
  internal var color: AssetColorTypeAlias {
    return AssetColorTypeAlias(asset: self)
  }
}

internal extension AssetColorTypeAlias {
  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, OSX 10.13, *)
  convenience init!(asset: ColorAsset) {
    let bundle = Bundle(for: BundleToken.self)
    #if os(iOS) || os(tvOS)
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(OSX)
    self.init(named: NSColor.Name(asset.name), bundle: bundle)
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

internal struct DataAsset {
  internal fileprivate(set) var name: String

  #if os(iOS) || os(tvOS) || os(OSX)
  @available(iOS 9.0, tvOS 9.0, OSX 10.11, *)
  internal var data: NSDataAsset {
    return NSDataAsset(asset: self)
  }
  #endif
}

#if os(iOS) || os(tvOS) || os(OSX)
@available(iOS 9.0, tvOS 9.0, OSX 10.11, *)
internal extension NSDataAsset {
  convenience init!(asset: DataAsset) {
    let bundle = Bundle(for: BundleToken.self)
    #if os(iOS) || os(tvOS)
    self.init(name: asset.name, bundle: bundle)
    #elseif os(OSX)
    self.init(name: NSDataAsset.Name(asset.name), bundle: bundle)
    #endif
  }
}
#endif

internal struct ImageAsset {
  internal fileprivate(set) var name: String

  internal var image: AssetImageTypeAlias {
    let bundle = Bundle(for: BundleToken.self)
    #if os(iOS) || os(tvOS)
    let image = AssetImageTypeAlias(named: name, in: bundle, compatibleWith: nil)
    #elseif os(OSX)
    let image = bundle.image(forResource: NSImage.Name(name))
    #elseif os(watchOS)
    let image = AssetImageTypeAlias(named: name)
    #endif
    guard let result = image else { fatalError("Unable to load image named \(name).") }
    return result
  }
}

internal extension AssetImageTypeAlias {
  @available(iOS 1.0, tvOS 1.0, watchOS 1.0, *)
  @available(OSX, deprecated,
    message: "This initializer is unsafe on macOS, please use the ImageAsset.image property")
  convenience init!(asset: ImageAsset) {
    #if os(iOS) || os(tvOS)
    let bundle = Bundle(for: BundleToken.self)
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(OSX)
    self.init(named: NSImage.Name(asset.name))
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

private final class BundleToken {}
