Rails.application.routes.draw do
    root 'pages#index' #root - корневой маршрут / (example.com/), pages -имя контроллера который надо вызвать , index - метод котроллера к которому обращаемся
    #Один вызов resources может объявить все необходимые маршруты для ваших действий index, show, new, edit, create, update и destroy.
    #Не менее великолепно, что resources САМ определяет тип необходимых запросов POST,GET а так же (PATCH, PUT , DELETE), но это уже совсем другая история
    resources :topics  # или так (тоже самое) resources :topics, only: [:index, :new, :edit, :create]
    
    #Таким образом одна строка отправляет в мусорку 4 :З
    #get '/topics', to: 'topics#index'   # GET - метод запроса
    #get '/topics/new', to: 'topics#new'
    #post '/topics', to: 'topics#create'    # Если мы получаем POST запрос /topics то отправляем его на обработку в метод create
    #get '/topics/:id/edit', to: 'topics#edit'    # Вместо :id будет автоматически подставлятся id из БД того топика, который хотят редактировать : указывает что поле - переменная
    
end
