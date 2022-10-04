# frozen_string_literal: true

# Файлик seeds.rb нужен для заполнения приложения тестовыми демо-данными
# rails db:seed - команда для заполнения БД этими тест данными
30.times do
  title = Faker::Games::WorldOfWarcraft.quote
  body = Faker::Lorem.paragraph(sentence_count: 5, supplemental: true, random_sentences_to_add: 4)
  Topic.create title:, body:
end
# Faker генерирует текст мы создаем вопрос с такими значениями делаем 30 раз
