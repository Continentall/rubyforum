class UserBulkService < ApplicationService
    attr_reader :archive

    def initialize(archive_param)
         @archive = archive_param.tempfile # tempfile -делает из загруженного объекта временный файл в памяти
    end

    def call
        Zip::File.open(@archive) do |zip_file| # Открытие архива переданного нам
            zip_file.each do |entry| # Проходим циклом по всем файлам внутри архива
                User.import users_from(entry), ignore: true # Вызов функции создания массива на основе файлика и отпрвка этого массива в БД одним запросом благодаря activerecord-import
                # import предоставляется как метод гема activerecord-import
            end
        end
    end

    private

    def users_from (entry)
        sheet = RubyXL::Parser.parse_buffer(entry.get_input_stream.read)[0]
        # entry.get_input_stream.read - открывает и читает содержимое файла содержащегося в Архивее
        # RubyXL::Parser.parse_buffer - парсит полученные данные, как xlsx файла
        # [0] - указывает на то что мы парсим первый лист из 
        sheet.map do |row| # Создание массива на основе данных
            cells = row.cells
            User.new name: cells[0].value, email: cells[1].value, password: cells[2].value, password_confirmation: cells[2].value #Создание в памяти пользователя с параметрами из ячеек
        end
    end

end