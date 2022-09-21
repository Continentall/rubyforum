Rails.application.routes.draw do
    root 'pages#index' #root - корневой маршрут / (example.com/), pages -имя контроллера который надо вызвать , index - метод котроллера к которому обращаемся
    get '/topics', to 'topics#index'
end
