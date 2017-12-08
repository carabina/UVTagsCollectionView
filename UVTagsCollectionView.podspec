Pod::Spec.new do |s|
  s.name                  = "UVTagsCollectionView"
  s.version               = "1.0.0"
  s.summary               = "Tags collectionView that let customize colors and size."
  s.homepage              = "https://github.com/basiliusic/UVTagsCollectionView"
  s.license               = { :type => 'LGPL', :file => 'LICENSE' }
  s.author                = { "Basilic" => "basiliusic@gmail.com" }
  s.ios.deployment_target = '8.0'
  s.source                = { :git => "https://github.com/basiliusic/UVTagsCollectionView.git", :tag => s.version.to_s }
  s.source_files          = 'Classes/**/*.{h,m, xib}'
  s.public_header_files   = 'Classes/**/*.h'
  s.ios.frameworks            = 'UIKit', 'Foundation'
  s.requires_arc          = true
end