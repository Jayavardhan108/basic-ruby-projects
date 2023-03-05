# frozen_string_literal: true

require '~/repos/basic-ruby-projects/tic_tac_toe/player'
require_relative 'tic_tac_toe'

# main class
class Main
  extend TicTacToe
  def self.play_game(player1, player2)
    play(player1, player2)
  end
end

player1 = Player.new('Jay')
player2 = Player.new('Vardhan')
Main.play_game player1, player2
