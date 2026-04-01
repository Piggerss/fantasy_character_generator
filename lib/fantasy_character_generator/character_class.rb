# frozen_string_literal: true

module FantasyCharacterGenerator
  class CharacterClass
    attr_reader :name, :description, :hit_die, :starting_equipment_rules

    def initialize(name:, description:, hit_die:, starting_equipment_rules:)
      @name = name
      @description = description
      @hit_die = hit_die
      @starting_equipment_rules = starting_equipment_rules
    end

    def base_hp(constitution_modifier)
      [hit_die + constitution_modifier, 1].max
    end

    def to_h
      {
        name: name,
        description: description,
        hit_die: hit_die,
        starting_equipment_rules: starting_equipment_rules
      }
    end
  end
end