# frozen_string_literal: true

module FantasyCharacterGenerator
  class Weapon < Item
    attr_reader :damage, :damage_type, :range_type, :properties

    def initialize(name:, description:, weight:, value:, damage:, damage_type:, range_type:, properties: [], equipped: false)
      super(name: name, description: description, weight: weight, value: value, equipped: equipped)
      @damage = damage
      @damage_type = damage_type
      @range_type = range_type
      @properties = properties
    end

    def melee?
      range_type == "melee"
    end

    def ranged?
      range_type == "ranged"
    end

    def to_h
      super.merge(
        damage: damage,
        damage_type: damage_type,
        range_type: range_type,
        properties: properties
      )
    end
  end
end
