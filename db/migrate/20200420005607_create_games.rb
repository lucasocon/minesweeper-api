class CreateGames < ActiveRecord::Migration[6.0]
  def change
    create_table :games do |t|
      t.text :board, array: true, default: []
      t.text :mines_board, array: true, default: []
      t.boolean :lost, default: false

      t.timestamps
    end
  end
end
