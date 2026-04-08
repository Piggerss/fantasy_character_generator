# frozen_string_literal: true

require "test_helper"

class DataRepositoryTest < Minitest::Test
  def setup
    @repository = FantasyCharacterGenerator::DataRepository.new
  end

  def test_loads_race_objects
    races = @repository.races

    refute_empty(races)
    assert_instance_of(FantasyCharacterGenerator::Race, races.first)
    assert_instance_of(Hash, races.first.attribute_modifiers)
  end

  def test_loads_character_class_objects
    character_class = @repository.character_classes.first

    assert_instance_of(FantasyCharacterGenerator::CharacterClass, character_class)
    assert_instance_of(Array, character_class.starting_equipment_rules)
  end

  def test_loads_equipment_items
    all_items = @repository.equipment_items

    assert(all_items.any? { |item| item.is_a?(FantasyCharacterGenerator::Weapon) })
    assert(all_items.any? { |item| item.is_a?(FantasyCharacterGenerator::Armor) })
  end

  def test_loads_name_data_for_a_race
    names = @repository.names_for("Human")

    assert_instance_of(Array, names["first_names"])
  end
end
