import isel.leic.UsbPort

fun main(){
    HAL.init()
}

object HAL { // Virtualiza o acesso ao sistema UsbPort

    var Output = 0


    // Inicia a classe
    fun init() {
        clrBits(0xFF)
    }


    // Retorna true se o bit tiver o valor lógico ‘1’
    fun isBit(mask: Int): Boolean {
        return (readBits(mask) == mask)
    }
    // Retorna os valores dos bits representados por mask presentes no UsbPort
    fun readBits(mask: Int): Int {
        return UsbPort.read().and(mask)
    }
    // Escreve nos bits representados por mask os valores dos bits correspondentes em value
    fun writeBits(mask: Int, value: Int) {
        Output = (value.and(mask)).or(Output.and(mask.inv()))
            UsbPort.write(Output)
    }

    // Coloca os bits representados por mask no valor lógico ‘1’
    fun setBits(mask: Int) {
        Output = Output.or(mask)
        UsbPort.write(Output)
    }

    // Coloca os bits representados por mask no valor lógico ‘0’
    fun clrBits(mask: Int) {
        Output = Output.and(mask.inv())
        UsbPort.write(Output)
    }
}
/*Código feito ao som de:
    goosebumps by Travis Scott
 */