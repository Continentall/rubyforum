# frozen_string_literal: true

# даем имя нашему модулю
module ErrorHandling
  # В общем-то, модули являются контейнерами для классов, методов и констант. Или других модулей.
  # Они походи на Классы, но не могут быть инстанцированы.
  # Class наследует Module и добавляет new.
  # Модули полезны для двух целей: пространства имен и примеси.
  # Инстанцирование (англ. instantiation) — создание экземпляра класса.
  extend ActiveSupport::Concern # Вы делаете include модуля, чтобы добавить методы экземпляра класса, и extend — чтобы добавить методы класса.
  # Как я понял extend ActiveSupport::Concern НУЖНО ПОДКЛЮЧАТЬ ПРИ РАБОТЕ С МОДУЛЯМИ
  included do # Если включен в какой-либо класс выполняй
    rescue_from ActiveRecord::RecordNotFound, with: :notfound
    # rescue_from - (дословно) спасти от . Спасает от ошибки  ActiveRecord::RecordNotFound вызывая метод notfound

    private

    def notfound(exception)
      logger.warn exception # Запись в журнал событий rails ошибки
      render file: 'public/404.html', status: :not_found, layout: false
      # status - код состояния (для 404 надо not_found) посмотреть все коды состояний можно тут http://www.railsstatuscodes.com/
      # Инфа про layouts http://rusrails.ru/layouts-and-rendering
    end
  end
end
