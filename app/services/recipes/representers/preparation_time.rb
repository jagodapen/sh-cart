# frozen_string_literal: true

module Recipes
  module Representers
    class PreparationTime
      def initialize(minutes)
        @minutes = minutes
      end

      def call
        return unless @minutes
        return "#{@minutes % 60}min" if @minutes < 60

        "#{(@minutes / 60).floor}h #{@minutes % 60}min"
      end
    end
  end
end
