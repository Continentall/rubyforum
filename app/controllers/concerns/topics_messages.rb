# frozen_string_literal: true

module TopicsMessages
  extend ActiveSupport::Concern

  included do
    # значит по умолчанию false
    def load_topic_messages(do_render: false)
      @topic = @topic.decorate # задекорировав topics мы не задекорировали еще и topic, что могло бы показаться логичным, но нет
      @message ||= @topic.messages.build # НЕВЕРОЯТНО ВАЖНО если мы хотим сохранить родительские отношения объектов и нужно создать новый экземпляр, то надо использовать .build а не .new, тк .new их не сохранит
      # Сообщение =  Новый экземпляр типа сообщения в топике (Тут мы кстати начинаем создавать сообщение сразу (в Топиках мы делаем это в методе new, но тут new нету так что делаем в show), но не сохраняем, как в БД)
      @pagy, @messages = pagy @topic.messages.includes([:user]).order(created_at: :desc)
      @messages = @messages.decorate
      render('topics/show') if do_render
      # Рендер просто выводит страницу но не вызывает метод show. Поэтому нужно обьявить переменную, содержащуюся в show, тут (При редирект ту этого делать не надо)
    end
  end
end
