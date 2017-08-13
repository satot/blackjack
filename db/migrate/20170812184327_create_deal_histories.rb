class CreateDealHistories < ActiveRecord::Migration[5.1]
  def change
    create_table :deal_histories do |t|
      t.references :player, foreign_key: true
      t.string :card

      t.timestamps
    end
  end
end
