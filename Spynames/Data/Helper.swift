class Helper {
    static func IntInf(_ s: String) -> Int {
        return (s == "∞") ? Int.max : Int(s)!
    }

    static func StrInf(_ i: Int) -> String {
        return (i == Int.max) ? "∞" : String(i)
    }
    
    static func getRandomUnique(from array: [Any], qty: Int) -> [Any] {
        guard array.count >= qty, qty > 0 else {
            print("getRandomUnique: array len should be bigger than qty and qty should be positive")
            return []
        }
        return Array(array.shuffled()[0..<qty])
    }
    static func randomString(length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0..<length).map{ _ in letters.randomElement()! })
    }
}
