const val M_MASK = 0b10000000

object M {
    fun active(): Boolean{
        return HAL.isBit(M_MASK)
    }
}

fun main() {
    HAL.init()
    println(M.active())
    HAL.writeBits(M_MASK, 0xFF)
    println(M.active())
}
/*Código feito ao som de:
    Wannabe by Spice Girls
 */