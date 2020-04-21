class AddWonToGame < ActiveRecord::Migration[6.0]
  def change
    add_column :games, :won, :boolean, default: false
  end
end
