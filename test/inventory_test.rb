# frozen_string_literal: true

require "test_helper"

class InventoryTest < Minitest::Test
  def test_returns_equipped_weapon_and_armor
    sword = FantasyCharacterGenerator::Weapon.new(
      name: "Sword",
      description: "Sharp",
      weight: 3,
      value: 10,
      damage: "1d8",
      damage_type: "slashing",
      range_type: "melee"
    )
    bow = FantasyCharacterGenerator::Weapon.new(
      name: "Bow",
      description: "Long range",
      weight: 2,
      value: 15,
      damage: "1d6",
      damage_type: "piercing",
      range_type: "ranged"
    )
    armor = FantasyCharacterGenerator::Armor.new(
      name: "Leather",
      description: "Armor",
      weight: 10,
      value: 10,
      armor_bonus: 1,
      armor_type: "light",
      dex_bonus_allowed: true
    )

    sword.equip!
    armor.equip!

    inventory = FantasyCharacterGenerator::Inventory.new(items: [sword, bow, armor])

    assert_same(sword, inventory.equipped_weapon)
    assert_same(armor, inventory.equipped_armor)
  end
end
