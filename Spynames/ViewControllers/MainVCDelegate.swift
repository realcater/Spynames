protocol MainVCDelegate: class {
    func changeCardsColorVisibility(fade: Bool)
    func deleteFromWordsTable(card: Card)
    func updateScoreLabels()
    func updateLeftWordsQtyLabels()
    func pressed(uicard: UICard)
}
