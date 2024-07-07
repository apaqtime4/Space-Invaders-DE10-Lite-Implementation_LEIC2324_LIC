object TUI {
    //Escreve qualquer coisa, modo de manutenção feito à parte porque é usado mais vezes
    fun escrita(texto1: String, texto2: String) {
        LCD.clear()

        LCD.cursor(0, 0)
        LCD.writeString(texto1)

        LCD.cursor(1, 0)
        LCD.writeString(texto2)
    }

    //Limpa o LCD, somente existe para a ligação
    fun clear() {
        LCD.clear()
    }
    //Ligação...
    fun pressed_key(): Char = KBD.waitKey(10)

    //Se o valor na lista for > ele substitui por uma nave
    fun update() {
        LCD.cursor(0, 0)
        for (i in LCD1) {
            if (i == ">"){
                drawSHIP(0,1)
                continue
            }
            LCD.writeString(i)
        }

        LCD.cursor(1, 0)
        for (i in LCD2) {
            if (i == ">"){
                drawSHIP(1,1)
                continue
            }
            LCD.writeString(i)
        }
    }

    //Define a posição do cursor no LCD
    fun cursor(line:Int,column:Int){
        LCD.cursor(line,column)
    }

    //Escrever só um Char no LCD
    fun writeChar(c:Char){
        LCD.writeChar(c)
    }

    //Função que desenha a nave no jogo
    fun drawSHIP(line: Int, column: Int){
        LCD.drawShip(line, column)
    }
    //Função que desenha os aliens no jogo
    fun drawAlien(line:Int, column:Int){
        LCD.drawInvader(line,column)
    }

    //Funçã que liga e desliga o TUI
    fun off(mask:Boolean){
        if (mask){
            LCD.off(mask)
        }
        else {
            LCD.off(mask)
        }
    }
    fun init(){
        KBD.init()
        println("Load KBD completed")
        LCD.init()
        println("Load LCD completed")
        ScoreDisplay.off(false)
        LCD.off(false)
        LCD.createAllCostumChars()
    }
}

fun main(){
    LCD.init()
    TUI.drawSHIP(1,1)
    TUI.drawAlien(1, 5)
}
/* Código feito ao som de:
    From The Start by Laufey
 */