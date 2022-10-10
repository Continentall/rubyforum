# frozen_string_literal: true

class UserDecorator < ApplicationDecorator
  delegate_all # Автоматически передает методы экземпляра исходному объекту, который мы декорируем. Методы класса будут делегированы в object_class , если он установлен.

  def name_or_email
    return name if name.present?

    email.split('@')[0] # split — это метод класса String в Ruby, который используется для разделения заданной строки на массив подстрок на основе указанного шаблона.
  end

  def gravatar(size: 30, css_class: '')
    h.image_tag "https://www.gravatar.com/avatar/#{gravatar_hash}.jpg?s=#{size}", class: "rounded #{css_class}", alt: name_or_email
    # в декораторах при использовании хелперов руби надо указывать h.имяхелпера
  end
end
