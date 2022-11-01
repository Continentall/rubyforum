# frozen_string_literal: true

Rails.application.routes.draw do
  concern :commentable do
    resources :comments, only: %i[create destroy]
  end

  namespace :api do
    resources :tags, only: :index
  end
  scope '(:locale)', locale: /#{I18n.available_locales.join("|")}/ do #  /#{I18n.available_locales.join("|")}/ - регулярное выражение для передачи допустимых локализаций из application.rb
    # Теперь мы можем делать марштруты localhost/:locale/topic () говорят что это необязательно, те можно и без них
    root 'pages#index' # root - корневой маршрут / (example.com/), pages -имя контроллера который надо вызвать , index - метод котроллера к которому обращаемся
    # Один вызов resources может объявить все необходимые маршруты для ваших действий index, show, new, edit, create, update и destroy.
    # Не менее великолепно, что resources САМ определяет тип необходимых запросов POST,GET а так же (PATCH, PUT, DELETE), но это уже совсем другая история
    resource :session, only: %i[new create destroy] # сессии будут использоваться для авторизации
    # Отличие resourse от resources:
    # resource - предназначен для работы с единственным объектом (имеющимся сейчас)
    # resources - предназначен для работы с множеством обьектов (поэтому в нем используется индентификатор (чтобы указать с чем мы конкретно работаем ))
    resources :users, only: %i[new create edit update]

    resources :topics, concerns: :commentable do # или так (тоже самое) resources :topics, only: [:index, :new, :edit, :create]
      resources :messages, except: %i[new show]
    end
    resources :messages, except: %i[new show], concerns: :commentable

    namespace :admin do # namespace используется для создания маршрутов такого плана xxx.ru/<namespace>/user
      resources :users, only: %i[index create edit update destroy] # важно! html файлы и контроллер должны находится в папке с именем namespas'а..
    end
  end
  # Это вложенный маршрут. Типа маршруты внутри маршрутов. Забавно resources :path1 do resources :path2 end
end
