object ScoreDisplay { // Controla o mostrador de pontuação.
    private const val OFF_MASK = 0xF //111 cmd 0001 data = 0001 111
    private const val ON_MASK = 0x7 // 111 cmd 0000 data = 0000 111
    private const val UPDATE_MASK = 0x6 // 110 cmd 0000 data = 0000 110
    private const val EMPTY_MASK = 0X78 // 1111 data 000 cmd depois na função somamos + cmd
    private var lastAnimationTime = System.currentTimeMillis() //Tempo da última animação
    private val animationInterval = 500L // 500 milliseconds
    private var animationCounter = 0 //Qual a última animação
    private val segments = arrayOf(0xA, 0xB, 0xC, 0xD, 0xE, 0x1) //lista das animações
    var isAnimating = true // animação do início é true inicialmente
    // Inicia a classe, estabelecendo os valores iniciais.
    fun init(){
        off(true)//desliga
        off(false)//liga
        for (cmd in 5 downTo 0){
            SerialEmitter.send(SerialEmitter.Destination.SCORE,cmd,8)   //enviar o cmd
        }
        SerialEmitter.send(SerialEmitter.Destination.SCORE, UPDATE_MASK, 8) //update para saber que está ligado
    }

    // Envia comando para atualizar o valor do mostrador de pontuação
    fun setScore(value: Int){
        var value_temp=value //Para guardar o valor de entrada
        var divider = 100_000 //6 digitos de Score
        var leadingZero = true //0 à esquerda = true porque nunca começamos com número != 0 à esquerda
        for (cmd in 5 downTo 0) {
            var dividido = (value_temp / divider) * divider //Passar para um int e meter esse mesmo int no resultado
            if (dividido == 0 && leadingZero && divider > 1) {
                SerialEmitter.send(SerialEmitter.Destination.SCORE, EMPTY_MASK + cmd, 8) //Se for 0 à esquerda, apagar
            } else {
                SerialEmitter.send(SerialEmitter.Destination.SCORE, (value_temp / divider).shl(3) + cmd, 8) //Escrever o valor
                leadingZero = false //Não é zero à esquerda
            }
            value_temp %= divider //Remover o número de maior grau
            divider /= 10 //Diminuir o grau do divisor
        }
        SerialEmitter.send(SerialEmitter.Destination.SCORE, UPDATE_MASK, 8)//Para dar update ao score display
    }

    // Envia comando para desativar/ativar a visualização do mostrador de pontuação
    fun off(value: Boolean){
        if(value){
            SerialEmitter.send(SerialEmitter.Destination.SCORE, OFF_MASK, 8)//ligar o off

        }
        else SerialEmitter.send(SerialEmitter.Destination.SCORE, ON_MASK, 8)//não ligar o off
    }

    //Começa a animar novamente
    fun startAnimation() {
        isAnimating = true
    }

    //Para de animar
    fun stopAnimation() {
        isAnimating = false
    }

    // Muda a animação em questão
    fun updateAnimation() {
        if (isAnimating && System.currentTimeMillis() - lastAnimationTime >= animationInterval) {
            lastAnimationTime = System.currentTimeMillis() //Update ao lastAnimationTime
            animationCounter = (animationCounter + 1) % segments.size //O counter de animação = ao resto de divisão pelo tamanho dos segmentos
            displayAlternatingShapes()
        }
    }

    //AlternatingShapes, bastante explicativo, muda as shapes (da animação inicial)
    private fun displayAlternatingShapes() {
        for (i in 0..5) {
            val cmd = (segments[animationCounter].shl(3)) + i //Shift 3 vezes porque é o cmd primeiro
            SerialEmitter.send(SerialEmitter.Destination.SCORE, cmd, 8) //Para definir qual dos displays mandamos, daí serem em sincronia
        }
        SerialEmitter.send(SerialEmitter.Destination.SCORE, UPDATE_MASK, 8)//dar update a todos
    }
}

fun main(){
    SerialEmitter.init()
    ScoreDisplay.init()
    ScoreDisplay.setScore(22222)
    println("22222")
    Thread.sleep(3000)
    ScoreDisplay.off(true)
    println("Desligado")
    Thread.sleep(3000)
    ScoreDisplay.off(false)
    println("ligado")
    //  Teste de envio, não pode ser visto pois não há .simul ainda
}

/*Código feito ao som de:
    Duvet by bôa
 */