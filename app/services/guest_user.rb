# frozen_string_literal: true

class GuestUser
  def guest?
    true
  end

  def author?(_)
    false
  end

  # Этот метод вызывается автоматически когда относительно образца класса вызван несуществующий метод
  def method_missing(name, *args, &)
    return false if name.to_s.end_with?('role?')

    super(name, *args, &)
  end

  def respond_to_missing?(name, include_private)
    return true if name.to_s.end_with?('role?')

    super(name, include_private)
  end
end
