Pod::Spec.new do |s|

  s.name         = "ZIKTViper"
  s.version      = "1.0"
  s.summary      = "Thorough iOS VIPER implementation."
  s.description  = <<-DESC
                Thorough iOS VIPER implementation, consisting of view, presenter, interactor, wireframe, router, adapter.
                   DESC
  s.homepage         = "https://github.com/Zuikyo/ZIKRouter"
  s.license      = "MIT"
  s.author             = { "Zuikyo" => "zuilongzhizhu@gmail.com" }

  s.platform     = :ios, "7.0"
  s.ios.deployment_target = "7.0"

  s.source       = { :git => "https://github.com/Zuikyo/ZIKViper.git", :tag => "#{s.version}" }

  s.source_files  = "ZIKTViper/*.{h,m}"

  s.frameworks = "Foundation", "UIKit"
  s.requires_arc = true

end
