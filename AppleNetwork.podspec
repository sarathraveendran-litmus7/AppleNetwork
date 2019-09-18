#
# Be sure to run `pod lib lint AppleNetwork.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'AppleNetwork'
  s.version          = '1.0.3'
  s.summary          = 'Revealed Parser to public'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
Heavily customizable netwok manager to handle api calls. Currently it handle GET requests only.
                       DESC

  s.homepage         = 'https://github.com/sarathraveendran-litmus7/AppleNetwork'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'SR' => 'Sarath Raveendran' }
  s.source           = { :git => 'https://github.com/sarathraveendran-litmus7/AppleNetwork.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '11.0'
  s.source_files = 'AppleNetwork/Classes/**/*'
  s.swift_version = '5.0'

  
  # s.resource_bundles = {
  #   'AppleNetwork' => ['AppleNetwork/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
