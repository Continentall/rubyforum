#Всегда называйте контроллер так (имя таблицы + s)_controller.rb
class TopicsController < ApplicationController
    before_action :find_topic_by_id, only: [:edit, :update, :show, :destory] # Эта запись говорит, что перед выполнением методов в квадратных ковычках нужно выполнить функцию find_topic_by_id
    
    def index # Контроллер для отображения всех Топиков
        @topics = Topic.all # В переменную образца класса записываем все записи таблицы Topic
    end

    def new # контроллер для создания нового Топика (без сохранения). Как в sqllite3 создание записи без t.save. Запись кстати по post запросу отправляется
        @topic = Topic.new # Создание новой переменной образца класса, для хранения 1го топика
    end

    def create
        @topic = Topic.new get_topic_params #Создание нового топика с отправленными через post параметрами, отфильтрованными через get_topic_params
        if @topic.save # тут пытаемся сохранить и если все пройдет валидацию то выполняем if иначе else
            flash[:success] = "Обсуждение успешно созданно"
            redirect_to topics_path # перенаправить на странцу
        else
            render :new # отобразить еще раз new.html.erb
        end
    end

    def edit
    end

    def update
        if @topic.update get_topic_params # тут пытаемся обновить c новыми параметрами (update - sql комманда как и save) и если все пройдет валидацию то выполняем if иначе else
            flash[:success] = "Обсуждение успешно изменено"
            redirect_to topics_path # перенаправить на странцу
        else
            render :edit # отобразить еще раз edit.html.erb
        end
    end

    def destroy
        @topic.destroy #Destroy - метод sql
        flash[:success] = "Обсуждение удалено"
        redirect_to topics_path
    end


    def show
    end

    private
    def get_topic_params
        params.require(:topic).permit(:title, :body)
        # Из присланных параметров найти ТОПИК и разрешить брать только title и body. Что-бы веселые пользователи не всунули чего лишнего 
    end
    def find_topic_by_id
        @topic = Topic.find id: params[:id] # Находим топик в БД с полем id равному id указанному в ПАРАМЕТРАХ
        # Используя метод find можно получить объект, соответствующий определенному первичному ключу. ПРИ ПЕРЕДАЧЕ НЕСУЩЕСТВУЮЩЕГО ПАРАМЕТРА ВЫДАСТ ERROR
        # Метод find_by ищет первую запись, соответствующую некоторым условиям. ПРИ ПЕРЕДАЧЕ НЕСУЩЕСТВУЮЩЕГО ПАРАМЕТРА ВЫДАСТ nil
        # Метод where подходит если нужно получить несколько записей которые соответствуют определенным условиям
    end
end 