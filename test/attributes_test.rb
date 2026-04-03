# frozen_string_literal: true

require "test_helper"

class AttributesTest < Minitest::Test
  def test_modifier_for_calculates_attribute_modifiers
    attributes = FantasyCharacterGenerator::Attributes.new(
      strength: 8,
      dexterity: 10,
      constitution: 12,
      intelligence: 14,
      wisdom: 16,
      charisma: 18
    )

    assert_equal(-1, attributes.modifier_for(:strength))
    assert_equal(0, attributes.modifier_for(:dexterity))
    assert_equal(1, attributes.modifier_for(:constitution))
    assert_equal(2, attributes.modifier_for(:intelligence))
    assert_equal(3, attributes.modifier_for(:wisdom))
    assert_equal(4, attributes.modifier_for(:charisma))
  end

  def test_apply_modifiers_updates_scores_in_place
    attributes = FantasyCharacterGenerator::Attributes.new(
      strength: 10,
      dexterity: 10,
      constitution: 10,
      intelligence: 10,
      wisdom: 10,
      charisma: 10
    )

    result = attributes.apply_modifiers(strength: 2, wisdom: 1)

    assert_same(attributes, result)
    assert_equal(12, attributes.strength)
    assert_equal(11, attributes.wisdom)
    assert_equal(10, attributes.dexterity)
  end
end
