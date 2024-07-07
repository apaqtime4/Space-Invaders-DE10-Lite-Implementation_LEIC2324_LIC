import java.io.*

object FileAccess{

    //Efetua a leitura do ficheiro, separando a cada nova linha
    fun readFile(file: String): List<String> {
        val br = BufferedReader(FileReader(file))
        var line = br.readLine()
        val a = emptyList<String>().toMutableList()
        while (line != null) {
            val list = line.split("\n")
            a += list

            line = br.readLine()
        }
        br.close()
        return a
    }

    //Efetuar a atualização do ficheiro de acordo com os dados
    fun updateFile(file:String, list: List<String>){
        val pw = PrintWriter(file)
        for(i in list.indices){
            pw.println(list[i])
        }
        pw.close()
    }
}
/*Código feito ao som de:
    Not Like Us by Kendrick Lamar
 */