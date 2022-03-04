import UIKit

// ЗАДАЧА №1
print("ЗАДАЧА №1\n")


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
    
    // Метод удаления из библиотеки по название песни
    func delete(titleString: String) {
        
        if tracksLibrary.count > 0 {

            var index = 0
            var count = tracksLibrary.count
            
            // цикл по массиву треков
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
            print("Удаление невозможно, так как библиотека пустая")
        }
    }
    

    init (title: String) {
        self.title = title
    }
}


// ПРОВЕРКА

let myFirstCategory = CategoryTraks(title: "Моя библиотека")

myFirstCategory.showListTracks()
print("-----------------")
print(myFirstCategory.countElementsStringOut)
print("-----------------")
myFirstCategory.delete(titleString: "Песня 2")
print("-----------------")

myFirstCategory.add(title: "Песня 1", author: "Автор 1", time: 30, country: .Russia)
myFirstCategory.add(title: "Песня 2", author: "Автор 2", time: 95, country: .Russia)
myFirstCategory.add(title: "Песня 3", author: "Автор 3", time: 60, country: .Germany)
myFirstCategory.add(title: "Песня 4", author: "Автор 4", time: 0, country: .USA)
myFirstCategory.add(title: "Песня 5", author: "Автор 5", time: -10, country: .France)
myFirstCategory.add(title: "Песня 2", author: "Автор 6", time: 125, country: .France)


print("-----------------")
myFirstCategory.showListTracks()

print("-----------------")
print(myFirstCategory.countElementsStringOut)

print("-----------------")
myFirstCategory.delete(titleString: "Песня 2")
print("-----------------")
myFirstCategory.showListTracks()


// ЗАДАЧА №2
print("\nЗАДАЧА №2\n")


class MusicLibrary: CategoriesProtocol {
    
    var title: String
    var caterogiesLibrary: [CategoryTraks] = []
    var countElementsStringOut: String = ""
    
    
    // Метод позволяющий добавлять категории
    func add(categoryName: String){
        
        var isCategory: Bool = false
        
        // проверка на пустоту массива
        if caterogiesLibrary.count > 0 {
            // проверка на наличие данной категории в массиве
            for item in caterogiesLibrary {
                if item.title == categoryName {
                    isCategory = true
                    break
                }
            }
        }
        
        if isCategory {
            print("Добавление невозможно, так как данная категория существует!")
        }else {
            caterogiesLibrary.append(CategoryTraks(title: categoryName))
            print("Категория \(categoryName) добавлена")
        }
    }
    
    
    // Метод позволяющий удалять категории
    func delete(categoryName: String){
        
        var isCategory: Bool = false
        
        // проверка на пустоту массива
        if caterogiesLibrary.count > 0 {
            // проверка на наличие данной категории в массиве
            for item in caterogiesLibrary {
                if item.title == categoryName {
                    // Удаление
                    isCategory = true
                    print("Категория \(categoryName) удалена!")
                    break
                }
            }
            
            if isCategory == false {
                print("Удаление невозмолжно, так как нет такой категории в библиотеке!")
            }
            
        }else {
            print("Удаление невозможно, так как библиотека пустая!")
        }
    }
    
    
    init(title: String) {
        self.title = title
    }
}

let myMusicLibrary = MusicLibrary(title: "Моя библиотека")
print(myMusicLibrary.title)

myMusicLibrary.delete(categoryName: "Шансон")
print("-----------------")

myMusicLibrary.add(categoryName: "Шансон")
myMusicLibrary.add(categoryName: "Поп")
myMusicLibrary.add(categoryName: "Русский рэп")
myMusicLibrary.add(categoryName: "Шансон")
print("-----------------")

myMusicLibrary.delete(categoryName: "Шансон")
myMusicLibrary.delete(categoryName: "Абракадабра")
print("-----------------")

print(myMusicLibrary.caterogiesLibrary)
