(define (problem problem1)

    (:domain balancer)

    (:objects
        t1 t2 t3 t4 t5 t6 - task
        q1 - queue
        w1 - worker
        h1 h2 - thread
    )

    (:init
        
        ; tareas en la cola 1
        (in t1 q1) (in t2 q1) (in t3 q1) (in t4 q1) (in t5 q1) (in t6 q1)

        ; cabeza de la cola 1
        (head t1 q1)

        ; final de la cola 1
        (tail t6 q1)

        ; sucesores
        (next t1 t2 q1) (next t2 t3 q1) (next t3 t4 q1) (next t4 t5 q1) (next t5 t6 q1)


        ; tiempos ejecución estimados de cada tarea
        (= (estimated-execution-time t1) 226)
        (= (estimated-execution-time t2) 94)
        (= (estimated-execution-time t3) 473)
        (= (estimated-execution-time t4) 217)
        (= (estimated-execution-time t5) 105)
        (= (estimated-execution-time t6) 455)

        ; tamaño en bytes del archivo en el que se especifica la tarea
        (= (file-size t1) 52968)
        (= (file-size t2) 29033)
        (= (file-size t3) 76771)
        (= (file-size t4) 37987)
        (= (file-size t5) 16972)
        (= (file-size t6) 76087)

        ; velocidad de trasferencia del trabajador
        (= (transfer-rate w1) 800)

        ; tiempo de ejecución total de cada hilo
        (= (total-execution-time h1) 0)
        (= (total-execution-time h2) 0)
        
        ; el trabajador 1 trabaja sobre la cola 1
        (assigned w1 q1)

        ; todos los servidores está libre
        (idle h1) (idle h2)

        ; el trabajador esta libre
        (idle w1)

        ; el trabajador esta conectado con el servidores
        (online w1 h1) (online w1 h2)
    )

    (:goal
        (and
            ; todas las tareas sean ejecutadas
            (task-executed t1)
            (task-executed t2)
            (task-executed t3)
            (task-executed t4)
            (task-executed t5)
            (task-executed t6)
        )
    )

    (:metric minimize
        ; minimizar el tiempo total de ejecución
        ; de cada servidor
        (+
            (total-execution-time h1)
            (total-execution-time h2)
        )
    )
)