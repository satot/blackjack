class CreatePlayers < ActiveRecord::Migration[5.1]
  def change
    create_table :players do |t|
      t.references :game, foreign_key: true
      t.column :status, :tinyint
      t.boolean :is_dealer

      t.timestamps
    end
  end
end
