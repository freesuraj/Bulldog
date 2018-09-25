Pod::Spec.new do |s|
  s.name = 'Bulldog'
  s.version = '1.0.0'
  s.license = { :type => 'MIT', :file => 'LICENSE' }
  s.summary = 'Bulldog is a super-fast json parser that will keep attacking until it gets the value you desire, or you give up. Just like a bulldog.'
  s.social_media_url = 'http://twitter.com/iosCook'
  s.homepage  = 'https://github.com/freesuraj/Bulldog'
  s.authors = { 'Suraj Pathak' => 'freesuraj@gmail.com' }
  s.source = { :git => 'https://github.com/freesuraj/Bulldog.git', :tag => s.version }
  s.ios.deployment_target = '9.0'
  s.source_files = 'Source/*swift'
end