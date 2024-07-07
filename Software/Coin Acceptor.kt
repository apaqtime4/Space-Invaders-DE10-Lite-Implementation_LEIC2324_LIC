object Coin_Acceptor{
    const val COIN_MASK = 0b0100_0000
    var last_state = false
    fun add(coins:Int):Int{
        var coinsAvailable=coins
        if (HAL.isBit(COIN_MASK) && (last_state==false)){
            coinsAvailable+=2 //Meter 2 coins na máquina
            last_state = true //Último estado é '1'
        } else if (!HAL.isBit(COIN_MASK) && last_state){
            HAL.clrBits(COIN_MASK) //Passa a máscara a 0 quando o valor não for bit(switch a 0)
            last_state=false //Último estado é '0'
        }
        return coinsAvailable
    }

    fun coinsActive():Boolean{
       return HAL.isBit(COIN_MASK)
    }
}
fun main(){
    HAL.init()
    Coin_Acceptor.add(2)
}
/*Código feito ao som de:
    Timber by Pitbull
 */