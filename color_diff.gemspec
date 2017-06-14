# -*- encoding: utf-8 -*-
$:.push File.expand_path('../lib', __FILE__)

require 'color_diff/version'

Gem::Specification.new do |s|
  s.name = 'color_diff'
  s.version = ColorDiff::VERSION
  s.platform = Gem::Platform::RUBY
  s.author = ['Daniel Hanson']
  s.email = 'hansondr@gmail.com'
  s.homepage = 'https://github.com/hansondr/color_diff'
  s.summary = 'Calculate rgb color distances using CIEDE2000 formula'
  s.description = 'Calculate RGB color distances using CIEDE2000 formula'

  s.license = 'MIT'

  s.files = Dir.glob('{lib}/**/*') + %w{LICENSE README.md}
  s.test_files = `git ls-files -- {spec}/*`.split("\n")
  s.require_paths = ['lib']

  s.add_development_dependency 'rspec', '~> 3.0'
end
