class ApplicationController < ActionController::Base

    rescue_from ActiveRecord::RecordNotFound, with: :notfound
    # rescue_from - (дословно) спасти от . Спасает от ошибки  ActiveRecord::RecordNotFound вызывая метод notfound

    private
    def notfound
        render file: 'public/404.html', status: :not_found, layout: false
        # status - код состояния (для 404 надо not_found) посмотреть все коды состояний можно тут http://www.railsstatuscodes.com/
        # Инфа про layouts http://rusrails.ru/layouts-and-rendering
    end
end
