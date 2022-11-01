# frozen_string_literal: true

class ApplicationService
  # Создание классовго метода call
  def self.call(...)
    new(...).call # Он инстанцирует указанный класс и вызывает действие которое он должен делать
  end
end
