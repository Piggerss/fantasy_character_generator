$LOAD_PATH.unshift("lib") unless $LOAD_PATH.include?("lib")
require "fantasy_character_generator"

def section(title)
  puts
  puts "=" * 80
  puts title
  puts "=" * 80
end

def print_character(character)
  puts character.summary
  puts "Attributes: #{character.attributes.to_h}"
  puts "Inventory: #{character.inventory.items.map(&:name).join(', ')}"
  puts "As hash: #{character.to_h}"
end

repository = FantasyCharacterGenerator::DataRepository.new

section("1. Loading data through DataRepository")
puts "Races: #{repository.races.map(&:name).join(', ')}"
puts "Classes: #{repository.character_classes.map(&:name).join(', ')}"
puts "Human first names: #{repository.names_for('Human')['first_names'].join(', ')}"
puts "Longsword from repository: #{repository.find_item('Longsword').to_h}"

section("2. Basic random generation")
generator = FantasyCharacterGenerator::Generator::CharacterGenerator.new
character = generator.generate
print_character(character)

section("3. Deterministic generation with seed")
seed = 1234
first_generator = FantasyCharacterGenerator::Generator::CharacterGenerator.new(
  randomizer: FantasyCharacterGenerator::Support::Randomizer.new(seed: seed)
)
second_generator = FantasyCharacterGenerator::Generator::CharacterGenerator.new(
  randomizer: FantasyCharacterGenerator::Support::Randomizer.new(seed: seed)
)
first_character = first_generator.generate
second_character = second_generator.generate

puts "First:  #{first_character.summary}"
puts "Second: #{second_character.summary}"
puts "Same result with same seed? #{first_character.to_h == second_character.to_h}"

section("4. Generation with explicit race and class")
fixed_character = generator.generate(race_name: "Elf", character_class_name: "Wizard")
print_character(fixed_character)

section("5. Working with Attributes directly")
attributes = FantasyCharacterGenerator::Attributes.new(
  strength: 10,
  dexterity: 12,
  constitution: 14,
  intelligence: 15,
  wisdom: 8,
  charisma: 13
)

puts "Base attributes: #{attributes.to_h}"
puts "Intelligence modifier: #{attributes.modifier_for(:intelligence)}"
attributes.apply_modifiers(dexterity: 2, wisdom: 1)
puts "After modifiers: #{attributes.to_h}"

section("6. Working with Item, Weapon, Armor, and Inventory")
sword = FantasyCharacterGenerator::Weapon.new(
  name: "Training Sword",
  description: "Simple example weapon",
  weight: 3,
  value: 1,
  damage: "1d6",
  damage_type: "slashing",
  range_type: "melee"
)
armor = FantasyCharacterGenerator::Armor.new(
  name: "Training Armor",
  description: "Simple example armor",
  weight: 8,
  value: 2,
  armor_bonus: 1,
  armor_type: "light",
  dex_bonus_allowed: true
)
rope = FantasyCharacterGenerator::Item.new(
  name: "Rope",
  description: "Simple utility item",
  weight: 10,
  value: 1
)

sword.equip!
armor.equip!

inventory = FantasyCharacterGenerator::Inventory.new
inventory.add(sword)
inventory.add(armor)
inventory.add(rope)

puts "All items: #{inventory.items.map(&:name).join(', ')}"
puts "Equipped weapon: #{inventory.equipped_weapon&.name}"
puts "Equipped armor: #{inventory.equipped_armor&.name}"
puts "Find by name 'Rope': #{inventory.find_by_name('Rope')&.to_h}"

section("7. Working with Character HP")
puts "Before damage: #{fixed_character.current_hp}/#{fixed_character.max_hp}"
fixed_character.damage(3)
puts "After damage: #{fixed_character.current_hp}/#{fixed_character.max_hp}"
fixed_character.heal(2)
puts "After heal: #{fixed_character.current_hp}/#{fixed_character.max_hp}"
fixed_character.full_heal!
puts "After full heal: #{fixed_character.current_hp}/#{fixed_character.max_hp}"
