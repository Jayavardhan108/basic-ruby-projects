# frozen_string_literal: true

# class for Player
class Player
  attr_accessor :name, :games_won, :games_lost

  def initialize(name)
    @name = name
    @games_won = 0
    @games_lost = 0
  end

  def won
    @games_won += 1
  end

  def lost
    @games_lost += 1
  end
end
