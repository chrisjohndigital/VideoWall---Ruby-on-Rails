class CreateSections < ActiveRecord::Migration
  def change
    create_table :sections do |t|
        t.integer "wall_id"
        t.string "name"
        t.integer "position"
        t.boolean "visible", :default => true
        t.string "video_id"
        t.string "poster_id"
        t.string "mime_type"
        t.integer "video_width"
        t.integer "video_height"
        t.timestamps
    end
      add_index("sections", "wall_id")
  end
end
