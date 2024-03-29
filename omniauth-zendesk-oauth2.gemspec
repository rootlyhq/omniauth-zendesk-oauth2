require File.expand_path('../lib/omniauth-zendesk-oauth2/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors = ["Jonas Oberschweiber"]
  gem.email = "jonas.oberschweiber@d-velop.de"
  gem.description = %q{OmniAuth Strategy for Zendesk via OAuth2}
  gem.summary = %q{OmniAuth Strategy for Zendesk via OAuth2}
  gem.homepage = "https://github.com/jonasoberschweiber/omniauth-zendesk-oauth2"

  gem.name = "omniauth-zendesk-oauth2"
  gem.files = `git ls-files`.split("\n")
  gem.require_paths = ["lib"]
  gem.version = OmniAuth::Zendesk::VERSION
  gem.license = 'MIT'

  gem.required_ruby_version = ">= 3"

  gem.add_dependency 'omniauth', '~> 2'
  gem.add_dependency 'omniauth-oauth2', '>= 1.4.0', '< 2.0'

  gem.add_development_dependency 'rspec', '~> 3.5'
  gem.add_development_dependency 'rack-test'
  gem.add_development_dependency 'simplecov'
  gem.add_development_dependency 'webmock'
end
