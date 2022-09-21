Rails.application.routes.draw do
    get '/topics', to: 'topics#index'

    root 'pages#index' #root - корневой маршрут / (example.com/), pages -имя контроллера который надо вызвать , index - метод котроллера к которому обращаемся
end
