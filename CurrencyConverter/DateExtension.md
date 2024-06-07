extension Date {
    /// Obtém a data e hora atuais formatadas como "yyyy-MM-dd HH:mm:ss".
    func dataAtualFormatada() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter.string(from: self)
    }

    /// Obtém a data atual formatada como "dd/MM/yyyy".
    func dataAtualFormatoBrasileiro() -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "pt_BR") // Define o locale para português brasileiro
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter.string(from: self)
    }

    // Adicione outras funções de formatação aqui...
}
