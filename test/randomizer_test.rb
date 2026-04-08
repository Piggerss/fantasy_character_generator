# frozen_string_literal: true

require "test_helper"

class RandomizerTest < Minitest::Test
  def test_supports_initialization_without_a_seed
    randomizer = FantasyCharacterGenerator::Support::Randomizer.new
    value = randomizer.rand(1..6)

    assert_operator(value, :>=, 1)
    assert_operator(value, :<=, 6)
  end
end
