object KBD {
    const val KVAL_MASK = 0x10
    const val KACK_MASK = 10000000
    const val DATA_MASK = 0x0F
    const val NONE = ' '
// Inicia a classe

    fun init() {
        HAL.clrBits(KACK_MASK) //Garantir que o Kack é 0 para não termos key's a serem acknowledged na inicialização
    }

    // Retorna de imediato a tecla premida ou NONE se não há tecla premida.
    fun getKey(): Char {

        if (HAL.isBit(KVAL_MASK)) {
            val Read_Input = HAL.readBits(DATA_MASK) //data
            var Key = when (Read_Input) {
                0b0000 -> '1'
                0b0100 -> '2'
                0b1000 -> '3'
                0b0001 -> '4'
                0b0101 -> '5'
                0b1001 -> '6'
                0b0010 -> '7'
                0b0110 -> '8'
                0b1010 -> '9'
                0b0111 -> '0'
                0b1011 -> '#'
                0b0011 -> '*'
                else -> NONE
            }

            HAL.setBits(KACK_MASK) //Se houve input, temos de dar ack
            while(HAL.isBit(KVAL_MASK)); //Esperamos que o Kval vá abaixo
            HAL.clrBits(KACK_MASK)


            return Key
        }
        return NONE
    }

    // Retorna a tecla premida, caso ocorra antes do ‘timeout’ (representado em milissegundos), ou NONE caso contrário.
    fun waitKey(timeout: Long): Char {
        val init = System.currentTimeMillis()


        while (System.currentTimeMillis() < init + timeout) {
            val Key = getKey()
            if(Key != NONE)
                return Key
        }
        return NONE
    }
}

fun main() {
    KBD.init()
    while (true) {
        var k = KBD.waitKey(10000)
        if(k != KBD.NONE)
            println(k)
    }
}
/*Código feito ao som de:
    Tik Tok by Kesha
 */