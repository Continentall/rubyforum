# frozen_string_literal: true

# Всегда называйте контроллер так (имя таблицы + s)_controller.rb
class TopicsController < ApplicationController
  include TopicsMessages
  before_action :require_authentication, except: %i[show index]
  before_action :find_topic_by_id!, only: %i[edit update show destroy] # Эта запись говорит, что перед выполнением методов в квадратных ковычках нужно выполнить функцию find_topic_by_id
  before_action :authorize_topic!
  after_action :verify_authorized # Метод из Pundit он проверит сделана ли проверка прав *(если права не проверили то выскочит ошибка)
  # Контроллер для отображения всех Топиков
  def index
    @pagy, @topics = pagy Topic.all_by_tags(params[:tag_ids])

    @topics = @topics.decorate
    # @topics = Topic.all # В переменную образца класса записываем все записи таблицы Topic
  end

  # контроллер для создания нового Топика (без сохранения). Как в sqllite3 создание записи без t.save. Запись кстати по post запросу отправляется
  def show
    load_topic_messages
  end

  def new
    @topic = Topic.new # Создание новой переменной образца класса, для хранения 1го топика
  end

  def edit; end

  def create
    @topic = current_user.topics.build topic_params # Создание нового топика с привязкой пользователя с отправленными через post параметрами, отфильтрованными через topic_params
    if @topic.save # тут пытаемся сохранить и если все пройдет валидацию то выполняем if иначе else
      flash[:success] = t 'global.flash.topic.create'
      redirect_to topics_path # перенаправить на странцу
    else
      render :new # отобразить еще раз new.html.erb
    end
  end

  def update
    if @topic.update topic_params # тут пытаемся обновить c новыми параметрами (update - sql комманда как и save) и если все пройдет валидацию то выполняем if иначе else
      flash[:success] = t 'global.flash.topic.edit'
      redirect_to topics_path # перенаправить на странцу
    else
      render :edit # отобразить еще раз edit.html.erb
    end
  end

  def destroy
    @topic.destroy # Destroy - метод sql
    flash[:success] = t 'global.flash.topic.destroy'
    redirect_to topics_path
  end

  private

  def topic_params
    params.require(:topic).permit(:title, :body, tag_ids: [])
    # Из присланных параметров найти ТОПИК и разрешить брать только title и body. Что-бы веселые пользователи не всунули чего лишнего
  end

  def find_topic_by_id!
    @topic = Topic.find params[:id] # Находим топик в БД с полем id равному id указанному в ПАРАМЕТРАХ
    # Используя метод find можно получить объект, соответствующий определенному первичному ключу. ПРИ ПЕРЕДАЧЕ НЕСУЩЕСТВУЮЩЕГО ПАРАМЕТРА ВЫДАСТ ERROR
    # Метод find_by ищет первую запись, соответствующую некоторым условиям. ПРИ ПЕРЕДАЧЕ НЕСУЩЕСТВУЮЩЕГО ПАРАМЕТРА ВЫДАСТ nil
    # Метод where подходит если нужно получить несколько записей которые соответствуют определенным условиям
  end

  def authorize_topic!
    authorize(@toic || Topic) # authorize - метод из Pundit (он по сути делает проверки прав) он так же вызовет initialize и для пользовотеля оно по умолчанию вызовет метод current_user
  end
end
