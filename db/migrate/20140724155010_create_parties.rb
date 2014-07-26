class CreateParties < ActiveRecord::Migration
  def change
    create_table :parties do |t|

      t.string      :hash_tag
      t.text        :queue

      t.timestamps
    end
  end
end
