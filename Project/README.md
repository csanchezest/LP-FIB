# Doble intèrpret de JSBach
#
## Pràctica de compiladors de LP Q2-21/22
#

### Breum resum
---
El present projecte consisteix en la implementació d'un (doble) intèrpret d'un llenguatge de programació basat en la figura de _Johann Sebastian Bach_. Així mateix, aquest ve definit, per una banda, pel fitxer `jsbach.g4`, que defineix la gramàtica del llenguatge, i, d'altra banda, pel fitxer `jsbach.py`, que incorpora tant els visitadors com el _script_ d'execució dels fitxers reconeguts pel llenguatge. Val a dir que aquest intèrpret opera independentment de l'extensió del fitxer en què es trobi el programa a executar, però és recomanable que es faci ús de '.jsb' pel mateix benefici de l'usuari.
#
### Característiques de la gramàtica
---
La gramàtica permet fer ús d'instruccions i operadors tals com:
- Assignació amb `<-`  
- Lectura amb `<?>` (val a dir que només es llegeixen enters, i en cap cas reals, cadenes de caràcters o d'altres possibles valors)
- Escriptura amb `<!>`
- Reproducció amb `<:>`
- Addició d'elements a llistes amb `<<`
- Eliminació d'elements de llistes amb `8<`
- Consulta de la longitud d'una llista `#`
- Accés a elements d'una llista `l` amb `l[i]` (els índexs van des d'1 fins a n, sent n la longitud de la llista)
- Estructures condicionals `if`-`else`
- Estructures iteratives `while`
- Comentaris amb `~~~ (peça de text a comentar) ~~~`
- Ús d'expressions de càlculs simples amb els operadors clàssics (`+` | `-` | `*` | `/` | `%`)
- Ús d'expressions relacionals amb els operadors clàssics (`<` | `>` | `<=` | `>=` | `=` | `/=`)
- Invocació de procediments que en cap cas retornen resultats (i que poden tenir paràmetres). Tot i això, aquests poden ser recursius.

A més a més, cal tenir en compte que, pel fet que es tracta d'un llenguatge que interpreta una partitura, s'incorpora la presència de _notes_, que no son cap altra cosa que constants numèriques (tot i que, a efectes pràctics, els programes puguin venir-les definint amb caràcters).

En aquesta línia, cal tenir en compte que:
- Els noms de les variables necessàriament han de començar per una lletra minúscula
- Els noms dels procediments han de començar per una lletra majúscula
- Les notes han d'indicar-se en majúscules i van des de `A0`, `B0`... fins `C8`. Val a dir que les notes `A`, `B`, `C`, `D`, `E`, `F` i `G` corresponen a `A4`, `B4`...

A continuació, es detallen exemples d'ús dels operadors:
```jsbach
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
```

S'anima a l'usuari a provar d'executar aquest codi amb el present intèrpret.

### Característiques de l'intèrpret
---
En primer lloc, l'intèrpret s'invoca de la següent manera: `python3 jsbach.py [fitxer].[exensio]`

Un exemple d'ús seria el següent: `python3 jsbach.py Hanoi.jsb`

Una característica interessant d'aquest intèrpret és que, si escau, se li pot indicar el procediment des del qual començar l'execució del programa. En aquest cas, hom hauria d'invocar l'intèrpret de la següent manera: `python3 jsbach.py Hanoi.jsb Hanoi`, on el 4t paràmetre seria el nom del procediment que substituiria al _Main_.

A banda d'això, i recuperant el concepte que es tracta d'un _doble_ intèrpret, el _script_ està preparat per generar fitxers `LILY`, `PDF`, `MIDI`, `WAV` i `MP3`. La generació d'aquests fitxers, però, no és incondicional: si el programa no indica explícitament que es reprodueixin notes, el _script_ no generarà fitxer algun. A més a més, els fitxers generats tindràn el mateix nom que el fitxer d'entrada, és a dir, davant la comanda `python3 jsbach.py Hanoi.jsb`, els fitxers generats tindrien el nom `Hanoi.[extensió]`.

Finalment, aquest projecte no incorpora cap mena d'extensió, amb la qual cosa no s'adjunten més exemples de codi, a banda del que s'incorpora en aquest fitxer _readme_.

---
_Projecte de_: Cristian Sánchez Estapé