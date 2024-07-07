# Space Invaders - DE10-Lite Implementation

## Descrição do Projeto

Este projeto consiste na implementação do jogo clássico Space Invaders utilizando uma abordagem que integra componentes de Hardware e Software. O jogo foi desenvolvido e implementado na placa de expansão de placa DE10-Lite, utilizando a mesma para a visualização do jogo e utilização do teclado matricial da mesma.

## Componentes do Projeto

### Hardware

- **Placa DE10-Lite**: Utilizada para implementação do projeto.
- **Placa de expansão da placa DE10-Lite**: Utilizada para termos recurso a um LCD(Liquid Cristal Display) e ao teclado matricial.
- **Linguagem VHDL/Verilog**: Utilizada para a descrição dos componentes de hardware do jogo.

### Software

- **Lógica do Jogo**: Inclui movimentação do jogador, disparos, movimentação dos invasores, colisões e sistema de pontuação.
- **Controlo dos componentes**: Inclui o controlo do funcionamento das diferentes componentes de acordo com o hardware e as respetivas datasheets.

## Funcionalidades

- **Movimentação do Jogador**: Controlada através do teclado matricial 4x3 de expansão para a placa DE10-Lite.
- **Disparos**: O jogador pode disparar para destruir os invasores.
- **Invasores**: Movimentação aleatória, podendo ser ou na linha de baixo ou de cima, movendo-se em direção ao jogador.
- **Pontuação**: Sistema de pontuação baseado nos invasores destruídos.

## Estrutura do Projeto

Space Invaders
├── hardware/
│   ├── vhdl/
│   │   ├── Space_Invaders
│   │   │   ├── Coin_Acceptor
│   │   │   │   └── Coin_Acceptor
│   │   │   ├── KeyBoardReader
│   │   │   │   ├── Key_Decoder
│   │   │   │   │   ├── Key_Control
│   │   │   │   │   │   └── Key_Control
│   │   │   │   │   ├── Key_Scan
│   │   │   │   │   │   ├── CounterUP
│   │   │   │   │   │   │   ├── Adder
│   │   │   │   │   │   │   ├── clkDIV
│   │   │   │   │   │   │   ├── counterUP
│   │   │   │   │   │   │   ├── FFD
│   │   │   │   │   │   │   ├── FULLADDER
│   │   │   │   │   │   └────── Regis
│   │   │   │   │   │   ├── Decoder
│   │   │   │   │   │   ├── MUX4
│   │   │   │   │   │   └── Key_Scan
│   │   │   │   └── Key_Decoder
│   │   │   │   ├── Output Buffer
│   │   │   │   │   ├── Output_Buffer
│   │   │   │   │   │   ├── Regis
│   │   │   │   │   └────── Buffer_Control
│   │   │   │   ├── Ring_Buffer
│   │   │   │   │   ├── Ring_Buffer
│   │   │   │   │   │   ├── Ring_Buffer_Control
│   │   │   │   │   │   ├── RAM
│   │   │   │   │   │   ├── MAC
│   │   │   │   │   │   │   ├── MAC
│   │   │   │   │   │   │   ├── MUX_3BITS
│   │   │   │   │   │   │   ├── Counter_3bits
└─────────────── KeyboardReader
│   │   │   ├── Score Display
│   │   │   │   ├── scoreDisplay
│   │   │   │   │   ├── dec_3_8
│   │   │   │   │   ├── dec2hex
│   │   │   │   │   ├── reg_4bit
└────────────── Score Display
│   │   │   ├── SLCDC
│   │   │   │   ├── LCD_Dispatcher
│   │   │   │   │   ├── LCD_Dispatcher
│   │   │   │   ├── Serial Receiver SLCDC
│   │   │   │   │   ├── Counter
│   │   │   │   │   ├── ShiftRegister9
│   │   │   │   │   ├── Serial_Control
│   │   │   │   │   ├── Parity_Check
│   │   │   │   │   ├── MUX.vhd
│   │   │   │   │   ├── Serial_Receiver_SLCDC
│   │   │   │   │   ├── Comparador_LCD
└────────────── SLCDC
│   │   │   ├── SSC
│   │   │   │   ├── Score_Dispatcher
│   │   │   │   │   ├── Score_Dispatcher
│   │   │   │   ├── Serial Receiver SSC
│   │   │   │   │   ├── ShiftRegister7
│   │   │   │   │   ├── Serial_Receiver_SSC
│   │   │   │   │   ├── comparador_SSC
└────────────── SSC
├── software/
│   ├── Coin Acceptor
│   ├── FileAccess
│   ├── HAL
│   ├── KBD
│   ├── LCD
│   ├── M
│   ├── Score Display
│   ├── Scores
│   ├── Serial Emitter
│   ├── Statistics
│   ├── TUI
└── main/
│   ├── Game_Mode
├── documentação/
│   ├── Enunciado_do_projeto
│   ├── moduloLCDontroller_LEIC21D-G9
│   ├── moduloSDController_LEIC21D-G9
│   ├── moduloKeyboardReader_LEIC21D-G9
│   └── projectDocumentation_LEIC21D-G9

## Como Executar

1. **Configurar a Placa DE10-Lite**:
    - Conectar a placa ao computador.
    - Configurar o ficheiro `Pinos.qsf` localizado em `LIC_Grupo-9/Hardware/Pinos.qsf`

2. **Compilar o Projeto**:
    - Utilizar o Quartus Prime para compilar o projeto.

3. **Carregar o Programa na FPGA**:
    - Após a compilação, carregar o programa na FPGA da DE10-Lite.

4. **Executar o Jogo**:
    - Iniciar a função main do ficheiro `Game_Mode.kt` localizado em `LIC_Grupo-9/Software/USBport/src/Game_Mode.kt`
    - Reiniciar a placa para iniciar o jogo.

## Conclusões

Este projeto foi desenvolvido pelos alunos Duarte Patrício (@apaqtime4), Jorge Albino (@Rafaellix) e Lourenço Teles (@LourencoTeles8) com apoio dos professores e tendo atingido a classificação final de 15 na UC de LIC(Laboratório de Informática e Computadores), cadeira de 2º semestre do curso de LEIC no ISEL.
