// Tutorial constants

struct T {
    static let messagesEng = [
        Message(text: "Hi, this is Spynames!", team: .redTeam, player: .spymaster, delay: Delay.std),
        Message(text: "A game for brave young Spymasters", team: .redTeam, player: .spymaster, delay: Delay.std),
        Message(text: "and their Operatives", team: .blueTeam, player: .operatives, delay: Delay.std),
        Message(text: "who compete in intelligence and cohesion!", team: .blueTeam, player: .operatives, delay: Delay.std),
        Message(text: "There are two teams:", team: .redTeam, player: .operatives, delay: Delay.std),
        Message(text: "RED", team: .redTeam, player: .spymaster, delay: Delay.std2),
        Message(text: "and BLUE", team: .blueTeam, player: .spymaster, delay: Delay.std2),
        Message(text: "Each team has:", team: .redTeam, player: .operatives, delay: Delay.std),
        Message(text: "Spymaster (1 person)", team: .redTeam, player: .spymaster, delay: Delay.std3),
        Message(text: "Operatives (1 or more persons)", team: .redTeam, player: .operatives, delay: Delay.std3),
        Message(text: "There are 25 Spynames", team: .blueTeam, player: .spymaster, delay: Delay.std2),
        Message(text: "9 of one team", team: .redTeam, player: .operatives, delay: Delay.std3),
        Message(text: "8 of another", team: .blueTeam, player: .spymaster, delay: Delay.std3),
        Message(text: "1 is a bomb!", team: .blueTeam, player: .spymaster, delay: Delay.std2),
        Message(text: "and the rest are civilians", team: .redTeam, player: .operatives, delay: Delay.std2),
        Message(text: "Only Spymasters know who is who", team: .redTeam, player: .spymaster, delay: Delay.std3),
        Message(text: "and Operatives don't know", team: .redTeam, player: .operatives, delay: Delay.std2),
        Message(text: "Spymaster's task is to give their Operatives a hint", team: .blueTeam, player: .spymaster, delay: Delay.std3),
        Message(text: "that helps them to learn which their words are", team: .blueTeam, player: .spymaster, delay: Delay.std3),
        Message(text: "She can group her words in a list on the right:", team: .redTeam, player: .spymaster, delay: Delay.std2),
        Message(text: "drag-and-drop to move", team: .redTeam, player: .spymaster, delay: 4.8),
        Message(text: "double-tap to separate", team: .redTeam, player: .spymaster, delay: Delay.std3),
        Message(text: "And she come up with a hint that combines some of them", team: .redTeam, player: .spymaster, delay: Delay.std2),
        Message(text: "First 3 words in our case:", team: .redTeam, player: .spymaster, delay: Delay.std2),
        Message(text: "\(Ru.tutorialWords[7]), \(Ru.tutorialWords[1]) and \(Ru.tutorialWords[23])", team: .redTeam, player: .spymaster, delay: Delay.std2),
        Message(text: "Than she tells her operatives this hint", team: .blueTeam, player: .spymaster, delay: Delay.std),
        Message(text: "and a number showing how many words are combined", team: .blueTeam, player: .spymaster, delay: 7.0),
        Message(text: "It's Operatives' turn now", team: .redTeam, player: .operatives, delay: Delay.std2),
        Message(text: "They choose which words suit better", team: .redTeam, player: .operatives, delay: Delay.std3),
        Message(text: "They can guess no more than the number of words Spymaster combined", team: .blueTeam, player: .operatives, delay: Delay.std),
        Message(text: "plus one", team: .blueTeam, player: .operatives, delay: 5.5),
        Message(text: "And they stop guessing as soon as", team: .redTeam, player: .operatives, delay: Delay.std),
        Message(text: "they make a mistake", team: .redTeam, player: .operatives, delay: 6.0),
        Message(text: "After that another Spymaster", team: .blueTeam, player: .spymaster, delay: Delay.std),
        Message(text: "makes his turn", team: .blueTeam, player: .spymaster, delay: 7.5),
        Message(text: "The game ends when one team", team: .redTeam, player: .operatives, delay: Delay.std),
        Message(text: "guess all its words", team: .blueTeam, player: .operatives, delay: 7.8),
        Message(text: "This team is a winner", team: .blueTeam, player: .spymaster, delay: Delay.std),
        Message(text: "Or", team: .redTeam, player: .operatives, delay: Delay.std),
        Message(text: "The game ends if one team", team: .redTeam, player: .operatives, delay: Delay.std2),
        Message(text: "guess the bomb!", team: .redTeam, player: .operatives, delay: 4.5),
        Message(text: "That team is a looser", team: .redTeam, player: .spymaster, delay: 4.5),
        Message(text: "Good luck!", team: .blueTeam, player: .operatives)
    ]
    static let messagesRu = [
        Message(text: "Привет, это Шпионские Имена!", team: .redTeam, player: .spymaster, delay: Delay.std),
        Message(text: "Команды шпионов в составе:", team: .redTeam, player: .spymaster, delay: Delay.std),
        Message(text: "Руководителей и Агентов", team: .blueTeam, player: .operatives, delay: Delay.std),
        Message(text: "соревнуются во взаимопонимании!", team: .blueTeam, player: .operatives, delay: Delay.std),
        Message(text: "В игре две команды:", team: .redTeam, player: .operatives, delay: Delay.std),
        Message(text: "КРАСНЫЕ", team: .redTeam, player: .spymaster, delay: Delay.std2),
        Message(text: "и СИНИЕ", team: .blueTeam, player: .spymaster, delay: Delay.std2),
        Message(text: "У каждой команде есть:", team: .redTeam, player: .operatives, delay: Delay.std),
        Message(text: "Руководитель (1шт)", team: .redTeam, player: .spymaster, delay: Delay.std3),
        Message(text: "Агенты (1 или более)", team: .redTeam, player: .operatives, delay: Delay.std3),
        Message(text: "Всего 25 карточек имен:", team: .blueTeam, player: .spymaster, delay: Delay.std2),
        Message(text: "9 одной команды", team: .redTeam, player: .operatives, delay: Delay.std3),
        Message(text: "8 другой", team: .blueTeam, player: .spymaster, delay: Delay.std3),
        Message(text: "1 убийца", team: .blueTeam, player: .spymaster, delay: Delay.std2),
        Message(text: "7 мирных жителей", team: .redTeam, player: .operatives, delay: Delay.std2),
        Message(text: "Только Оба Руководителя знают, кто есть кто", team: .redTeam, player: .spymaster, delay: Delay.std3),
        Message(text: "а их Агенты не знают", team: .redTeam, player: .operatives, delay: Delay.std2),
        Message(text: "Задача Руководителей дать такую подсказку своим агентам", team: .blueTeam, player: .spymaster, delay: Delay.std3),
        Message(text: "которая поможет им угадать свои имена", team: .blueTeam, player: .spymaster, delay: Delay.std3),
        Message(text: "Он может группировать слова в списке справа:", team: .redTeam, player: .spymaster, delay: Delay.std2),
        Message(text: "перетаскивать их", team: .redTeam, player: .spymaster, delay: 4.8),
        Message(text: "отделять группы слов двойным нажатием", team: .redTeam, player: .spymaster, delay: Delay.std3),
        Message(text: "и придумать такую подсказку, которая объединит несколько слов", team: .redTeam, player: .spymaster, delay: Delay.std2),
        Message(text: "первые 3 в нашем случае:", team: .redTeam, player: .spymaster, delay: Delay.std2),
        Message(text: "\(Ru.tutorialWords[7]), \(Ru.tutorialWords[1]) и \(Ru.tutorialWords[23])", team: .redTeam, player: .spymaster, delay: Delay.std2),
        Message(text: "Затем он сообщает своим агентам подсказку", team: .blueTeam, player: .spymaster, delay: Delay.std),
        Message(text: "и число, показывающее сколько слов он объединил", team: .blueTeam, player: .spymaster, delay: 7.0),
        Message(text: "Теперь ход оперативников", team: .redTeam, player: .operatives, delay: Delay.std2),
        Message(text: "Они выбирают свои слова", team: .redTeam, player: .operatives, delay: Delay.std3),
        Message(text: "Они могут угадать количество слов не больше, чем загадал Руководитель", team: .blueTeam, player: .operatives, delay: Delay.std),
        Message(text: "плюс одно", team: .blueTeam, player: .operatives, delay: 5.5),
        Message(text: "Они заканчивают отгадывать", team: .redTeam, player: .operatives, delay: Delay.std),
        Message(text: "как только сделают ошибку", team: .redTeam, player: .operatives, delay: 6.0),
        Message(text: "После этого ход переходит ", team: .blueTeam, player: .spymaster, delay: Delay.std),
        Message(text: "к Руководителю следующей команды", team: .blueTeam, player: .spymaster, delay: 7.5),
        Message(text: "Игра заканчивается, когда одна команда", team: .redTeam, player: .operatives, delay: Delay.std),
        Message(text: "Угадает все свои слова", team: .blueTeam, player: .operatives, delay: 7.8),
        Message(text: "Это команда - победитель!", team: .blueTeam, player: .spymaster, delay: Delay.std),
        Message(text: "Или", team: .redTeam, player: .operatives, delay: Delay.std),
        Message(text: "Игра закнчивается когда одна из команд", team: .redTeam, player: .operatives, delay: Delay.std2),
        Message(text: "угадают убийцу!", team: .redTeam, player: .operatives, delay: 4.5),
        Message(text: "Эта команда проиграла", team: .redTeam, player: .spymaster, delay: 4.5),
        Message(text: "Удачи!", team: .blueTeam, player: .operatives)
    ]
    static let messages = messagesEng
    
    static let sizeX = 5
    static let sizeY = 5
    static let tutorialColors: [CardColor] = [
        .red, .red, .blue, .neutral, .neutral,
        .blue, .red, .red, .neutral, .blue,
        .black, .blue, .blue, .blue, .neutral,
        .neutral, .red, .blue, .neutral, .red,
        .blue, .red, .red, .red, .neutral
    ]
    static let lastSixRedCardsNums = [12,5,2,20,9,11,17,13]
    
    struct Delay {
        static let totalBefore: [Double] = {
            var result: [Double] = [1.5] //a delay for 1st event
            var sum: Double = result[0]
            for m in messages.dropLast() {
                sum+=m.delay
                result.append(sum)
            }
            return result
        }()
        static let total = T.Delay.totalBefore.last! + messages.last!.delay
        static let betweenCards = 0.5
        static let enterHintText = 0.8
        static let changePicker = 0.5
        static let skipAlert = 1.4
        static let skipAlertGameOver = 2.3
        static let std = 1.7
        static let std2 = 2.8
        static let std3 = 3.4
    }
    static let picker = [
        Team.redTeam: 2,
        Team.blueTeam: 7
    ]
    struct skipTutorialAlert {
        static let title = "Skip tutorial"
        static let message = "Do you really want to skip the tutorial and start a new game?"
        static let buttonsText = ["Skip", "Continue"]
    }
}
