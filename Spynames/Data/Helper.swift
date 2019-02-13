class Helper {
    static func IntInf(_ s: String) -> Int {
        return (s == "∞") ? Int.max : Int(s)!
    }

    static func StrInf(_ i: Int) -> String {
        return (i == Int.max) ? "∞" : String(i)
    }
    
    static func getRandomUnique(from array: [Any], qty: Int) -> [Any] {
        /*
        var arr = array
        let len = arr.count
        guard len >= qty, qty > 0 else {
            print("getRandomUniqueFromRange: array len should be bigger than qty and qty should be positive")
            return []
        }
        var currentLen = len
        while len-currentLen < qty {
            let r = Int.random(in: 0..<currentLen)
            arr.swapAt(r, currentLen-1)
            currentLen -= 1
        }
        return Array(arr[currentLen..<len])
        */
        guard array.count >= qty, qty > 0 else {
            print("getRandomUnique: array len should be bigger than qty and qty should be positive")
            return []
        }
        return Array(array.shuffled()[0..<qty])
    }
}
