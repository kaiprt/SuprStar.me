class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string        :name
      t.string        :phone_number
      t.boolean       :is_verified,   :default => false
      t.belongs_to    :party

      t.timestamps
    end
  end
end
