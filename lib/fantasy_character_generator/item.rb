# frozen_string_literal: true

module FantasyCharacterGenerator
  class Item
    attr_reader :name, :description, :weight, :value

    def initialize(name:, description:, weight:, value:, equipped: false)
      @name = name
      @description = description
      @weight = weight
      @value = value
      @equipped = equipped
    end

    def equip!
      @equipped = true
    end

    def unequip!
      @equipped = false
    end

    def equipped?
      @equipped
    end

    def to_h
      {
        name: name,
        description: description,
        weight: weight,
        value: value,
        equipped: equipped?
      }
    end
  end
end
