# frozen_string_literal: true

module FantasyCharacterGenerator
  class Attributes
    ATTRIBUTE_NAMES = %i[strength dexterity constitution intelligence wisdom charisma].freeze

    attr_reader(*ATTRIBUTE_NAMES)

    def initialize(strength:, dexterity:, constitution:, intelligence:, wisdom:, charisma:)
      @strength = strength
      @dexterity = dexterity
      @constitution = constitution
      @intelligence = intelligence
      @wisdom = wisdom
      @charisma = charisma
    end

    def modifier_for(attribute_name)
      score = public_send(attribute_name.to_sym)
      ((score - 10) / 2.0).floor
    end

    def apply_modifiers(modifiers_hash)
      modifiers_hash.each do |attribute_name, bonus|
        current_value = public_send(attribute_name.to_sym)
        instance_variable_set(:"@#{attribute_name}", current_value + bonus)
      end

      self
    end

    def to_h
      ATTRIBUTE_NAMES.each_with_object({}) do |attribute_name, result|
        result[attribute_name] = public_send(attribute_name)
      end
    end
  end
end