require 'rails_helper'

RSpec.describe Game, type: :model do
  describe 'validations' do
    it 'validates status is in allowed values' do
      game = Game.new(status: 'invalid')
      expect(game).not_to be_valid
      expect(game.errors[:status]).to include('is not included in the list')

      valid_statuses = ['in_progress', 'won', 'draw']
      valid_statuses.each do |status|
        game = Game.new(status: status)
        game.valid?
        expect(game.errors[:status]).to be_empty
      end
    end

    it 'validates current_player is X or O' do
      game = Game.new(current_player: 'Z')
      expect(game).not_to be_valid
      expect(game.errors[:current_player]).to include('is not included in the list')

      ['X', 'O'].each do |player|
        game = Game.new(current_player: player)
        game.valid?
        expect(game.errors[:current_player]).to be_empty
      end
    end
  end

  describe 'default values' do
    let(:game) { Game.create }

    it 'has an empty board by default' do
      expect(game.board).to eq(['', '', '', '', '', '', '', '', ''])
    end

    it 'sets current_player to X by default' do
      expect(game.current_player).to eq('X')
    end

    it 'sets status to in_progress by default' do
      expect(game.status).to eq('in_progress')
    end

    it 'sets winner to nil by default' do
      expect(game.winner).to be_nil
    end
  end

  describe 'board serialization' do
    let(:game) { Game.create }

    it 'stores board as JSON and retrieves it as array' do
      game.board = ['X', 'O', '', '', '', '', '', '', '']
      game.save
      game.reload
      expect(game.board).to eq(['X', 'O', '', '', '', '', '', '', ''])
    end

    it 'handles empty board' do
      expect(game.board).to be_an(Array)
      expect(game.board.length).to eq(9)
    end
  end

  describe 'game states' do
    it 'can be marked as won' do
      game = Game.create(status: 'won', winner: 'X')
      expect(game.status).to eq('won')
      expect(game.winner).to eq('X')
    end

    it 'can be marked as draw' do
      game = Game.create(status: 'draw')
      expect(game.status).to eq('draw')
      expect(game.winner).to be_nil
    end
  end
end
