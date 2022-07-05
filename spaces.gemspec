# frozen_string_literal: true

Kernel.load "./lib/spaces/version.rb"

Gem::Specification.new do |s|
  s.name = "spaces"
  s.version = Engines::Spaces::VERSION
  s.date = Time.now.strftime("%Y-%m-%d")
  s.summary = "Engines Spaces"
  s.email = "info@engines.org"
  s.homepage = "http://github.com/engines/spaces"
  s.description = "Define Engines blueprints, export/import them, and manage the generation of artifacts required to generate images and provision virual machines and components."
  s.required_ruby_version = ">= 3.1"

  s.author = "Engines"
  s.licenses = ["AGPL-3.0"]

  s.metadata = {
    "bug_tracker_uri"   => "#{s.homepage}/issues",
    "changelog_uri"     => "#{s.homepage}/blob/master/CHANGELOG.md",
    "homepage_uri"      => s.homepage,
    "source_code_uri"   => s.homepage
  }

  s.add_runtime_dependency "yajl-ruby",       "~> 1.4"
  s.add_runtime_dependency "git",             "~> 1.8"
  s.add_runtime_dependency "duplicate",       "~> 1.1"
  s.add_runtime_dependency "i18n",            "~> 1.8"
  s.add_runtime_dependency "ruby-terraform",  "=  0.64"
  s.add_runtime_dependency "packer-client",   "=  0.2.0"
  s.add_runtime_dependency "docker-api",      "~> 2.1"
  s.add_runtime_dependency "addressable",     "~> 2.8"

  s.add_runtime_dependency "engines-logger",  "0.2.0"

  s.files = `git ls-files -z src`.split(/\0/)
end
