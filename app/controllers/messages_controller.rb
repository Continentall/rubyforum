# frozen_string_literal: true

class MessagesController < ApplicationController
  include ActionView::RecordIdentifier # модуль в котором находится dom_id надо подключить сюда, в html.erb его и так видно
  before_action :find_topic_by_id!
  before_action :find_message_by_id!, except: :create
  # Порядок before_action важен! Сначала ищем тему, потом для нее ответы
  def create
    @message = @topic.messages.build message_params # Сообщение =  Новый экземпляр типа ответы в топике с параметрами
    if @message.save
      flash[:success] = 'Сообщение опубликовано'
      redirect_to topic_path(@topic) # В скобке указываем топик что-бы оно само вытащило последный id вопроса
    else
      @pagy, @messages = pagy @topic.messages.order(created_at: :desc)
      render 'topics/show' # Рендер просто выводит страницу но не вызывает метод show. Поэтому нужно обьявить переменную, содержащуюся в show, тут (При редирект ту этого делать не надо)
    end
  end
  # !!!!!!!!!!!!!!!!!! @messages = @topic.messages.order created_at :desc !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

  def update
    if @message.update message_params
      flash[:success] = 'Сообщение изменено'
      redirect_to topic_path(@topic, anchor: dom_id(@message)) # Якорь позволит после редактирования сразу увитеть мвой изменнный ответ
    else
      render :edit
    end
  end

  def destroy
    @message.destroy
    flash[:success] = 'Сообщение удалено'
    redirect_to topic_path(@topic)
  end

  def edit; end

  private

  def message_params
    params.require(:message).permit(:body)
    # Из присланных параметров найти ТОПИК и разрешить брать только title и body. Что-бы веселые пользователи не всунули чего лишнего
  end

  def find_topic_by_id!
    @topic = Topic.find params[:topic_id] # Находим топик в БД с полем id равному id указанному в ПАРАМЕТРАХ
    # Используя метод find можно получить объект, соответствующий определенному первичному ключу. ПРИ ПЕРЕДАЧЕ НЕСУЩЕСТВУЮЩЕГО ПАРАМЕТРА ВЫДАСТ ERROR
    # Метод find_by ищет первую запись, соответствующую некоторым условиям. ПРИ ПЕРЕДАЧЕ НЕСУЩЕСТВУЮЩЕГО ПАРАМЕТРА ВЫДАСТ nil
    # Метод where подходит если нужно получить несколько записей которые соответствуют определенным условиям
  end

  def find_message_by_id!
    @message = @topic.messages.find params[:id]
    # Сообщение = от пременной топик sql запросом выбирает сообщение с нужным id
  end
end
