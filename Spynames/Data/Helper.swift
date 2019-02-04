class Helper {
    static func IntInf(_ s: String) -> Int {
        return (s == "∞") ? Int.max : Int(s)!
    }

    static func StrInf(_ i: Int) -> String {
        return (i == Int.max) ? "∞" : String(i)
    }
}
