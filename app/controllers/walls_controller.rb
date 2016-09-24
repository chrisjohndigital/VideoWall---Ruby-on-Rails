class WallsController < ApplicationController
  layout 'application'
    def index
        @walls = Wall.sorted
        @wall_count = Wall.count + 1
        @wall = Wall.new({:name => "Default"})
    end
    
    def create
        @wall = Wall.new(wall_params)
        if @wall.save
            redirect_to(:action => 'index')
        else
            @walls = Wall.sorted
            @wall_count = Wall.count + 1
            render('index')
        end
    end
    def delete
        wall = Wall.find(params[:id]).destroy
        redirect_to(:action => 'index')
    end
    
    private

    def wall_params
      params.require(:wall).permit(:name, :position, :visible)
    end
end
