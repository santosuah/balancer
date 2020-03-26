(define (domain balancer)

    (:requirements
        :strips
        :typing
        :equality
        :durative-actions
        :fluents
    )

    (:types
        ; tarea
        task

        ; cola de tareas
        queue

        ; hilo del servidor
        thread

        ; trabajador
        worker
    )

    (:predicates
        ; tarea en una cola o en servidor
        (in ?t - task ?qt - (either queue thread))

        ; tarea ejecutada
        (task-executed ?t - task)

        ; servidor/trabajador libre para realizar una tarea
        (idle ?wt - (either worker thread))

        ; servidor en estado de trasferencia de una tarea y antes de ejecutarla
        (transfer-status ?t - thread)

        ; servidor estado de ejecución
        (execution-status ?t - thread)
        
        ; el trabajador está conectado con el servidor
        (online ?w - worker ?t - thread)
        
        ; trabajador tiene asigando una cola
        (assigned ?w - worker ?q - queue)

        ; tarea está en la cabeza de la cola
        (head ?t - task ?q - queue)

        ; final de la cola
        (tail ?t - task ?q - queue)

        ; sucesor de una tarea es otra tarea en la cola
        (next ?t1 ?t2 - task ?q - queue)
    )

    (:functions
        ; tiempo de ejecución estimado de una tarea
        (estimated-execution-time ?t - task)

        ; tamaño en bytes del archivo en el que se especifica la tarea
        (file-size ?t - task)

        ; velocidad de trasferencia
        (transfer-rate ?w - worker)

        ; tiempo de ejecución total de cada hilo de servidor
        (total-execution-time ?t - thread)
    )
    

    ; Asignar una tarea de una cola al hilo del servidor
    (:durative-action send-non-empty-queue-tail
        :parameters (
            ?w - worker
            ?t1 ?t2 - task
            ?q - queue
            ?h - thread
        )
        :duration (= ?duration (/ (file-size ?t1) (transfer-rate ?w)))
        :condition (and

            ; trabajador tiene asiganda la cola
            (over all (assigned ?w ?q))

            ; tareas en cola
            (at start (in ?t1 ?q))
            (at start (in ?t2 ?q))

            ; tarea está en la cabeza de la cola
            (at start (head ?t1 ?q))

            ; sucesor de la cola
            (at start (next ?t1 ?t2 ?q))

            ; el trabajador está conectado con el servidor
            (over all (online ?w ?h))

            ; servidor está libre
            (at start (idle ?h))

            ; trabajador no está enviando
            (at start (idle ?w))
        )
        :effect (and

            ; la tarea no está en la cola
            (at start (not (in ?t1 ?q)))

            ; la tarea no está en la cabeza de la cola
            (at start (not (head ?t1 ?q)))

            ; la tarea sucesor está en la cabeza
            (at start (head ?t2 ?q))

            ; rompemos la conexión de la cola
            (at start (not (next ?t1 ?t2 ?q)))

            ; trabajador está ocupando enviando
            (at start (not (idle ?w)))

            ; servidor esto de trasferencia
            (at start (not (idle ?h)))
            (at start (transfer-status ?h))

            ; tarea en servidor
            (at end (in ?t1 ?h))

            ; trabajador está libre
            (at end (idle ?w))


        )
    )

    ; Asignar una tarea de una cola al hilo del servidor cuando es la última de la cola
    (:durative-action send-empty-queue-tail
        :parameters (
            ?w - worker
            ?t - task
            ?q - queue
            ?h - thread
        )
        :duration (= ?duration (/ (file-size ?t) (transfer-rate ?w)))
        :condition (and

            ; trabajador tiene asiganda la cola
            (over all (assigned ?w ?q))

            ; tarea en cola
            (at start (in ?t ?q))

            ; tarea está en la cabeza de la cola
            (at start (head ?t ?q))

            ; la tarea tambíen es el final
            (at start (tail ?t ?q))

            ; el trabajador está conectado con el servidor
            (over all (online ?w ?h))

            ; servidor está libre
            (at start (idle ?h))

            ; trabajador no está enviando tareas
            (at start (idle ?w))
        )
        :effect (and

            ; la tarea no está en la cola
            (at start (not (in ?t ?q)))

            ; la tarea no está en la cabeza de la cola
            (at start (not (head ?t ?q)))

            ; la tarea no está en el final de la cola
            (at start (tail ?t ?q))

            ; trabajador está ocupando enviando
            (at start (not (idle ?w)))

            ; servidor estado de trasferencia
            (at start (not (idle ?h)))
            (at start (transfer-status ?h))

            ; tarea en servidor
            (at end (in ?t ?h))

            ; trabajador está libre
            (at end (idle ?w))
        )
    )

    ; Ejecutar una tarea en el hilo del servidor
    (:durative-action execute
        :parameters (
            ?t - task
            ?h - thread
        )
        :duration (= ?duration (estimated-execution-time ?t))
        :condition (and

            ; tarea en servidor
            (at start (in ?t ?h))

            ; servidor está en estado de trasferecia
            (at start (transfer-status ?h))
        )
        :effect (and

            ; servidor está ejecutando tarea
            (at start (not (transfer-status ?h)))
            (at start (execution-status ?h))

            ; servidor está libre
            (at end (idle ?h))

            ; tarea ejecutada
            (at end (task-executed ?t))

            ; contabilizar el tiempo total de ejecución  del hilo
            (at end (increase (total-execution-time ?h) (estimated-execution-time ?t)))
        )
    )

)
