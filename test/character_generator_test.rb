# frozen_string_literal: true

require "test_helper"

class CharacterGeneratorTest < Minitest::Test
  def test_generates_a_valid_character_object
    generator = FantasyCharacterGenerator::Generator::CharacterGenerator.new(
      randomizer: FantasyCharacterGenerator::Support::Randomizer.new(seed: 123)
    )

    character = generator.generate

    assert_instance_of(FantasyCharacterGenerator::Character, character)
    assert_instance_of(String, character.name)
    assert_instance_of(FantasyCharacterGenerator::Race, character.race)
    assert_instance_of(FantasyCharacterGenerator::CharacterClass, character.character_class)
    assert_instance_of(FantasyCharacterGenerator::Attributes, character.attributes)
    assert_instance_of(FantasyCharacterGenerator::Inventory, character.inventory)
    assert_instance_of(Integer, character.max_hp)
    assert_instance_of(Integer, character.current_hp)
    assert(character.equipped_weapon)
  end

  def test_supports_deterministic_generation_with_seeded_randomizer
    first_generator = FantasyCharacterGenerator::Generator::CharacterGenerator.new(
      randomizer: FantasyCharacterGenerator::Support::Randomizer.new(seed: 77)
    )
    second_generator = FantasyCharacterGenerator::Generator::CharacterGenerator.new(
      randomizer: FantasyCharacterGenerator::Support::Randomizer.new(seed: 77)
    )

    first_character = first_generator.generate
    second_character = second_generator.generate

    assert_equal(first_character.to_h, second_character.to_h)
  end
end
