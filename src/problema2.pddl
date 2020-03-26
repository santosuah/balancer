(define (problem problem2)

    (:domain balancer)

    (:objects
        t1 t2 t3 t4 t5 t6 t7 t8 - task
        t9 t10 t11 t12 t13 t14 t15 t16 - task
        t17 t18 t19 t20 t21 t22 t23 t24 - task
        q1 q2 q3 - queue
        w1 - worker
        h1 h2 h3 h4 h5 h6 - thread
    )

    (:init
        ; ------------------------------------------ COLA 1 ------------------------------------------
        ; tareas en la cola 1
        (in t1 q1) (in t2 q1) (in t3 q1) (in t4 q1) (in t5 q1) (in t6 q1) (in t7 q1) (in t8 q1)

        ; cabeza de la cola 1
        (head t1 q1)

        ; final de la cola 1
        (tail t8 q1)

        ; sucesores
        (next t1 t2 q1) (next t2 t3 q1) (next t3 t4 q1) (next t4 t5 q1) (next t5 t6 q1)
        (next t6 t7 q1) (next t7 t8 q1)

        ; ------------------------------------------ COLA 2 ------------------------------------------
        ; tareas en la cola 2
        (in t9 q2) (in t10 q2) (in t11 q2) (in t12 q2) (in t13 q2) (in t14 q2) (in t15 q2) (in t16 q2)

        ; cabeza de la cola 2
        (head t9 q2)

        ; final de la cola 2
        (tail t16 q2)

        ; sucesores
        (next t9 t10 q2) (next t10 t11 q2) (next t11 t12 q2) (next t12 t13 q2) (next t13 t14 q2)
        (next t14 t15 q2) (next t15 t16 q2)

        ; ------------------------------------------ COLA 3 ------------------------------------------
        ; tareas en la cola 3
        (in t17 q3) (in t18 q3) (in t19 q3) (in t20 q3) (in t21 q3) (in t22 q3) (in t23 q3) (in t24 q3)

        ; cabeza de la cola 3
        (head t17 q3)

        ; final de la cola 3
        (tail t24 q3)

        ; sucesores
        (next t17 t18 q3) (next t18 t19 q3) (next t19 t20 q3) (next t20 t21 q3) (next t21 t22 q3)
        (next t22 t23 q3) (next t23 t24 q3)


        ; tiempos ejecución estimados de cada tarea
        (= (estimated-execution-time t1) 105)
        (= (estimated-execution-time t2) 94)
        (= (estimated-execution-time t3) 473)
        (= (estimated-execution-time t4) 217)
        (= (estimated-execution-time t5) 226)
        (= (estimated-execution-time t6) 455)
        (= (estimated-execution-time t7) 333)
        (= (estimated-execution-time t8) 120)
        (= (estimated-execution-time t9) 138)
        (= (estimated-execution-time t10) 337)
        (= (estimated-execution-time t11) 237)
        (= (estimated-execution-time t12) 59)
        (= (estimated-execution-time t13) 281)
        (= (estimated-execution-time t14) 470)
        (= (estimated-execution-time t15) 199)
        (= (estimated-execution-time t16) 43)
        (= (estimated-execution-time t17) 74)
        (= (estimated-execution-time t18) 341)
        (= (estimated-execution-time t19) 288)
        (= (estimated-execution-time t20) 95)
        (= (estimated-execution-time t21) 200)
        (= (estimated-execution-time t22) 62)
        (= (estimated-execution-time t23) 345)
        (= (estimated-execution-time t24) 383)

        ; tamaño en bytes del archivo en el que se especifica la tarea
        (= (file-size t1) 37987)
        (= (file-size t2) 16972)
        (= (file-size t3) 76771)
        (= (file-size t4) 52968)
        (= (file-size t5) 29033)
        (= (file-size t6) 76087)
        (= (file-size t7) 71929)
        (= (file-size t8) 95655)
        (= (file-size t9) 77148)
        (= (file-size t10) 53496)
        (= (file-size t11) 68423)
        (= (file-size t12) 69551)
        (= (file-size t13) 36937)
        (= (file-size t14) 23452)
        (= (file-size t15) 95893)
        (= (file-size t16) 91941)
        (= (file-size t17) 26162)
        (= (file-size t18) 37263)
        (= (file-size t19) 25239)
        (= (file-size t20) 44174)
        (= (file-size t21) 18896)
        (= (file-size t22) 36135)
        (= (file-size t23) 60959)
        (= (file-size t24) 62272)

        ; velocidad de trasferencia del trabajador
        (= (transfer-rate w1) 800)

        ; tiempo de ejecución total de cada hilo
        (= (total-execution-time h1) 0)
        (= (total-execution-time h2) 0)
        (= (total-execution-time h3) 0)
        (= (total-execution-time h4) 0)
        (= (total-execution-time h5) 0)
        (= (total-execution-time h6) 0)
        
        ; el trabajador 1 trabaja sobre la cola 1
        (assigned w1 q1) (assigned w1 q2) (assigned w1 q3)

        ; todos los servidores están ociosos
        (idle h1) (idle h2) (idle h3) (idle h4) (idle h5) (idle h6)

        ; el trabajador esta ocioso
        (idle w1)

        ; el trabajador esta conectado con el servidores
        (online w1 h1) (online w1 h2) (online w1 h3) (online w1 h4) (online w1 h5) (online w1 h6)
    )

    (:goal
        (and
            (task-executed t1)
            (task-executed t2)
            (task-executed t3)
            (task-executed t4)
            (task-executed t5)
            (task-executed t6)
            (task-executed t7)
            (task-executed t8)
            (task-executed t9)
            (task-executed t10)
            (task-executed t11)
            (task-executed t12)
            (task-executed t13)
            (task-executed t14)
            (task-executed t15)
            (task-executed t16)
            (task-executed t17)
            (task-executed t18)
            (task-executed t19)
            (task-executed t20)
            (task-executed t21)
            (task-executed t22)
            (task-executed t23)
            (task-executed t24)
        )
    )

    (:metric minimize 
        (+
            (total-execution-time h1)
            (total-execution-time h2)
            (total-execution-time h3)
            (total-execution-time h4)
            (total-execution-time h5)
            (total-execution-time h6)
        )
    )
)