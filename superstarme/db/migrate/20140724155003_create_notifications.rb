class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.boolean        :was_notified,   :default => false
      t.belongs_to     :user
      t.belongs_to     :party

      t.timestamps
    end
  end
end
