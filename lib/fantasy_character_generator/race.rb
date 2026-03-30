# frozen_string_literal: true

module FantasyCharacterGenerator
  class Race
    attr_reader :name, :description, :attribute_modifiers

    def initialize(name:, description:, attribute_modifiers:)
      @name = name
      @description = description
      @attribute_modifiers = symbolize_keys(attribute_modifiers)
    end

    def modifier_for(attribute_name)
      attribute_modifiers.fetch(attribute_name.to_sym, 0)
    end

    def to_h
      {
        name: name,
        description: description,
        attribute_modifiers: attribute_modifiers
      }
    end

    private

    def symbolize_keys(hash)
      hash.each_with_object({}) { |(key, value), result| result[key.to_sym] = value }
    end
  end
end