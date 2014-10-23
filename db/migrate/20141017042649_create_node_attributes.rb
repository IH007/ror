class CreateNodeAttributes < ActiveRecord::Migration
  def change
    create_table :node_attributes do |t|
      t.integer :node_attribute_type_id
      t.string :name
      t.string :name_display
      t.float :name_display_order
      t.integer :node_type_id

      t.timestamps
    end
  end
end
