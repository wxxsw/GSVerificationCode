Pod::Spec.new do |s|
    s.name         = 'GSVerificationCode'
    s.version      = '0.1.0'
    s.summary      = 'A simple style verification code view, in Swift.'
    s.homepage     = 'https://github.com/wxxsw/GSVerificationCode'
    
    s.license      = { :type => 'MIT', :file => 'LICENSE' }
    s.author       = { 'Gesen' => 'i@gesen.me' }
    s.source       = { :git => 'https://github.com/wxxsw/GSVerificationCode.git', :tag => '#{s.version}' }
    
    s.source_files = 'GSVerificationCode/Classes/**/*'
    
    s.ios.deployment_target = '9.0'
    s.swift_version = '4.2'
end
