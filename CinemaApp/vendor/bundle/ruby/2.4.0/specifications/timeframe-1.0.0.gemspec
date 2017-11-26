# -*- encoding: utf-8 -*-
# stub: timeframe 1.0.0 ruby lib

Gem::Specification.new do |s|
  s.name = "timeframe".freeze
  s.version = "1.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Andy Rossmeissl".freeze, "Seamus Abshere".freeze, "Derek Kastner".freeze]
  s.date = "2017-06-22"
  s.description = "A Ruby class for describing and interacting with timeframes.".freeze
  s.email = ["andy@rossmeissl.net".freeze]
  s.homepage = "http://github.com/rossmeissl/timeframe".freeze
  s.rubyforge_project = "timeframe".freeze
  s.rubygems_version = "2.6.11".freeze
  s.summary = "Date intervals".freeze

  s.installed_by_version = "2.6.11" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activesupport>.freeze, [">= 2.3.5"])
      s.add_runtime_dependency(%q<i18n>.freeze, [">= 0"])
      s.add_development_dependency(%q<bundler>.freeze, [">= 0"])
      s.add_development_dependency(%q<rake>.freeze, [">= 0"])
      s.add_development_dependency(%q<rspec>.freeze, [">= 0"])
    else
      s.add_dependency(%q<activesupport>.freeze, [">= 2.3.5"])
      s.add_dependency(%q<i18n>.freeze, [">= 0"])
      s.add_dependency(%q<bundler>.freeze, [">= 0"])
      s.add_dependency(%q<rake>.freeze, [">= 0"])
      s.add_dependency(%q<rspec>.freeze, [">= 0"])
    end
  else
    s.add_dependency(%q<activesupport>.freeze, [">= 2.3.5"])
    s.add_dependency(%q<i18n>.freeze, [">= 0"])
    s.add_dependency(%q<bundler>.freeze, [">= 0"])
    s.add_dependency(%q<rake>.freeze, [">= 0"])
    s.add_dependency(%q<rspec>.freeze, [">= 0"])
  end
end
