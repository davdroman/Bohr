Pod::Spec.new do |s|
  s.name                  = "Bohr"
  s.version               = "1.0.0"
  s.summary               = "Settings screen composing framework"
  s.homepage              = "https://github.com/Dromaguirre/Bohr"
  s.author                = { "David Roman" => "dromaguirre@gmail.com" }
  s.license               = { :type => 'MIT', :file => 'LICENSE' }

  s.platform              = :ios, '8.0'
  s.ios.deployment_target = '8.0'

  s.source                = { :git => "https://github.com/Dromaguirre/Bohr.git", :tag => s.version.to_s }
  s.source_files          = 'Bohr/*.{h,m}'
  s.frameworks            = 'Foundation', 'UIKit'
  s.requires_arc          = true
end
