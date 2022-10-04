# frozen_string_literal: true

# PagesController - название класса | < - знак наследования свойст от предка для всех контроллеров ApplicationController
class PagesController < ApplicationController
  #  Важно соблюдать правила названия, иначе клас найден не будет имя файла пишем с большой буквы + Controller

  def index
    # Rails по-умомолчанию для каждого метода найдет в папке views папку с названием контроллера (тут Pages) и выведет на экран файл с названием этого метода. С ума сойти можно!
  end
end
