# frozen_string_literal: true

module FantasyCharacterGenerator
  class Character
    attr_reader :name, :race, :character_class, :attributes,
                :inventory, :level, :max_hp, :current_hp

    def initialize(name:, race:, character_class:, attributes:, inventory:, max_hp:, current_hp:, level: 1)
      @name = name
      @race = race
      @character_class = character_class
      @attributes = attributes
      @inventory = inventory
      @max_hp = max_hp
      @current_hp = current_hp
      @level = level
    end

    def alive?
      current_hp.positive?
    end

    def damage(amount)
      @current_hp = [current_hp - amount, 0].max
    end

    def heal(amount)
      @current_hp = [current_hp + amount, max_hp].min
    end

    def full_heal!
      @current_hp = max_hp
    end

    def equipped_weapon
      inventory.equipped_weapon
    end

    def summary
      [
        "#{name} is a level #{level} #{race.name} #{character_class.name}.",
        "HP: #{current_hp}/#{max_hp}.",
        "Weapon: #{equipped_weapon&.name || 'None'}."
      ].join(" ")
    end

    def to_h
      {
        name: name,
        race: race.to_h,
        character_class: character_class.to_h,
        attributes: attributes.to_h,
        inventory: inventory.to_h,
        max_hp: max_hp,
        current_hp: current_hp,
        level: level
      }
    end
  end
end
