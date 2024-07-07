var games = 0
var total_coins = 0
object Statistics{
    //Efetuar a leitura do ficheiro e associar o que está na primeira linha a games e a segunda a total_coins
    fun readAndKeep(){
        val stats = FileAccess.readFile("Statistics.txt")

        games = stats[0].toInt()
        total_coins = stats[1].toInt()

    }

    //Atualizar o ficheiro para colocar os dados de games e coins a 0
    fun eraseStats(){
        FileAccess.updateFile("Statistics.txt", listOf(0.toString(), 0.toString()))
    }

    //Guardar no ficheiro o valor de games e de coins atual
    fun saveToFile(games: Int, coins: Int) {
        FileAccess.updateFile("Statistics.txt", listOf(games.toString(), coins.toString()))
    }
}
/*Código feito ao som de:
    STARGAZING by Travis Scott
 */