class Parties < ActiveRecord::Migration
  def change
    create_table :parties do |t|
      t.string      :name
      t.string      :hash_tag
      t.text        :queue

      t.timestamps
    end
  end
end
