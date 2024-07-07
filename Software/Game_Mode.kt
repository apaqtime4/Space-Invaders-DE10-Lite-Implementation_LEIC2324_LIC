import isel.leic.utils.Time
import kotlin.system.exitProcess

const val alternancyRate = 3000 //Mudança de menu no menu inicial a cada 3 segundos
const val spawnRate = 1000 // Aparece um novo inimigo a cada segundo

var LCD1 = mutableListOf(" ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ")
var LCD2 = mutableListOf(" ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ")
val NUMBERS = listOf("0","1","2","3","4","5","6","7","8","9")

var gameover = false
var acertou = false
var start = false

var countIteration = 0
var counterMenu = 0
var linha = 0
var coins = 0
var coinsTemp = 0
var kills = 0

fun main(){
    TUI.init()
    ScoreDisplay.init()
    Statistics.readAndKeep() // Ler as estatisticas
    Scores.loadScores("SIG_Scores.txt") // Ler o leaderboard
    while (true){
        mainLoop()
        resetGame()
    }
}
//Loop principal (jogo acontece aqui)
fun mainLoop(){

    var lastTime = System.currentTimeMillis()
    if (!M.active())
        updateCoinsDisplay(coins) //Escreve o valor de coins a $0
    menu()
    ScoreDisplay.setScore(0) //Começa o jogo com Score a 0
    kills = 0
    gameover = false
    start = true
    ScoreDisplay.stopAnimation() //Para as animações
    while (start){
        ScoreDisplay.updateAnimation() //Dar update ao valor do Score Display
        val currentKey = TUI.pressed_key().toString()

        if (currentKey != KBD.NONE.toString() && currentKey != "*" && currentKey != "#") {
            // Dar load ao bacano
            if (linha%2 == 0) {
                LCD1[0] = currentKey
            }
            if (linha%2 == 1) {
                LCD2[0] = currentKey
            }
            TUI.update()
        }

        if (currentKey == "#") {
            // Disparar
            eliminateEnemy()
        }

        switchLine(currentKey)

        val currentTime = System.currentTimeMillis()
        if (currentTime - lastTime >= spawnRate) {
            spawn()
            lastTime = currentTime //Atualizar o valor para voltar a esperar 1 segundo
        }
        if(gameover){
            gameOver()
            start=false
        }
    }
    resetGame()
}
//Função que efetua a mudança de linha do LCD ao pressionarmos '*' enquanto estivermos no jogo
fun switchLine (key : String){
    if (key == "*") {
        linha = ++linha
        if(linha%2 == 0){
            LCD1[1] = ">"
            LCD2[1] = " "
            LCD1[0] = "]"
            LCD2[0] = "]"
        }
        if(linha%2 == 1){
            LCD2[1] = ">"
            LCD1[1] = " "
            LCD2[0] = "]"
            LCD1[0] = "]"
        }
        TUI.update() //Para efetuar a substituição de ">" pela nave
    }
}

//Função que converte de string para Int
fun convert(string : String) : Int {
    return string.toInt()
}

fun eliminateEnemy(){
    if((firstElementEmpty(LCD1)+1) in 0..15){
    val enemyOfLine1 = LCD1[lastElementFull(LCD1)]//VALOR DO ALVO


    // Caso da primeira linha
    if (LCD1[0] == LCD1[firstElementEmpty(LCD1)+1] && firstElementEmpty(LCD1) <= 15){
        LCD1[firstElementEmpty(LCD1)+1] = " " //
        LCD1[0] = "]" //
        kills += (convert(enemyOfLine1) + 1) //
        ScoreDisplay.setScore(kills) //Meter o scoreDisplay com o valor de kills
        acertou=true
    }
    }
    if((firstElementEmpty(LCD2)+1) in 0..15 ){
    val enemyOfLine2 = LCD2[lastElementFull(LCD2)] //

    // Caso da segunda linha
    if (LCD2[0] == LCD2[firstElementEmpty(LCD2)+1] && firstElementEmpty(LCD2) <= 15){
        LCD2[firstElementEmpty(LCD2)+1] = " " //
        LCD2[0] = "]" //
        kills += (convert(enemyOfLine2) + 1) //
        ScoreDisplay.setScore(kills)        //Meter o scoreDisplay com o valor de kills
        acertou=true
    }
    }
    TUI.update()                            //Dar update ao TUI para termos o número a desaparecer
}

fun spawn(){
    val enemy = NUMBERS.random()                    // Gerar um número aleatório para ser o próximo inimigo
    val enemyLine = (0..1).random()             // Gerar um número entre 0 e 1 para decidir a linha onde estará o próximo inimigo

    if(firstElementEmpty(LCD1) <= 1 || firstElementEmpty(LCD2) <= 1){ //!Condição de derrota!
        gameover = true
        return
    }
    if (enemyLine==0){ //casos do spawn ser na linha 1
        for (i in firstElementEmpty(LCD1)..<LCD1.size-1){ //como é downto
            LCD1[i] = LCD1[i+1] //i vai para i+1(-1 no LCD)
            LCD1[i+1] = " " //E o i+1 vai ser espaço, libertando o i de número 15
        }
        LCD1[LCD1.size-1] = enemy //Para colocar o inimigo no mesmo (o mais à direita)
        TUI.update()
    }
    else if (enemyLine==1){ //casos do spawn ser na linha 2
        for (i in firstElementEmpty(LCD2)..<LCD2.size-1){ //como é downto
            LCD2[i] = LCD2[i+1] //i vai para i+1(-1 no LCD)
            LCD2[i+1] = " " //E o i+1 vai ser espaço, libertando o i de número 15
        }
        LCD2[LCD2.size-1] = enemy //Para colocar o inimigo no mesmo (o mais à direita)
        TUI.update()
    }
}

// Retorna o indice do elemento vazio ao lado de um inimigo
fun firstElementEmpty(list: MutableList<String>):Int {
    for (i in list.size - 1 downTo 0) {
        if (list[i] == " ") {
            return i
        }
    }
    return -1
}

// Retorna o indice do elemento da ponta esquerda
fun lastElementFull(list: MutableList<String>):Int{
    for (i in 0..<list.size) {
        if (list[i] in NUMBERS) {
            return i
        }
    }
    return -1
}

fun gameOver(){         // Função que dá handle ao estado de Game Over
    start=false
    val timeinit = Time.getTimeInMillis()

    var time:Long = System.currentTimeMillis()
    var blinkscore = true

    val updateInterval = 250 // Update interval in milliseconds
    var lastUpdateTime = timeinit
    while (gameover){
        while (time - timeinit <= 3000) {
            time = System.currentTimeMillis()
            if (time - lastUpdateTime >= updateInterval) {
                if (blinkscore) {
                    ScoreDisplay.off(true)//Desliga o score display
                    TUI.escrita(" "," ") //"Desliga o LCD"
                } else {
                    TUI.escrita("   GAME  OVER   ", "   Score:$kills") //Escreve o texto de final
                    ScoreDisplay.off(false) //Liga o score display
                    ScoreDisplay.setScore(kills) //Com o valor de kills
                }
                blinkscore = !blinkscore //altera o valor da variavel blinkscore para o inverso
                lastUpdateTime = time //Atauliza o valor de lastUpdateTime
            }
        }
        while (Time.getTimeInMillis()-timeinit >= 3000) {
            if (M.active()) { //Se estivermos em manutenção não temos de dar input a nome
                gameover=false
                LCD1 = mutableListOf(" ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ")
                LCD2 = mutableListOf(" ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ")
                TUI.update()
                TUI.clear()
                kills=0
                ScoreDisplay.setScore(kills)
                mainLoop()
                menu()
            } else { //Caso contrário devemos fazê-lo
                gameover = false
                inputPlayerName()
                kills = 0
                ScoreDisplay.setScore(kills)
                break
            }
        }
    }
}
fun menu() {
    var update = false
    var kTemp: String
    var lastTime= System.currentTimeMillis()
    ScoreDisplay.startAnimation() //Começa a animação do Score Display
    while (!start) {
        ScoreDisplay.updateAnimation() //Atualiza a animação do Score Display
        kTemp = TUI.pressed_key().toString()

        if (!M.active()) { //Se não estivermos em manutenção
            if (update) { //E update for true(sairmos de manutenção)
                updateCoinsDisplay(coins) //Escrevemos o menu com o valor de coins atual
                update = false //update a falso pois o último estado não é manutenção
            }

            val currentTime = System.currentTimeMillis()
            if (currentTime - lastTime >= alternancyRate) { //A cada 3 segundos
                switchMenu() //Alterar entre o menu de score ou de coins
                lastTime = currentTime
            }

            coins = Coin_Acceptor.add(coins) //Se o M não estiver ativo aumentamos os coins ao mover o switch a '1'
            if (coinsTemp != coins) { //coinsTemp diferente dos coins antigos pois somámos 2 (garantir que tudo correu bem)
                total_coins++ //Aumentar o total de moedas no ficheiro de statistics em 1
                updateCoinsDisplay(coins) //Reescrever o menu de coins com o novo valor
            }
            coinsTemp = coins //Atualizar os coinsTemp

            if (kTemp == "*" && coins > 0 && !Coin_Acceptor.coinsActive()) {
                initGame(kTemp) //Se o valor de coins for maior que 0 e clicarmos no "*" o jogo inicia
            }
        }

        if (M.active()) { //Se o M estiver ativo
            update = true //Ativamos a flag de update
            TUI.escrita(" On Maintenance ", " *-Count #-ShutD") //Escrevemos o menu de manutenção
            handleMaintenanceMode() //Vamos para a função que manuseia a manutenção
        }
    }
}

fun initGame(kTemp: String){
    switchLine(kTemp)// Desenhar a nave
    switchLine(kTemp)// Voltar à linha de cima
    games++ //Aumentar o número de jogos no ficheiro de statistics
    coins-- //Diminuir em 1 o valor de coins atuais na máquina
    start = true //Colocar a flag de início a 1 para garantir que começou
}

fun showStatistics() {
    TUI.escrita("Games:$games", "Coins:${total_coins}") //Mostrar os valores que estão no ficheiro Statistics
    val timeinit = Time.getTimeInMillis()
    var time : Long = 0
    while (time - timeinit <= 5000) {
        time = Time.getTimeInMillis()
        if (!M.active()){ //Se o M for inativo volta ao Menu
            menu()
        }
        val teclado = TUI.pressed_key()
        when (teclado) {
            '#' -> eraseStats() //Se pressionarmos a tecla "#" colocamos as estatísticas a 0
            ' ' -> Unit
            else -> { //Caso apertemos outra tecla, verificamos se o M estiver ativo e damos break para voltarmos ao mainLoop
                M.active()
                break
            }
        }
    }
    mainLoop() //Ir ao mainLoop que nos vai levar ao menu
}

//Função que escreve o texto do menu inicial de acordo com os coins existentes na máquina
fun updateCoinsDisplay(coins: Int) {
    val cointext = "$$coins"
    TUI.escrita(" Space Invaders", " Game           ".dropLast(cointext.length) + cointext)
    TUI.drawSHIP(1,6)
    TUI.drawAlien(1,9)
    TUI.drawAlien(1,11)
}

fun handleMaintenanceMode() {
    while (M.active()) {
        if (Coin_Acceptor.add(coins) == coins+2){ //Impedir que os coins sejam aumentados quando estamos em Manutenção
            coins = coins
        }
        val tecla = TUI.pressed_key()
        when (tecla) {
            '*' -> showStatistics()
            '#' -> handleShutdown()
            ' ' -> Unit
            else -> {
                switchLine("*") // Desenhar a nave
                switchLine("*") // Voltar à linha de cima
                start = true
                mainLoop()
            }
        }
    }
}

fun handleShutdown() {
    TUI.escrita("    Shutdown   ", "5-Yes Other - No") //Escrita do menu de Shutdown
    val timeinit = Time.getTimeInMillis()
    var time:Long = 0
    while (time-timeinit<=5000) {
        time=Time.getTimeInMillis()
        if (!M.active()){ //Se o M for inativo voltar ao menu
            menu()
        }
        val decision = TUI.pressed_key()
        when (decision) {
            '5' -> {
                Statistics.saveToFile(games, total_coins) //Se clicarmos no 5 desligamos a máquina e guardamos os jogos e coins inseridos no Statistics
                TUI.off(true)
                ScoreDisplay.off(true)
                exitProcess(0)
            }
            ' ', '#' -> Unit //Não fazemos nada
            else -> mainLoop() //Vamos ao mainLoop entrar no menu
        }
    }
    mainLoop()
}

fun eraseStats() {
    TUI.escrita("Clear Counters?", " 5-Yes Other-No") //Escrita do menu de clear
    val timeinit = Time.getTimeInMillis()
    var time:Long = 0

    while (time-timeinit<=5000) {
        val key = TUI.pressed_key()
        when (key) {
            '5' -> {
                Statistics.eraseStats() //Se clicar-mos no 5 apagamos as Estatísticas
                Statistics.readAndKeep() //E efetuamos a leitura para termos os counters a 0,0
                menu() //Voltamos ao menu para voltar ao menu de manutenção
            }
            ' ' -> Unit
            else -> menu()
        }
        time=Time.getTimeInMillis()
    }
    mainLoop()
}

fun formatScoresCorrectly():String{ //Função que retorna a quantidade de espaços correta de acordo com o tamanho do nome e do número de kills
    var numberOfSpaces = 16
    numberOfSpaces = numberOfSpaces - "${counterMenu+1}-${Scores.board[counterMenu].second}".length - "${Scores.board[counterMenu].first}".length
    return " ".repeat(numberOfSpaces)
}
fun switchMenu() {//Função que altera o menu que está a ser apresentado
    if (countIteration % 2 == 0){ //Caso estejamos numa iteração par, mostramos o número de coins
        updateCoinsDisplay(coins)
    }
    else { //Caso contrário, demonstramos o valor do counter + 1 pois o counter é iniciado a 0, seguido do nome e por fim o score
        TUI.escrita(" Space Invaders ", "${counterMenu+1}-${Scores.board[counterMenu].second}" +formatScoresCorrectly() + "${Scores.board[counterMenu].first}")
        counterMenu++ //Após a escrita aumentamos o counter para a próxima iteração
    }
    countIteration++ //Aumentamos a iteração para mudarmos entre ser par ou ímpar
    if (counterMenu >= Scores.board.size) counterMenu = 0 //Se o valor do counter for superior ao tamanho de board ele regressa a 0
}
fun inputPlayerName() { //Função que manuseia a forma como o nome do jogador é implementado

    LCD1 = mutableListOf(" ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ")
    TUI.escrita("Name:", "Score:$kills") //Escrevemos o menu inicial iniciando o cursor na coluna seguinte

    var column = 5
    var currentLetterIndex = 0
    TUI.cursor(0, column)

    while (true) {
        val key = TUI.pressed_key()
        when (key) {
            '8' -> if (currentLetterIndex > 0) currentLetterIndex-- //Diminui o index da letra na lista do alfabeto caso seja maior que 0
            '2' -> if (currentLetterIndex < Scores.alphabet.size - 1) currentLetterIndex++ //Aumenta o index da letra caso esta seja menor que o máximo
            '6' -> if (column < 12) column++ //Aumenta a coluna onde estamos a escrever
            '4' -> if (column > 5) column-- //Diminui a coluna onde estamos a escrever
            '5' -> {
                Scores.playerName = LCD1.subList(5, LCD1.indexOfLast { it != " " } + 1).joinToString("")
                break
            }
        }
        TUI.writeChar(Scores.alphabet[currentLetterIndex]) //Escrevemos o Char correspondente ao index atual
        TUI.cursor(0, column)
        LCD1[column] = Scores.alphabet[currentLetterIndex].toString()

    }
    Scores.updateLeaderboard()
}

fun resetGame(){
    TUI.clear()
    gameover = false
    linha = 0
    LCD1 = mutableListOf(" ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ")
    LCD2 = mutableListOf(" ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ")
    start = false
}
/*Código feito a ouvir:
    Katy Perry no seu prime
 */
