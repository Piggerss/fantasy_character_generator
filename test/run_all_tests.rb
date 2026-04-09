# frozen_string_literal: true

$LOAD_PATH.unshift("test") unless $LOAD_PATH.include?("test")

require "attributes_test"
require "character_class_test"
require "character_test"
require "item_test"
require "inventory_test"
require "inheritance_test"
require "randomizer_test"
require "data_repository_test"
require "character_generator_test"
require "test_fantasy_character_generator"