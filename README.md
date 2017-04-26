# CrossMe Color Solver

## Sinopsis

Este proyecto implementa una herramienta escrita en *Prolog* que permite al usuario resolver tableros del juego CrossMe Color.

## Interfaz de usuario

Los siguientes predicados son provistos para la interacción con el programa por parte del usuario:

### Solve

```prolog
?- solve(Rows, Columns, Board).
```

Triunfa si `Board` es una solución para el tablero descrito por `Rows` y `Columns`. El formato de `Board` es una lista de listas de colores, cada una describiendo una fila de la solución. `Rows` y `Columns` son asimismo listas de listas, cada una representando una fila o columna respectivamente. El formato de los elementos de las filas y columnas es `(Color, Count)`, donde `Color` es el color de un grupo y `Count` su número de casillas. El orden en que aparecen las listas y su contenido es de arriba a abajo (columnas) y de izquierda a derecha (filas).

### Print board

```prolog
?- print_board(Board).
```

Utilidad para mostrar en pantalla una representación gráfica de la solución `Board`, similar a cómo se vería la misma en la interfaz gráfica del juego. Para el uso correcto de esta funcionalidad se sugiere emplear en la descripción del tablero a solucionar, colores soportados por el predicado [ansi_format](http://www.swi-prolog.org/pldoc/man?predicate=ansi_format/3) de prolog.

## Ejemplo de uso

A continuación se muestra el comando a emplear para hallar -y dibujar en pantalla- la solución del primer tablero del tutorial del juego:

```prolog
?- 
solve(
        [
            [(blue, 5)]
        ],
        [
            [(blue, 1)], [(blue, 1)], [(blue, 1)], [(blue, 1)], [(blue, 1)]
        ],
        Output
), print_board(Output).
```
Se proveen asimismo, en la carpeta `boards`, los objetivos para solucionar los primeros 19 tableros del primer nivel de dificulad del juego.