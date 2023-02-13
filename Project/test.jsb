Main |:
    <!> "Introdueix un enter: "
    <?> enter
    <!> "Aquest és el teu enter: " enter
    a <- 2
    <!> "La variable 'a' té el valor " a
    l <- {A B C} ~~~ Les llistes es declaren entre corxets ~~~
    <!> #l l
    l << D ~~~ ara la llista l és {A B C D} ~~~
    <!> #l l
    8< l[1] ~~~ ara la llista l és {B C D} ~~~
    <!> #l l
    <:> l ~~~ l'operador de reproduccio es pot fer anar amb una llista de notes... ~~~
    <:> C8 D6 G2 ~~~ ... o bé amb una o més notes ~~~
    <!> l[1]
    if a < 3 |:
        if a = 2 |:
            <!> "La variable 'a' és 2"
        :| else |:
            <!> "La variable 'a' no és 2"
        :|
    :| ~~~ les estructures condicionals no necessàriament han de tenir "else" ~~~
    i <- 0
    while i < a |:
        <!> i
        i <- i + 1
    :|
:|
~~~ exemple de main alternatiu, al qual es pot accedir indicant-se des de terminal (vegi's la secció de característiques de l'intèrpret) ~~~
Main2 |: 
    src <- {C D E F G}
    dst <- {}
    aux <- {}
    HanoiRec #src src dst aux
:|
~~~ exemple de procediment recursiu ~~~
HanoiRec n src dst aux |:
    if n > 0 |:
        HanoiRec (n - 1) src aux dst
        note <- src[#src]
        8< src[#src]
        dst << note
        <:> note
        HanoiRec (n - 1) aux dst src
    :|
:|
