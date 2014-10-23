class CreateLookups < ActiveRecord::Migration
  def change
    create_table :lookups do |t|
      t.string :lookup_type
      t.string :name
      t.string :name_display
      t.float :name_display_order

      t.timestamps
    end
  end
end
