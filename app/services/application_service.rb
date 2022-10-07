class ApplicationService 
    def self.call(*args, &block) #Создание классовго метода call
        new(*args, &block).call # Он инстанцирует указанный класс и вызывает действие которое он должен делать
    end
end