# frozen_string_literal: true

module FantasyCharacterGenerator
  module Support
    class Randomizer
      def initialize(seed: nil, random: nil)
        @random = random || (seed.nil? ? Random.new : Random.new(seed))
      end

      def sample(array)
        array[@random.rand(array.length)]
      end

      def rand(range)
        @random.rand(range)
      end

      def roll_dice(count:, sides:)
        Array.new(count) { @random.rand(1..sides) }.sum
      end
    end
  end
end
