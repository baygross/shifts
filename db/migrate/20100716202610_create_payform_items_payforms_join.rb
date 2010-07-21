class CreatePayformItemsPayformsJoin < ActiveRecord::Migration
  def self.up
    create_table :payform_items_payforms, :id => false do |t|
      t.references :payform_item
      t.references :payform
      t.boolean :active, :default => true
    end
  end

  def self.down
    drop_table :departments_users
  end
end
