#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint privacy_screen.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'privacy_screen'
  s.version          = '0.0.10'
  s.summary          = 'Protects sensitive app content in the app switcher and background.'
  s.description      = <<-DESC
A Flutter plugin for privacy screens, screenshot protection, and native lifecycle lock triggers.
                       DESC
  s.homepage         = 'https://github.com/useswype/privacy_screen'
  s.license          = { :file => '../LICENSE' }
  s.author           = 'Swypex'
  s.source           = { :path => '.' }
  s.source_files = 'privacy_screen/Sources/privacy_screen/**/*.swift'
  s.dependency 'Flutter'
  s.platform = :ios, '12.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end
