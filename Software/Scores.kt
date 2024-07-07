import java.io.File

object Scores {
    const val LEADERBOARD_SIZE = 20 //Tamanho da leaderboard
    val alphabet = ('A'..'Z').toList() //Alfabeto numa lista
    val board = mutableListOf<Pair<Int, String>>() //Board, algo que mete int e string num par, para podermos indexar de acordo com o int.
    var playerName = "" //Nome do player que começa como ""

    fun loadScores(filename: String) {
        board.clear() //Apaga o board todo
        File(filename).forEachLine { line ->
            val parts = line.split(";") //Agarra nas linhas e dá split quando tem ";"
            if (parts.size == 2) {
                val number = parts[0].trim().toIntOrNull() //A parte da esquerda do é o score do jogador
                val name = parts[1].trim() //A parte direita é o nome do jogador
                if (number != null && name.isNotEmpty()) {
                    board.add(Pair(number, name)) //por fim se o valor de pontos não for nulo e o nome não for vazio adiciona ao board
                }
            }

        }
        board.sortByDescending { it.first } //Organiza o board segundo o score do maior para o menor
        board.take(LEADERBOARD_SIZE)
    }
    //Guarda os resultados
    fun saveScores(filename: String) {
        File(filename).printWriter().use { writer ->
            board.take(LEADERBOARD_SIZE).forEach { (score, name) ->  //Agarra no board e para os 20 primeiros escreve o par de score ; name
                writer.println("$score;$name")
            }
        }
    }

    //Binary Search pelas kills(score) para determinar o indice em que é adicionado o valor
    fun findInsertionIndex(newScore: Int): Int {
        var low = 0
        var high = board.size - 1
        while (low <= high) {
            val mid = (low + high) / 2
            when {
                board[mid].first < newScore -> high = mid - 1
                board[mid].first > newScore -> low = mid + 1
                else -> return mid
            }
        }
        return low
    }

    //função que atualiza a leaderboard, juntanto todas as anteriores
    fun updateLeaderboard() {
        if (!M.active()){
        val index = findInsertionIndex(kills) //descobre o index
        val playerScore = Pair(kills, playerName) //Associa as kills a um nome
        if(index >= board.size){
            board += playerScore //Index muito grande(maior do que o board) só adicionamos
        }
        if (index < LEADERBOARD_SIZE && index < board.size) { //Se o index for menor que o tamanho da leaderboard e do que o board
            board.add(index, playerScore) //Adicionamos
            if (board.size > LEADERBOARD_SIZE) {
                board.removeAt(LEADERBOARD_SIZE) //Removemos os que são maiores que o tamanho da leaderboard
            }
        }
        saveScores("SIG_Scores.txt") //Guardamos os scores
    }
    }
}
fun main() {
    KBD.init()
    LCD.init()
    Scores.loadScores("SIG_scores.txt")
    //Scores.inputPlayerName()
    Scores.updateLeaderboard()

}
