# -*- encoding: utf-8 -*-
require File.expand_path('../lib/exceptions_to_hipchat/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Darrin Holst"]
  gem.email         = ["darrinholst@gmail.com"]
  gem.summary       = %q{Send rails exceptions to HipChat}
  gem.homepage      = "http://github.com/darrinholst/exceptions_to_hipchat"

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "exceptions_to_hipchat"
  gem.require_paths = ["lib"]
  gem.version       = ExceptionsToHipchat::VERSION

  gem.add_dependency("hipchat", "~> 0.4.1")
end
