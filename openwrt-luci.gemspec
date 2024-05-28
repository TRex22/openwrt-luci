lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "openwrt-luci/version"

Gem::Specification.new do |spec|
  spec.name          = "openwrt-luci"
  spec.version       = OpenwrtLuci::VERSION
  spec.authors       = ["trex22"]
  spec.email         = ["contact@jasonchalom.com"]

  spec.summary       = "API Client to communicate with OpenWRT via the Luci interface"
  spec.description   = "API Client to communicate with OpenWRT via the Luci interface. This is an unofficial project."
  spec.homepage      = "https://github.com/TRex22/openwrt-luci"
  spec.license       = "MIT"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end

  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "httparty", "~> 0.22.0"
  spec.add_dependency "active_attr", "~> 0.16.0"
  spec.add_dependency "nokogiri", "~> 1.16.5"
  spec.add_dependency "oj", "~> 3.16.3"

  # Development dependancies
  spec.add_development_dependency "pry", "~> 0.14.2"
  # TODO:
end
