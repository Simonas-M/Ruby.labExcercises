# -*- encoding: utf-8 -*-
# stub: time_span 0.1.7 ruby lib

Gem::Specification.new do |s|
  s.name = "time_span".freeze
  s.version = "0.1.7"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Craig A. Cook".freeze]
  s.date = "2012-06-15"
  s.description = "Time spans, including many comparators. Abstract time ONLY.".freeze
  s.email = ["craig.a.cook@gmail.com".freeze]
  s.homepage = "https://github.com/coyote/time_span".freeze
  s.licenses = ["MIT".freeze]
  s.rubyforge_project = "time_span".freeze
  s.rubygems_version = "2.6.11".freeze
  s.summary = "Time Span".freeze

  s.installed_by_version = "2.6.11" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rspec>.freeze, [">= 0"])
      s.add_development_dependency(%q<rubygems-test>.freeze, [">= 0"])
    else
      s.add_dependency(%q<rspec>.freeze, [">= 0"])
      s.add_dependency(%q<rubygems-test>.freeze, [">= 0"])
    end
  else
    s.add_dependency(%q<rspec>.freeze, [">= 0"])
    s.add_dependency(%q<rubygems-test>.freeze, [">= 0"])
  end
end
