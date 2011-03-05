# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name        = "whiny_hash"
  s.version     = "0.0.2"
  s.platform    = Gem::Platform::RUBY
  s.summary     = "A Hash that complains a lot -- used to simplify optional parameters"
  s.email       = "info@provideal.net"
  s.homepage    = "http://github.com/provideal/whiny_hash"
  s.description = "A Hash that complains a lot -- used to simplify optional parameters. WhinyHash instances raise errors if unset keys are accessed either directly or by merge."
  s.authors     = ['Peter Horn']

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
