TPE3-SIA

Algoritmos geneticos

%Forma de invocación
%
%[minimo, mejor_individuo] = genetical(serie, max_generations, cantidad_individuos, gap, mp, cp, criterio_seleccion,
%                                        criterio_reemplazo, tipo_apareo, metodoReemplazo, error, error_estructura,
%                                        error_contenido)
%
%* serie : Serie a predecir, propuestas por la catedra en el TP anterior.
%* max_generations : Cantidad máxima de generaciones a correr 
%* cantidad_individuos : Cantidad de Individuos que van a conformar la poblacion
%* gap : Brecha Generacional
%* mp :  Probabilidad de Mutuacion
%* cp :  Probabilidad de CrossOver
%* criterio_seleccion : Identifica al criterio de seleccion a utilizar
%* criterio_reemplazo : Identifica al criterio de reemplazo a utilizar
%* tipo_apareo : Metodo de Apareo
%* tipo_reemplazo : Algoritmo de Reemplazo visto en clase
%* error : Cota de corte por error.
%* error : Cota de corte por error.
%* criterio_estructura: 1 si se usa el criterio de corte por estructura, 0 si no. 
%* criterio_contenido: 1 si se usa el criterio de corte por contenido, 0 si no. 

Criterios de Seleccion y Reemplazo
    
    * 1 : Elite
    * 2 : Ruleta
    * 3 : Boltzmann
    * 4 : Torneo
    * 5 : Mixto

Tipo de Apareo

    * 1 : Anular
    * 2 : Cup
    * 3 : One-Point
    * 4 : Two-Points

Metodos de Reemplazo

    * 1 : Algoritmo de Reemplazo 1
    * 2 : Algoritmo de Reemplazo 2
    * 3 : Algoritmo de Reemplazo 3

Adicionalmente como parametros fijos se van a encontrar:

    * P = [3 5 1] que fue la mejor estructura para el TP anterior.
    * beta = 0.3
    * pbbp = 0.01 Probabilidad de hacer BackPropagation sobre un individuo
    * funcion de transferencia tanh

Ejemplos de Ejecución

[minimo, mejor_individuo] = genetical(x, 100, 5, 0.9, 0.0025, 0.75, 1, 2, 3, 1, 0.001, 0, 0)

Ejecuta la serie x con 100 generaciones maximo, 5 individuos, 0.9 es la brecha generacional, 
0.0025 probabilidad de mutar, 0.75 probabildad de crossover, Elite para seleccion,
Ruleta para el reemplazo, tipo de apaero one-point, reemplazo 1 y un error de corte
de 0.001.

/// *** ///

[minimo, mejor_individuo] = genetical(x, 20, 10, 0.95, 0.01, 0.60, 2, 3, 2, 3, 0.003, 0, 0)

Ejecuta la serie x con 20 generaciones maximo, 10 individuos, 0.95 es la brecha generacional, 
0.01 probabilidad de mutar, 0.60 probabildad de crossover, Ruleta para seleccion,
Boltzmann para el reemplazo, tipo de apaero Anular, metodo de reemplazo 2 y un error de corte
de 0.003

/// *** ///

[minimo, mejor_individuo] = genetical(x, 200, 50, 0.8, 0.005, 0.9, 4, 2, 2, 3, 0.10, 0, 0)

Ejecuta la serie x con 200 generaciones maximo, 50 individuos, 0.8 es la brecha generacional, 
0.005 probabilidad de mutar, 0.9 probabildad de crossover, Torneo para seleccion,
Ruleta para el reemplazo, tipo de apaero cup, metodo de reemplazo 3 y un error de corte
de 0.10



