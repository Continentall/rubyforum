# frozen_string_literal: true

module ApplicationHelper
  include Pagy::Frontend
  # через запятую указано все что передается в блок к которому вызываем функцию
  def nav_tab(title, url, options = {})
    current_page = options.delete :current_page # удаляем из хэша эту переменную и присваеваем тут
    css_class = current_page == title ? 'text-muted' : 'text-black'

    options[:class] = if options[:class]
                        "#{options[:class]} #{css_class}"
                      else
                        css_class
                      end

    link_to title, url, options
  end

  def pagination(obj)
    # rubocop:disable Rails/OutputSafety
    raw(pagy_bootstrap_nav(obj)) if obj.pages > 1
    # rubocop:enable Rails/OutputSafety
  end

  def currently_at(current_page = '')
    render partial: 'shared/menu', locals: { local_current_page: current_page }
    # Весело, да? Локальная переменная принимает не локальную переменную с таким же названием и делает её доступной в паршале
    # указываем что рендерим паршал без макета из application.html.erb
    # все параметры рендеринга см тут http://rusrails.ru/layouts-and-rendering
    # а еще мы в паршал передаем локальную переменную что-бы там её юзать
  end

  def full_title(page_title = '')
    base_title = 'ITcolleque'
    if page_title.present?
      "#{page_title} | #{base_title}"
    else
      base_title
    end
  end
  # ТУТ КСТАТИ return автоматический, не забудь
end
