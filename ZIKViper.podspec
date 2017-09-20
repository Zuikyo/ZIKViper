Pod::Spec.new do |s|

  s.name         = "ZIKViper"
  s.version      = "1.1"
  s.summary      = "iOS VIPER implementation, relying on ZIKRouter."
  s.description  = <<-DESC
                iOS VIPER implementation, relying on ZIKRouter. Designed for discovering modules and dependency injection with protocol.
                   DESC
  s.homepage         = "https://github.com/Zuikyo/ZIKRouter"
  s.license      = "MIT"
  s.author             = { "Zuikyo" => "zuilongzhizhu@gmail.com" }

  s.platform     = :ios, "7.0"
  s.ios.deployment_target = "7.0"

  s.source       = { :git => "https://github.com/Zuikyo/ZIKViper.git", :tag => "#{s.version}" }

  s.source_files  = "ZIKViper/*.{h,m}"

  s.frameworks = "Foundation", "UIKit"
  s.requires_arc = true

  s.dependency "ZIKRouter", '>= 0.6'

end
