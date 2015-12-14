Pod::Spec.new do |s|
  s.name             = "GDXNet"
  s.version          = "1.1.4"
  s.summary          = "Well-organized Objective-C network interaction library."
  s.homepage         = "https://github.com/GDXRepo/GDXNet"
  s.license          = { :type => "Apache", :file => "LICENSE" }
  s.author           = { "Georgiy Malyukov" => "" }
  s.source           = { :git => "https://github.com/GDXRepo/GDXNet.git", :tag => s.version.to_s }
  s.social_media_url = 'http://deadlineru.livejournal.com'

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'test' => ['Pod/Assets/*.png']
  }
  s.dependency 'AFNetworking'
end