class CreateNodeAttributeIntegervalues < ActiveRecord::Migration
  def change
    create_table :node_attribute_integervalues do |t|
      t.integer :value_integer
      t.string :nodes_id
      t.string :node_attributes_id

      t.timestamps
    end
  end
end
