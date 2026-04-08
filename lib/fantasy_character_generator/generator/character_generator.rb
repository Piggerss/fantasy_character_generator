# frozen_string_literal: true

module FantasyCharacterGenerator
  module Generator
    class CharacterGenerator
      def initialize(randomizer: Support::Randomizer.new, repository: DataRepository.new)
        @randomizer = randomizer
        @repository = repository
      end

      def generate(race_name: nil, character_class_name: nil)
        race = pick_race(race_name)
        character_class = pick_class(character_class_name)
        attributes = generate_attributes

        attributes.apply_modifiers(race.attribute_modifiers)

        inventory = build_inventory(character_class)
        max_hp = character_class.base_hp(attributes.modifier_for(:constitution))

        Character.new(
          name: generate_name(race),
          race: race,
          character_class: character_class,
          attributes: attributes,
          inventory: inventory,
          max_hp: max_hp,
          current_hp: max_hp,
          level: 1
        )
      end

      private

      def pick_race(race_name)
        race_name ? @repository.find_race(race_name) : @randomizer.sample(@repository.races)
      end

      def pick_class(class_name)
        class_name ? @repository.find_character_class(class_name) : @randomizer.sample(@repository.character_classes)
      end

      def generate_attributes
        Attributes.new(
          strength: roll_score,
          dexterity: roll_score,
          constitution: roll_score,
          intelligence: roll_score,
          wisdom: roll_score,
          charisma: roll_score
        )
      end

      def generate_name(race)
        race_names = @repository.names_for(race.name)
        first_name = @randomizer.sample(race_names.fetch("first_names"))
        last_names = race_names.fetch("last_names", [])
        return first_name if last_names.empty?

        "#{first_name} #{@randomizer.sample(last_names)}"
      end

      def build_inventory(character_class)
        inventory = Inventory.new

        character_class.starting_equipment_rules.each do |rule|
          add_item_to_inventory(inventory, pick_item_name(rule))
        end

        inventory
      end

      def add_item_to_inventory(inventory, item_name)
        item = copy_item(@repository.find_item(item_name))
        return unless item

        item.equip! if item.is_a?(Weapon) || item.is_a?(Armor)
        inventory.add(item)
      end

      def pick_item_name(rule)
        rule.is_a?(Array) ? @randomizer.sample(rule) : rule
      end

      def copy_item(item)
        return unless item

        attributes = item.to_h.reject { |key, _| key == :equipped }

        case item
        when Weapon
          Weapon.new(**attributes)
        when Armor
          Armor.new(**attributes)
        else
          Item.new(**attributes)
        end
      end

      def roll_score
        @randomizer.roll_dice(count: 3, sides: 6)
      end
    end
  end
end
