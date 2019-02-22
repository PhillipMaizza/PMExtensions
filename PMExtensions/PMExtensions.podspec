Pod::Spec.new do |spec|
  spec.name         = "PMExtensions"
  spec.version      = "0.0.1"
  spec.summary      = "A collection of extension to make your life easier."
  spec.description  = "A collection of all the extension I've used over the years to make my life easier. It contains all kinds of extensions and it's always up to date."
  spec.homepage     = "https://github.com/PhillipMaizza/PMExtensions"
  spec.license      = "MIT"
  spec.author       = "Phillip Maizza"
  spec.platform     = :ios, "9.0"
  spec.source       = { :git => "https://github.com/PhillipMaizza/PMExtensions.git", :tag => "#{spec.version}" }
  spec.source_files  = "PMUtils/**/*.{h,m,swift}"
  spec.requires_arc = true
  # spec.dependency "JSONKit", "~> 1.4"
end
