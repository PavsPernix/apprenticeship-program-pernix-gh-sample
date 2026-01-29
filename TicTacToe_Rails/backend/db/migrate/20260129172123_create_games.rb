class CreateGames < ActiveRecord::Migration[7.2]
  def change
    create_table :games do |t|
      t.text :board, default: ['', '', '', '', '', '', '', '', ''].to_json
      t.string :current_player, default: 'X'
      t.string :status, default: 'in_progress'
      t.string :winner

      t.timestamps
    end
  end
end
