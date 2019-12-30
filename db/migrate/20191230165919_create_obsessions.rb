class CreateObsessions < ActiveRecord::Migration[6.0]
  def change
    create_table :obsessions do |t|
      t.integer :fan_id
      t.integer :idol_id
      t.timestamps
    end
  end
end
