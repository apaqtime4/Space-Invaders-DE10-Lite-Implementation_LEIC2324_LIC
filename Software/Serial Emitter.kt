object SerialEmitter {
    private const val LCD_MASK = 0x01 //É o bit 0 (0001)
    private const val SSC_MASK = 0x02 //É o bit 1 (0010)
    private const val SDX_MASK = 0x08 //É o bit 3 (1000)
    private const val CLK_REG_MASK = 0x10 //É o bit 4 (0001 0000)
    private const val CLEAR_MASK = 0x1F // É os bits todos antes do 32(5) ou seja (0001 1111)

    // Envia tramas para os diferentes módulos Serial Receiver.
    enum class Destination { LCD, SCORE }

    // Inicia a classe
    fun init() {
        HAL.clrBits(CLEAR_MASK)
        HAL.setBits(LCD_MASK)
        HAL.setBits(SSC_MASK)
    }

    //  if LCD size = 10
    //  if Score size = 8

    // Envia uma trama para o SerialReceiver identificado o destino em addr,os bits de dados em ‘data’ e em size o número de bits a enviar.
    // Vai primeiro o cmd e depois a data
    fun send(addr: Destination, data: Int, size: Int) {
        var dataShifted = data
        var ParityBit = 0
        var counter = 0

        if (addr == Destination.LCD) {
            HAL.clrBits(LCD_MASK) //Entra negado no hardware
        } else if (addr == Destination.SCORE) {
            HAL.clrBits(SSC_MASK) //Entra negado no hardware
        }


        dataShifted = data.shl(3) //Mover a data 3 vezes pois enviamos pelo bit do SDX
        for (i in 0 until size - 1) {
            HAL.clrBits(CLK_REG_MASK) //Efetuar o clock
            HAL.writeBits(SDX_MASK, dataShifted) //Escrever o valor de dataShifted que está no valor de SDX_MASK
            if (dataShifted.shr(3) % 2 == 1) {
                counter++
            }
            dataShifted = dataShifted.shr(1) //Mover a data um bit para escrevermos o bit seguinte
            HAL.setBits(CLK_REG_MASK) //Finalizar o clock
        }

        if (counter % 2 == 1) {
            ParityBit = 1 //Se o resto de divisão do counter
        }
        HAL.clrBits(CLK_REG_MASK) //Iniciar o clock
        HAL.writeBits(SDX_MASK, ParityBit.shl(3)) //Escrever o bit de paridade e o shift é para estar em SDX
        HAL.setBits(CLK_REG_MASK) //Finalizar o clock
        HAL.setBits(LCD_MASK) //Colocar o bit do LCD
        HAL.setBits(SSC_MASK) //Colocar o bit do SSC
    }
}

fun main(){

    SerialEmitter.init()
    SerialEmitter.send(SerialEmitter.Destination.SCORE, 20,8)
}
/*Código feito ao som de:
    HIGHEST IN THE ROOM by Travis Scott
 */