# FantasyCharacterGenerator

`fantasy_character_generator` is a small educational Ruby gem that generates simple fantasy RPG characters.
It is designed to demonstrate class design, composition, YAML-backed data loading, and deterministic testing.

## Design goals

- Prefer composition over inheritance.
- Keep domain classes small and focused.
- Keep the generation flow in one readable service object.
- Keep game rules intentionally simplified for learning.

## Simplified architecture

The project is intentionally small:

- domain objects such as `Character`, `Race`, `CharacterClass`, and `Inventory`
- one `DataRepository` that loads YAML files into objects
- one `CharacterGenerator` that orchestrates the whole character creation flow
- one `Randomizer` that keeps randomness deterministic in tests

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

You can also inject a deterministic randomizer:

```ruby
randomizer = FantasyCharacterGenerator::Support::Randomizer.new(seed: 1234)
generator = FantasyCharacterGenerator::Generator::CharacterGenerator.new(randomizer: randomizer)

character = generator.generate(character_class_name: "Wizard")
puts character.summary
```

## Simplified rules

- Attributes are generated with `3d6`.
- Racial modifiers are applied after base attributes are rolled.
- Hit points are `class hit die + Constitution modifier`, with a minimum of 1.
- Equipment comes only from simple class-based rules.
- A generated hero only contains the essentials: name, race, class, attributes, HP, and inventory.

## Example script

Run:

```bash
ruby bin/generate_character
```

For a longer manual demo with multiple API examples:

```bash
ruby test.rb
```

## Testing

```bash
bundle exec ruby test/run_all_tests.rb
```
