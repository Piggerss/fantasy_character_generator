# frozen_string_literal: true

require "test_helper"

class TestFantasyCharacterGenerator < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::FantasyCharacterGenerator::VERSION
  end

  def test_generator_is_available_from_main_require
    generator = FantasyCharacterGenerator::Generator::CharacterGenerator.new(
      randomizer: FantasyCharacterGenerator::Support::Randomizer.new(seed: 123)
    )

    assert_instance_of(FantasyCharacterGenerator::Character, generator.generate)
  end
end