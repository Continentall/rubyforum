module Api
    class TagsController < ApplicationController
        def index
            tags = Tag.arel_table
            @tags = Tag.where(tags[:title].matches("%#{params[:term]}%"))
            render json: TagBlueprint.render(@tags) #Сериализатор превратит колекцию тегов в Json файлик
        end
    end
end