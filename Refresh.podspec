#
# Be sure to run `pod lib lint Refresh.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'Refresh'
  s.version          = '0.0.1'
  s.summary          = 'An extension for RxSwift and MJRefresh.'
  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC
  s.swift_version = '5'
  s.homepage         = 'https://github.com/chouheiwa/Refresh'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'chouheiwa' => '849131492@qq.com' }
  s.source           = { :git => 'https://github.com/chouheiwa/Refresh.git', :tag => s.version.to_s }
  s.ios.deployment_target = '9.0'

  s.source_files = 'Refresh/Classes/**/*'
  
  # s.resource_bundles = {
  #   'Refresh' => ['Refresh/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'RxSwift'
  s.dependency 'RxCocoa'
  s.dependency 'MJRefresh'
end
