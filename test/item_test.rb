# frozen_string_literal: true

require "test_helper"

class ItemTest < Minitest::Test
  def test_item_can_be_equipped_and_unequipped
    item = FantasyCharacterGenerator::Item.new(
      name: "Torch",
      description: "Simple light",
      weight: 1,
      value: 1
    )

    refute(item.equipped?)

    item.equip!
    assert(item.equipped?)

    item.unequip!
    refute(item.equipped?)
  end
end
