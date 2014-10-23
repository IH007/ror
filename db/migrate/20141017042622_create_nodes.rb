class CreateNodes < ActiveRecord::Migration
  def change
    create_table :nodes do |t|
      t.string :name_display
      t.string :node_type_id
      t.integer :users_id

      t.timestamps
    end
  end
end
