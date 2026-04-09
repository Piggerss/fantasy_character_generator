# FantasyCharacterGenerator

`fantasy_character_generator` is a small educational Ruby gem that generates simple fantasy RPG characters.
It demonstrates plain Ruby classes, composition, YAML-backed data loading, and deterministic tests.

## Design Goals

- Prefer composition over inheritance.
- Keep domain classes small and readable.
- Keep generation rules simple and explicit.
- Use one `Randomizer` object so tests can be deterministic.

## Current Features

- Generates a character name, race, class, attributes, HP, and inventory.
- Loads races, classes, names, and equipment from YAML files.
- Supports deterministic generation with a seeded randomizer.
- Keeps item inheritance intentionally small: `Weapon < Item` and `Armor < Item`.

## Installation

```bash
bundle install
```

## Usage

```ruby
require "fantasy_character_generator"

generator = FantasyCharacterGenerator::Generator::CharacterGenerator.new
character = generator.generate

puts character.summary
puts character.to_h
```

Generate with a fixed race or class:

```ruby
character = generator.generate(race_name: "Elf", character_class_name: "Wizard")
puts character.summary
```

Use deterministic randomness:

```ruby
randomizer = FantasyCharacterGenerator::Support::Randomizer.new(seed: 1234)
generator = FantasyCharacterGenerator::Generator::CharacterGenerator.new(randomizer: randomizer)

puts generator.generate.summary
```

## Simplified Rules

- Attributes are generated with `3d6`.
- Racial modifiers are applied after base attributes are rolled.
- Hit points are `class hit die + Constitution modifier`, with a minimum of 1.
- Equipment comes from simple class-based starting equipment rules.

## Examples

Generate and print one character:

```bash
ruby bin/generate_character
```

Run a longer manual demo with multiple API examples:

```bash
ruby examples/demo.rb
```

## Testing

```bash
bundle exec ruby test/run_all_tests.rb
```

You can also run:

```bash
bundle exec rake test
```