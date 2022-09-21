#Всегда называйте контроллер так (имя таблицы + s)_controller.rb
class TopicsController < ApplicationController
    def index
        @topics = Topic.all # В переменную образца класса записываем все записи таблицы Topic
    end
end 