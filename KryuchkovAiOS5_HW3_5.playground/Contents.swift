import UIKit


// Добавление протокола категорий (который будет использоваться в категориях и в библиотеке списка категорий
protocol CategoriesProtocol {
    var title: String {get set}
    
    // Используется Get, потому что данное вычисляемое свойство нужно только для вывода информаци о количестве треков
    var countElementsStringOut: String {get}
}


// Перечисление видов стран для треков
enum CountryTrack: Int {
    case USA
    case Russia
    case France
    case Italy
    case Germany
    case Britain
    
    var label: String {
        switch self {
            case .USA: return "США"
            case .Russia: return "Россия"
            case .France: return "Франция"
            case .Italy: return "Италия"
            case .Germany: return "Германия"
            case .Britain: return "Великобритания"
        }
    }
}


// Структура Аудиотрек
struct AudioTrack {
    var title: String
    var author: String
    var time: String = ""
    var country: CountryTrack
    
    // Приватный метод перевода секунд в формат мин. сек.
    private func timeIntToString(timeInt: Int) -> String {
        var timeOutput: String = ""
        var min: Int = 0
        var sec: Int = 0
        
        if timeInt > 0 {
            min = timeInt / 60
            sec = timeInt % 60
            
            if min > 0 {
                if sec > 0 {
                    timeOutput = "\(min) мин. \(sec) сек."
                }else {
                    timeOutput = "\(min) мин."
                }
            }else {
                timeOutput = "\(sec) сек."
            }
        }else {
            timeOutput = "время не указано"
        }
        
        return timeOutput
    }
    
        
    init(title: String, author: String, time: Int, country: CountryTrack) {
        
        self.title = title
        self.author = author
        self.country = country
        
        // Инициализация времени сразу с применением метода перевода из секунд в формат мин. сек.
        self.time = timeIntToString(timeInt: time)
    }
}


class CategoryTraks: CategoriesProtocol {
    
    // название библиотеки
    var title: String
    // библиотека песен
    var tracksLibrary: [AudioTrack] = []
    // счетчик количества треков
    
    // Вычисляемое свойство (получает количество песен в категории)
    var countElementsStringOut: String {
        get {
            var textOut: String
                if tracksLibrary.count > 0 {
                    textOut = "Количество песен в категории - \(tracksLibrary.count)"
                } else {
                    textOut = "Песен в данной категории нет"
                }
            return textOut
            }
    }
    
    // Метод добавления песни в библиотеку
    func add(title: String, author: String, time: Int, country: CountryTrack) {
        tracksLibrary.append(AudioTrack(title: title, author: author, time: time, country: country))
        print("Песня добавлена: исполнитель: \(author), название: \(title), продолжительность: \(time)")
    }
    
    
    // Метод удаления по название песни
    func delete(titleString: String) {
        
        if tracksLibrary.count > 0 {
            // цикл по массиву треков
            
            var index = 0
            var count = tracksLibrary.count
            while index <= count {
                                
                if tracksLibrary[index].title == titleString {
                    print("Песня \(tracksLibrary[index].title) автора \(tracksLibrary[index].author) удалена!")
                    tracksLibrary.remove(at: index)
                    count -= 1
                }
                
                index += 1
            }
        }else {
            print("Библиотека пустая")
        }
        
    }

    // метод показать весь трек лист
    func showListTracks() {
        if tracksLibrary.count > 0 {
            // цикл по массиву треков
            for item in tracksLibrary {
                print("Исполнитель: \(item.author), песня: \(item.title), продолжительность: \(item.time), страна: \(item.country.label)")
            }
        }else {
            print("Библиотека пустая")
        }
    }
    

    init (title: String) {
        self.title = title
    }
}



// ПРОВЕРКА

let myLibrary = CategoryTraks(title: "Моя библиотека")

myLibrary.showListTracks()
print("-----------------")
print(myLibrary.countElementsStringOut)
print("-----------------")
myLibrary.delete(titleString: "Песня 2")
print("-----------------")

myLibrary.add(title: "Песня 1", author: "Автор 1", time: 30, country: .Russia)
myLibrary.add(title: "Песня 2", author: "Автор 2", time: 95, country: .Russia)
myLibrary.add(title: "Песня 3", author: "Автор 3", time: 60, country: .Germany)
myLibrary.add(title: "Песня 4", author: "Автор 4", time: 0, country: .USA)
myLibrary.add(title: "Песня 5", author: "Автор 5", time: -10, country: .France)
myLibrary.add(title: "Песня 2", author: "Автор 6", time: 125, country: .France)


print("-----------------")
myLibrary.showListTracks()

print("-----------------")
print(myLibrary.countElementsStringOut)

print("-----------------")
myLibrary.delete(titleString: "Песня 2")
print("-----------------")
myLibrary.showListTracks()
