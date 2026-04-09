# frozen_string_literal: true

require "test_helper"

class InheritanceTest < Minitest::Test
  def test_weapon_and_armor_inherit_from_item
    assert(FantasyCharacterGenerator::Weapon < FantasyCharacterGenerator::Item)
    assert(FantasyCharacterGenerator::Armor < FantasyCharacterGenerator::Item)
  end
end
