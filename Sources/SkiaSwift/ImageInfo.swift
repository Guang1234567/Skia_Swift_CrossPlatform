import CSkia

public struct PlatformColorShift {
  let a: Int32
  let r: Int32
  let g: Int32
  let b: Int32

  init() {
    var a: Int32 = 0
    var r: Int32 = 0
    var g: Int32 = 0
    var b: Int32 = 0
    sk_color_get_bit_shift(&a, &r, &g, &b)
    self.a = a
    self.r = r
    self.g = g
    self.b = b
  }
}

public typealias ImageInfo = sk_imageinfo_t

public extension ImageInfo {
  static let platformColorType = ColorType(rawValue: sk_colortype_get_default_8888().rawValue)
  static let platformColorShift = PlatformColorShift()

  init(_ width: Int32, _ height: Int32, _ colorType: ColorType, _ alphaType: AlphaType) {
    self.init()
    self.width = width
    self.height = height
    self.colorType = colorType.toC()
    self.alphaType = alphaType.toC()
  }
}
