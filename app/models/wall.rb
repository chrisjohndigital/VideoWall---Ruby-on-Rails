class Wall < ActiveRecord::Base
    has_many :sections
    before_validation :sanitize_content
    
    after_destroy :delete_related_sections
    
    validates_presence_of :name
    validates_presence_of :position
    validates_presence_of :visible
    validates_length_of :name, :maximum => 255
    
    scope :sorted, lambda { order("walls.position ASC") }
    
    private
    
    def delete_related_sections
      self.sections.each do |section|
        section.destroy
      end
    end
    
    def sanitize_content
      #Add additional sanitization if required
    end
end
