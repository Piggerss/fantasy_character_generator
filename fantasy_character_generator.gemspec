# frozen_string_literal: true

require_relative "lib/fantasy_character_generator/version"

Gem::Specification.new do |spec|
  spec.name = "fantasy_character_generator"
  spec.version = FantasyCharacterGenerator::VERSION
  spec.authors = ["Maxim Nadtochiy, Artem Kostenko, Artem Kandalov"]
  spec.email = ["maksimn219@gmail.com"]

  spec.summary = "A small educational gem for generating fantasy RPG characters."
  spec.description = "Generates simple fantasy characters using clear Ruby classes, composition, and YAML-backed data."
  spec.homepage = "https://github.com/Piggerss/fantasy_character_generator"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.2.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage

  spec.files = Dir.glob("lib/**/*.{rb,yml}") + Dir.glob("bin/*") + Dir.glob("examples/**/*.rb") + ["README.md", "LICENSE.txt"]
  spec.bindir = "bin"
  spec.executables = ["generate_character"]
  spec.require_paths = ["lib"]

  spec.add_development_dependency "minitest", "~> 5.25"
end