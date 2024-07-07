object LCD {
    private const val CLK_REG_MASK = 0x10 // É o bit (0001 0000)
    private const val E_MASK = 0x20 // É o bit 5(0010 0000)
    private const val RS_MASK = 0x40 // É o bit 6 (0100 0000)
    private const val ON_MASK = 0x0C // São os bits 2 e 3(1100)
    private const val OFF_MASK = 0x08 // É o bit 3 (1000)

    private val nave = byteArrayOf( //pixel art
        0b11110,
        0b11000,
        0b11100,
        0b11111,
        0b11100,
        0b11000,
        0b11110,
        0b00000
    )
    private val invader = byteArrayOf( //pixel art
        0b11111,
        0b11111,
        0b10101,
        0b11111,
        0b11111,
        0b10001,
        0b10001,
        0b00000
    )

    // Escreve um byte de comando/dados no LCD em paralelo
    private fun writeByteParallel(rs: Boolean, data: Int) {
        if (rs) {
            HAL.setBits(RS_MASK)
        } else {
            HAL.clrBits(RS_MASK)
        }
        val shift_right = data.shr(4)

        HAL.writeBits(15, shift_right)
        HAL.setBits(CLK_REG_MASK)
        HAL.clrBits(CLK_REG_MASK)

        HAL.writeBits(15, data)
        HAL.setBits(CLK_REG_MASK)
        HAL.clrBits(CLK_REG_MASK)
        HAL.setBits(E_MASK)
        HAL.clrBits(E_MASK)
    }

    // Escreve um byte de comando/dados no LCD em série
    private fun writeByteSerial(rs: Boolean, data: Int) {
        var not_data = data
        if (rs) {
            not_data = data.shl(1) + 1
        } else {
            not_data = data.shl(1)
        }

        SerialEmitter.send(SerialEmitter.Destination.LCD, not_data, 10)
    }

    // Escreve um byte de comando/dados no LCD
    private fun writeByte(rs: Boolean, data: Int) {
        writeByteSerial(rs, data)
    }

    // Escreve um comando no LCD
    private fun writeCMD(data: Int) {
        writeByte(false, data)
    }

    // Escreve um dado no LCD
    private fun writeDATA(data: Int) {
        writeByte(true, data)
    }

    // Escreve um caráter na posição corrente.
    fun writeChar(c: Char) {
        writeDATA(c.code)
    }

    // Escreve uma string na posição corrente.
    fun writeString(text: String) {
        for (i in text) {
            writeChar(i)
        }
    }

    // Envia comando para posicionar cursor (‘line’:0..LINES-1 , ‘column’:0..COLS-1)
    fun cursor(line: Int, column: Int) {
        val writer = 128
        writeCMD((line * 0x40) + column + writer)
    }

    // Envia comando para limpar o ecrã e posicionar o cursor em (0,0)
    fun clear() {
        writeCMD(0x01)
    }

    // Função usada para definir um caracter especial e guarda-lo na CGRAM
    fun createCustomChar(location: Int, charmap: ByteArray) {
        writeCMD(0x40 or (location shl 3)) // Definir o endereço da CGRAM (3 shifts para multiplica-lo por 8)

        for (i in charmap.indices) {
            writeDATA(charmap[i].toInt()) //envio de dados sobre o caracter especial
        }
    }
    fun createAllCostumChars(){
        createCustomChar(0, nave)

        createCustomChar(1, invader)
    }
    // Desliga o LCD quando off = true
    fun off(off:Boolean){
        if (off){
            writeCMD(OFF_MASK)
        }
        else
            writeCMD(ON_MASK)
    }

    // Desenha a nave no LCD
    fun drawShip(line: Int, column: Int) {
        cursor(line, column) //Aplica o cursor na linha e coluna de input
        writeDATA(0) // Display do caracter guardado na CGram na posição 0
    }
    fun drawInvader(line:Int, column: Int){
        cursor(line, column) //Aplica o cursor na linha e coluna de input
        writeDATA(1) // Display do caracter guardado na CGram na posição 1
    }

    fun init() {
        Thread.sleep(20)

        writeCMD(48)
        Thread.sleep(5)

        writeCMD(48)
        Thread.sleep(1)

        writeCMD(48)
        writeCMD(56)
        writeCMD(8)
        writeCMD(1)
        writeCMD(6)
        writeCMD(15)
    }
}

fun main(){
    HAL.init()
    SerialEmitter.init()
    LCD.init()

    //Testar o LCD
    LCD.cursor(0,0)
    LCD.writeString("Hello World!")
    LCD.cursor(1,0)
    LCD.writeString("123456789")
    Thread.sleep(1000)
    LCD.clear()
    LCD.createAllCostumChars()
    LCD.drawShip(0,0)
    LCD.drawInvader(0,1)
}

/*Código feito ao som de:
    Snowfall by Oneheart
 */