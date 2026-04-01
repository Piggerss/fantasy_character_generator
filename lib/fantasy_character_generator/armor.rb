# frozen_string_literal: true

module FantasyCharacterGenerator
  class Armor < Item
    attr_reader :armor_bonus, :armor_type, :dex_bonus_allowed

    def initialize(name:, description:, weight:, value:, armor_bonus:, armor_type:, dex_bonus_allowed:, equipped: false)
      super(name: name, description: description, weight: weight, value: value, equipped: equipped)
      @armor_bonus = armor_bonus
      @armor_type = armor_type
      @dex_bonus_allowed = dex_bonus_allowed
    end

    def light?
      armor_type == "light"
    end

    def heavy?
      armor_type == "heavy"
    end

    def shield?
      armor_type == "shield"
    end

    def to_h
      super.merge(
        armor_bonus: armor_bonus,
        armor_type: armor_type,
        dex_bonus_allowed: dex_bonus_allowed
      )
    end
  end
end
