Pod::Spec.new do |s|
  s.name         = "Pokepay"
  s.version      = "0.1.12"
  s.summary      = "Pokepay iOS SDK."
  s.description  = <<-DESC
iOS SDK for Pokepay written in Swift.
                   DESC

  s.homepage     = "https://pay.pocket-change.jp"
  s.license      = { :type => "MIT", :file => "LICENSE.txt" }
  s.author             = { "Eitaro Fukamachi" => "eitaro.fukamachi@pocket-change.jp" }
  s.platform     = :ios, "8.4"
  s.source       = { :git => "https://github.com/pokepay/ios-sdk.git", :tag => "#{s.version}" }
  s.source_files  = "Sources/**/*.swift"
  s.swift_version = "4.0"
  s.dependency "APIKit", "~> 4.0.0"
end
