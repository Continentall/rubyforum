# frozen_string_literal: true

class UserDecorator < ApplicationDecorator
  delegate_all # Автоматически передает методы экземпляра исходному объекту, который мы декорируем. Методы класса будут делегированы в object_class , если он установлен.

  def name_or_email
    return name if name.present?

    email.split('@')[0] # split — это метод класса String в Ruby, который используется для разделения заданной строки на массив подстрок на основе указанного шаблона.
  end
end
