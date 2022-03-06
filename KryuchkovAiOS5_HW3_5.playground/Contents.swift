import UIKit

/*
 Сказу скажу, что код мне самому очень не нравится, переписывал его как только мог неделю, но получилось то, что получилось.
 
 Я бы сделал не так если бы задача была общая.
 
 Создал бы структуру Трек, Создал бы основной клас Библиотека (а категорию или классом или структурой, а лучше вообще бы не создавал бы, а как свойство в трек).
 
 Но так как у нас есть задача №1 в которой мы еще не знаем, что будет библиотека, то получается, что класс категория самостоятельный где можно добавлять и удалять трек и когда мы создаем класс Библиотека (я его связал с классом Категория по типу агрегации, а не жестко), то мы не можем напрямую в библиотеку добавлять треки (не через класс Категория), так как тогда задача №1 не будет работать.
 
В итоге получилось много лишнего или повторяемого кода((((((((((((

Но по другому я не смог придумать если честно.
 */


// ЗАДАЧА №1
print("ЗАДАЧА №1\n")


// Добавление протокола категорий (который будет использоваться в категориях и в библиотеке списка категорий
protocol CategoriesProtocol {
    var title: String {get set}
    // Используется Get, потому что данное вычисляемое свойство нужно только для вывода информаци о количестве треков
    var countElementsStringOut: String {get}
    
    func deleteCategory(titleString: String)
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
    
    let trackId: Int
    
    var title: String
    var author: String
    var time: String = ""
    var country: CountryTrack
    var category: String
    
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
    
        
    init(trackId:Int, title: String, author: String, time: Int, country: CountryTrack, category: String) {
        
        self.trackId = trackId
        self.title = title
        self.author = author
        self.country = country
        self.category = category
        
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
    public func add(trackId:Int, title: String, author: String, time: Int, country: CountryTrack) {
        tracksLibrary.append(AudioTrack(trackId: trackId, title: title, author: author, time: time, country: country, category: self.title))
        print("Песня добавлена: исполнитель: \(author), название: \(title), категория: \(self.title), ID трека: \(trackId)")
    }
    
    // Метод удаления из библиотеки по название песни
    func deleteCategory(titleString: String) {
        
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
            
            print("Список песен в категории: \(self.title)")
            
            // цикл по массиву треков
            for item in tracksLibrary {
                print("Исполнитель: \(item.author), песня: \(item.title), продолжительность: \(item.time), страна: \(item.country.label), ID трека: \(item.trackId)")
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

let myFirstCategory = CategoryTraks(title: "Моя первая категория")

myFirstCategory.showListTracks()
print("-----------------")
print(myFirstCategory.countElementsStringOut)
print("-----------------")
myFirstCategory.deleteCategory(titleString: "Песня 2")
print("-----------------")

myFirstCategory.add(trackId: 1, title: "Песня 1", author: "Автор 1", time: 30, country: .Russia)
myFirstCategory.add(trackId: 2, title: "Песня 2", author: "Автор 2", time: 95, country: .Russia)
myFirstCategory.add(trackId: 3, title: "Песня 3", author: "Автор 3", time: 60, country: .Germany)
myFirstCategory.add(trackId: 4, title: "Песня 4", author: "Автор 4", time: 0, country: .USA)
myFirstCategory.add(trackId: 5, title: "Песня 5", author: "Автор 5", time: -10, country: .France)
myFirstCategory.add(trackId: 6, title: "Песня 2", author: "Автор 6", time: 125, country: .France)


print("-----------------")
myFirstCategory.showListTracks()

print("-----------------")
print(myFirstCategory.countElementsStringOut)

print("-----------------")
myFirstCategory.deleteCategory(titleString: "Песня 2")
print("-----------------")
myFirstCategory.showListTracks()


// ЗАДАЧА №2
print("\nЗАДАЧА №2\n")


class MusicLibrary: CategoriesProtocol {
    
    var title: String
    var caterogiesLibrary: [CategoryTraks] = []
    var audioTrack: [AudioTrack] = []
    
    // Уникальный ID для песен (при любом добавлении будет увеличиваться)
    var trackId: Int = 1
    
    var countElementsStringOut: String {
        get {
            var textOut: String
                if caterogiesLibrary.count > 0 {
                    textOut = "Количество категорий в библиотеке - \(caterogiesLibrary.count)"
                } else {
                    textOut = "В библиотеке пока нет категорий"
                }
            return textOut
            }
    }
    
    
    // Метод позволяющий добавлять категории
    func addCategory(categoryName: String){
        
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
    func deleteCategory(titleString: String){
        if caterogiesLibrary.count > 0 {
            var index = 0
            var count = caterogiesLibrary.count
            
            // цикл по массиву треков
            while index <= (count-1) {
                if caterogiesLibrary[index].title == titleString {
                    print("Категория \(titleString) удалена!")
                    caterogiesLibrary.remove(at: index)
                    count -= 1
                }
                index += 1
            }
        }else {
            print("Библиотека пустая")
        }
    }
    
    
    // Метод, позволяющий просматривать количество категорий внутри
    func showCaterogies() {
        if caterogiesLibrary.isEmpty {
            print("Категорий в биллиотеке пока нет!")
        }else {
            print("Список категорий:")
            for item in caterogiesLibrary {
                print("Название категории: \(item.title)")
            }
        }
    }
    
    
    // Метод, позволяющий добавлять песню в категорию
    func addTrack(title: String, author: String, time: Int, country: CountryTrack, category addTrackCategory: String){
        
        var isCategory = false
        
        for item in caterogiesLibrary {
            if item.title == addTrackCategory {
                item.add(trackId: trackId, title: title, author: author, time: time, country: country)
                isCategory = true
                trackId += 1
                break
            }
        }
        
        if isCategory != true {
            print("Невозможно добавить трек! Нет такой категории!")
        }
    }
    
    init(title: String) {
        self.title = title
    }
}

// Создаем библиотеку
let myMusicLibrary = MusicLibrary(title: "Моя библиотека")
print(myMusicLibrary.title)

// Пробуем удалить несуществующую категорию
myMusicLibrary.deleteCategory(titleString: "Шансон")
print("-----------------")

// Выводим количество категорий (при пустой библиотеке)
print(myMusicLibrary.countElementsStringOut)
print("-----------------")

// Показываем список категорий (при пустой библиотеке)
myMusicLibrary.showCaterogies()
print("-----------------")

// Добавление категорий
myMusicLibrary.addCategory(categoryName: "Шансон")
myMusicLibrary.addCategory(categoryName: "Поп")
myMusicLibrary.addCategory(categoryName: "Русский рэп")
myMusicLibrary.addCategory(categoryName: "Шансон")
myMusicLibrary.addCategory(categoryName: "Транс")
print("-----------------")

// Показываем список категорий
myMusicLibrary.showCaterogies()
print("-----------------")

// Удаляем категории
myMusicLibrary.deleteCategory(titleString: "Шансон")
myMusicLibrary.deleteCategory(titleString: "Транс")
// Несуществующая категория
myMusicLibrary.deleteCategory(titleString: "Абракадабра")
print("-----------------")

// Показываем категории
myMusicLibrary.showCaterogies()
print("-----------------")

// Добавление песен в различные категории
myMusicLibrary.addTrack(title: "Песня 1", author: "Автор 1", time: 30, country: .Russia, category: "Поп")
myMusicLibrary.addTrack(title: "Песня 2", author: "Автор 2", time: 95, country: .Russia, category: "Русский рэп")
// Не существующая категория
myMusicLibrary.addTrack(title: "Песня 3", author: "Автор 3", time: 60, country: .Germany, category: "Шансон")
myMusicLibrary.addTrack(title: "Песня 4", author: "Автор 4", time: 0, country: .USA, category: "Русский рэп")
myMusicLibrary.addTrack(title: "Песня 5", author: "Автор 5", time: -10, country: .France, category: "Поп")
// Не существующая категория
myMusicLibrary.addTrack(title: "Песня 2", author: "Автор 6", time: 125, country: .France, category: "Транс")

// ЗАДАЧА №3
print("\nЗАДАЧА №3\n")


extension MusicLibrary {
    
    
    // Как раз из-за того, что мы добавляем треки в класс Библиотека не напрямую, а через класс Категория, то мы не получаем общий массив треков, а получаем массив треков в каждом классе отдельно. И из-за этого выскакивает геммор поиска и переназначения.
    
    // В идеале я бы хотел создать метод, где было б только ID трека и название новой категории, но так как у нас по факту сейчас несколько массивов с песнями, то так не получится. И придется делать удаление из одного массива трек в другой (также соответственно поменяется его ID).
    
    // Вообщем колхоз по полной и все из-за задачи №1. Если делать задачу №3 отдельно, то было бы красивей и удобней. Ну или я не доподнял до конца как красиво сделать))))
    
    // Метод изменения трека у категории
    func changeTrackCategory(trackId: Int, oldCategory:String, newCategory: String) {
        
        var ifNotTrack = true
        
        var indexOldCategory: Int = -1
        var indexNewCategory: Int = -1
        
        for index in caterogiesLibrary.indices {
            
            if caterogiesLibrary[index].title == oldCategory{
                indexOldCategory = index
            }
            
            if caterogiesLibrary[index].title == newCategory{
                indexNewCategory = index
            }
        }
                
        if indexOldCategory != -1 && indexNewCategory != -1 {
        
            for index in caterogiesLibrary[indexOldCategory].tracksLibrary.indices {
                
                // Для читаемости
                let itemCategory = caterogiesLibrary[indexOldCategory]
                
                if itemCategory.tracksLibrary[index].trackId == trackId {
                    ifNotTrack = false
                    itemCategory.tracksLibrary[index].category = newCategory
                    print("Изменена категория песни: исполнитель: \(itemCategory.tracksLibrary[index].author), название: \(itemCategory.tracksLibrary[index].title), продолжительность: \(itemCategory.tracksLibrary[index].time), новая категория: \(itemCategory.tracksLibrary[index].category), ID трека: \(itemCategory.tracksLibrary[index].trackId)")
                }
            }
        }else {
            if indexOldCategory == -1 {
                print("Старой категории \(oldCategory) не существует!")
                ifNotTrack = false
            }
            
            if indexNewCategory == -1 {
                print("Новой категории \(newCategory) не существует!")
                ifNotTrack = false
            }
        }
        
        if ifNotTrack {
            print("Невозможно изменить категорию, так как данной песни нет в библиотеке")
        }
        
    }
}


// Проверка

print("-----------------")
myMusicLibrary.changeTrackCategory(trackId: 2, oldCategory: "Шансон", newCategory: "Поп")
print("-----------------")
myMusicLibrary.changeTrackCategory(trackId: 1, oldCategory: "Поп", newCategory: "Русский рэп")
print("-----------------")
myMusicLibrary.changeTrackCategory(trackId: 3, oldCategory: "Шансон", newCategory: "Абракадабра")
