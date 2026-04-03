# frozen_string_literal: true

require "test_helper"

class CharacterTest < Minitest::Test
  def test_summary_returns_readable_string
    repository = FantasyCharacterGenerator::DataRepository.new
    race = repository.find_race("Human")
    character_class = repository.find_character_class("Fighter")
    attributes = FantasyCharacterGenerator::Attributes.new(
      strength: 12,
      dexterity: 10,
      constitution: 14,
      intelligence: 8,
      wisdom: 11,
      charisma: 9
    )
    weapon = FantasyCharacterGenerator::Weapon.new(
      name: "Longsword",
      description: "Sword",
      weight: 3,
      value: 15,
      damage: "1d8",
      damage_type: "slashing",
      range_type: "melee",
      equipped: true
    )
    armor = FantasyCharacterGenerator::Armor.new(
      name: "Leather Armor",
      description: "Armor",
      weight: 10,
      value: 10,
      armor_bonus: 1,
      armor_type: "light",
      dex_bonus_allowed: true,
      equipped: true
    )
    inventory = FantasyCharacterGenerator::Inventory.new(items: [weapon, armor])

    character = FantasyCharacterGenerator::Character.new(
      name: "Aric Stone",
      race: race,
      character_class: character_class,
      attributes: attributes,
      inventory: inventory,
      max_hp: 12,
      current_hp: 12,
      level: 1
    )

    assert_includes(character.summary, "Aric Stone")
    assert_includes(character.summary, "Human")
    assert_includes(character.summary, "Fighter")
    assert_includes(character.summary, "Longsword")
  end

  def test_damage_and_heal_work_with_minimal_character_data
    character = FantasyCharacterGenerator::Character.new(
      name: "Mira Stone",
      race: FantasyCharacterGenerator::DataRepository.new.find_race("Human"),
      character_class: FantasyCharacterGenerator::DataRepository.new.find_character_class("Wizard"),
      attributes: FantasyCharacterGenerator::Attributes.new(
        strength: 10,
        dexterity: 10,
        constitution: 10,
        intelligence: 12,
        wisdom: 11,
        charisma: 10
      ),
      inventory: FantasyCharacterGenerator::Inventory.new,
      max_hp: 8,
      current_hp: 8,
      level: 1
    )

    character.damage(3)
    assert_equal(5, character.current_hp)
    assert(character.alive?)

    character.heal(2)
    assert_equal(7, character.current_hp)

    character.damage(20)
    refute(character.alive?)

    character.full_heal!
    assert_equal(8, character.current_hp)
  end
end
