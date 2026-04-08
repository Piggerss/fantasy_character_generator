# frozen_string_literal: true

module FantasyCharacterGenerator
  class DataRepository
    def initialize(data_path: File.expand_path("data", __dir__))
      @data_path = data_path
    end

    def races
      @races ||= load_yaml("races.yml").map do |row|
        Race.new(
          name: row.fetch("name"),
          description: row.fetch("description"),
          attribute_modifiers: row.fetch("attribute_modifiers")
        )
      end
    end

    def character_classes
      @character_classes ||= load_yaml("classes.yml").map do |row|
        CharacterClass.new(
          name: row.fetch("name"),
          description: row.fetch("description"),
          hit_die: row.fetch("hit_die"),
          starting_equipment_rules: row.fetch("starting_equipment_rules")
        )
      end
    end

    def equipment_items
      @equipment_items ||= load_yaml("equipment.yml").values.flatten.map do |row|
        build_item(row)
      end
    end

    def names
      @names ||= load_yaml("names.yml")
    end

    def find_race(name)
      find_by_name(races, name)
    end

    def find_character_class(name)
      find_by_name(character_classes, name)
    end

    def find_item(name)
      find_by_name(equipment_items, name)
    end

    def names_for(race_name)
      names.fetch(race_name)
    end

    private

    def load_yaml(file_name)
      YAML.load_file(File.join(@data_path, file_name))
    end

    def find_by_name(collection, name)
      collection.find { |entry| entry.name == name }
    end

    def build_item(row)
      case row.fetch("type")
      when "weapon"
        Weapon.new(
          name: row.fetch("name"),
          description: row.fetch("description"),
          weight: row.fetch("weight"),
          value: row.fetch("value"),
          damage: row.fetch("damage"),
          damage_type: row.fetch("damage_type"),
          range_type: row.fetch("range_type"),
          properties: row.fetch("properties", [])
        )
      when "armor"
        Armor.new(
          name: row.fetch("name"),
          description: row.fetch("description"),
          weight: row.fetch("weight"),
          value: row.fetch("value"),
          armor_bonus: row.fetch("armor_bonus"),
          armor_type: row.fetch("armor_type"),
          dex_bonus_allowed: row.fetch("dex_bonus_allowed")
        )
      else
        Item.new(
          name: row.fetch("name"),
          description: row.fetch("description"),
          weight: row.fetch("weight"),
          value: row.fetch("value")
        )
      end
    end
  end
end
