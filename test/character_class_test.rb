# frozen_string_literal: true

require "test_helper"

class CharacterClassTest < Minitest::Test
  def test_base_hp_uses_hit_die_and_constitution_modifier
    character_class = FantasyCharacterGenerator::CharacterClass.new(
      name: "Fighter",
      description: "A warrior.",
      hit_die: 10,
      starting_equipment_rules: ["Longsword"]
    )

    assert_equal(12, character_class.base_hp(2))
    assert_equal(1, character_class.base_hp(-20))
  end
end
