Pod::Spec.new do |s|
  s.name = 'Metrollo'
  s.version = '0.3.0'
  s.license = 'MIT'
  s.summary = 'Wrapper that combines Alamofire and Google Promises.'
  s.homepage = 'https://github.com/kimdv/Metrollo'
  s.social_media_url = 'https://twitter.com/kimdv'
  s.authors = { 'Kim de Vos' => 'kimdevos12@hotmail.com' }
  s.source = { :git => 'https://github.com/kimdv/Metrollo.git', :tag => "#{s.version}" }

  s.ios.deployment_target = '10.0'
  s.swift_version = '4.2'

  s.source_files = 'Metrollo/*.swift'
  
  s.dependency 'Alamofire', '~> 5.0.0-beta.4'
  s.dependency 'PromisesSwift', '~> 1.2'
end