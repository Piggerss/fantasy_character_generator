# frozen_string_literal: true

module FantasyCharacterGenerator
  class Inventory
    attr_reader :items

    def initialize(items: [])
      @items = items
    end

    def add(item)
      items << item
      item
    end

    def remove(item)
      items.delete(item)
    end

    def weapons
      items.select { |item| item.is_a?(Weapon) }
    end

    def armors
      items.select { |item| item.is_a?(Armor) }
    end

    def equipped_items
      items.select(&:equipped?)
    end

    def equipped_weapon
      weapons.find(&:equipped?)
    end

    def equipped_armor
      armors.find { |item| item.equipped? && !item.shield? } || armors.find(&:equipped?)
    end

    def find_by_name(name)
      items.find { |item| item.name == name }
    end

    def to_h
      {
        items: items.map(&:to_h)
      }
    end
  end
end
