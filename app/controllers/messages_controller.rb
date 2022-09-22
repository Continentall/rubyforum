class MessagesController < ApplicationController
    before_action :find_topic_by_id!
    def create
        @message = @topic.messages.build get_message_params  # Сообщение =  Новый экземпляр типа ответы в топике с параметрами
        if @message.save
            flash[:success] = "Сообщение опубликовано"
            redirect_to topic_path(@topic) # В скобке указываем топик что-бы оно само вытащило последный id вопроса
        else
            render 'topics/show'
        end

    end
    #!!!!!!!!!!!!!!!!!! @messages = @topic.messages.order created_at :desc !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    private

    def find_topic_by_id!
        @topic = Topic.find params[:topic_id] # Находим топик в БД с полем id равному id указанному в ПАРАМЕТРАХ
        # Используя метод find можно получить объект, соответствующий определенному первичному ключу. ПРИ ПЕРЕДАЧЕ НЕСУЩЕСТВУЮЩЕГО ПАРАМЕТРА ВЫДАСТ ERROR
        # Метод find_by ищет первую запись, соответствующую некоторым условиям. ПРИ ПЕРЕДАЧЕ НЕСУЩЕСТВУЮЩЕГО ПАРАМЕТРА ВЫДАСТ nil
        # Метод where подходит если нужно получить несколько записей которые соответствуют определенным условиям
    end

    def get_message_params
        params.require(:message).permit(:body)
        # Из присланных параметров найти ТОПИК и разрешить брать только title и body. Что-бы веселые пользователи не всунули чего лишнего 
    end
end