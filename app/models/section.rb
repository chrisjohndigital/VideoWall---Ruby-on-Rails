class Section < ActiveRecord::Base
    belongs_to :wall
    before_validation :sanitize_content
    
    after_save :touch_wall
    
    validates_presence_of :name
    validates_presence_of :position
    validates_presence_of :visible
    validates_presence_of :video_id
    validates_presence_of :poster_id
    validates_presence_of :mime_type
    validates_presence_of :video_width
    validates_presence_of :video_height
    
    
    validates :video_width, numericality: true
    validates :video_height, numericality: true
    
    validates_length_of :name, :maximum => 255    
    
    scope :sorted, lambda { order("sections.position ASC") }
    scope :newest_first, lambda { order("sections.created_at DESC") }
    
    private
    
    def touch_wall
        wall.touch
    end
    def sanitize_content
      #Add additional sanitization if required
    end
end