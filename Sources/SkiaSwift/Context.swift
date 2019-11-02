import CSkia

public class Context {
  var raw: OpaquePointer

  init(glInterface: GLInterface?) {
    self.raw = gr_context_make_gl(glInterface?.raw)!
  }

  convenience init(backend: Backend) {
    switch (backend) {
      case .metal:
        fatalError("Metal backend not supported")
      case .openGl:
        self.init(glInterface: nil)
      case .vulkan:
        fatalError("Vulkan backend not supported")
    }
  }

  deinit {
    unref()
  }

  func unref() {
    gr_context_unref(raw)
  }

  public func abandonContext(releaseResources: Bool = false) {
    if releaseResources {
      gr_context_release_resources_and_abandon_context(raw)
    } else {
      gr_context_abandon_context(raw)
    }
  }

  public func getResourceCacheLimits(maxResources: inout Int32, maxResourceBytes: inout Int) {
    gr_context_get_resource_cache_limits(raw, &maxResources, &maxResourceBytes)
  }

  public func setResourceCacheLimits(maxResources: Int32, maxResourceBytes: Int) {
    gr_context_set_resource_cache_limits(raw, maxResources, maxResourceBytes)
  }

  public func getResourceCacheUsage(maxResources: inout Int32, maxResourceBytes: inout Int) {
    gr_context_get_resource_cache_usage(raw, &maxResources, &maxResourceBytes)
  }

  public func GetMaxSurfaceSampleCount(colorType: ColorType) -> Int32 {
    return gr_context_get_max_surface_sample_count_for_color_type(raw, sk_colortype_t(colorType.rawValue))
  }

  public func flush() {
    gr_context_flush(raw)
  }

  public func resetContext(state: UInt32) {
    gr_context_reset_context(raw, state)
  }

  var backend: Backend {
    get {
      return gr_context_get_backend(raw).toSwift()
    }
  }
}