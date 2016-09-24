class SectionsController < ApplicationController
    layout 'application'
    before_action :find_wall
    
  def index
      @sections = @wall.sections.sorted
      @section_count = @wall.sections.count+1
      @section = Section.new({:wall_id => @wall.id, :name => "Default", :video_width => 1280, :video_height=> 720, :mime_type=> 'video/mp4' })
  end
    
    def delete
        section = Section.find(params[:id]).destroy
        redirect_to(:action => 'index', :wall_id => @wall.id)
    end
    
  def create
      uploaded_io = authorise_attachments[:attachment1]
       if uploaded_io
           if uploaded_io.content_type=='video/webm' ||  uploaded_io.content_type=='video/mp4'
               filename = sanitize_filename(uploaded_io.original_filename)
               File.open(Rails.root.join('public', 'uploads', uploaded_io.original_filename), 'wb') do |file|
                   file.write(uploaded_io.read)
               end
           end
         end
     uploaded_io = authorise_attachments[:attachment2]
       if uploaded_io
           if uploaded_io.content_type=='image/jpeg'
               filename = sanitize_filename(uploaded_io.original_filename)
               File.open(Rails.root.join('public', 'uploads', uploaded_io.original_filename), 'wb') do |file|
                   file.write(uploaded_io.read)
             end
         end
       end
    @section = Section.new(section_params)
    if @section.save        
        redirect_to(:action => 'index', :wall_id => @wall.id)
    else
        @sections = @wall.sections.sorted
        @section_count = @wall.sections.count+1
        render('index')
    end
  end
    
    private
    
    def find_wall
      if params[:wall_id]
        @wall = Wall.find(params[:wall_id])
      end
    end
    def section_params
      params.require(:section).permit(:wall_id, :name, :position, :visible, :video_id, :poster_id, :mime_type, :video_width, :video_height)
    end
    def authorise_attachments
      params.require(:section).permit(:attachment1, :attachment2)
    end
     def sanitize_filename(filename)
         filename.strip.tap do |name|
             name.sub! /\A.*(\\|\/)/, ''
             name.gsub! /[^\w\.\-]/, '_'
         end
         return (filename)
     end
end