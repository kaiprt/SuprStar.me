class CreateSongs < ActiveRecord::Migration
  def change
    create_table :songs do |t|
      t.string      :name
      t.string      :youtube_url
      t.text        :lyrics
      t.belongs_to  :user
      t.belongs_to  :party

      t.timestamps
    end
  end
end
