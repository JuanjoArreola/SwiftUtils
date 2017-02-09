Pod::Spec.new do |s|

  s.name         = "SwiftUtils"
  s.version      = "1.0.0"
  s.summary      = "A collection of utilities for iOS projects"

  s.homepage     = "https://github.com/JuanjoArreola/SwiftUtils"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "Juanjo Arreola" => "juanjo.arreola@gmail.com" }
  
  s.ios.deployment_target = "9.0"

  s.source       = { :git => "git@github.com:JuanjoArreola/SwiftUtils.git", :tag => "version_#{s.version}" }
  s.source_files  = "Sources/**/*.swift"

  # s.public_header_files = "Classes/**/*.h"

  s.frameworks = "UIKit", "CoreData", "CoreLocation"
  s.requires_arc = true

end
