Pod::Spec.new do |spec|
  spec.name         = "PNPForm"
  spec.version      = "0.0.3"
  spec.summary      = "A swift library that provides a form view without have to conform any ViewController."
  spec.homepage     = "https://github.com/LabLamb/PNPForm"
  spec.screenshots  = "https://github.com/LabLamb/PNPForm/blob/develop/.github/images/example.gif"
  spec.license      = "MIT"
  spec.author       = { "LabLamb" => "lablambworks@gmail.com" }
  spec.platform     = :ios
  spec.platform     = :ios, "9.0"
  spec.source       = { :git => "https://github.com/LabLamb/PNPForm.git", :tag => "#{spec.version}" }
  spec.source_files  = "Classes", "Classes/**/*.{h,m}", "PNPForm/**/*.swift"
  spec.exclude_files = "Classes/Exclude"
  spec.public_header_files = "Classes/**/*.h"
end
