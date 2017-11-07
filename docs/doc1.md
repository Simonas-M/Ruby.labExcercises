Tikslas - sugalvoti užduoties temą ir aprašyti užduoties sąvybes.

Užduotis:
  1) Sugalvoti užduoties temą (negali kartotis su šio semestro jau užregistruotomis temomis https://github.com/sauliusgrigaitis/agile_development_with_ruby/tree/master/tasks/temos)
  2) Sugalvoti bent 30 sistemos savybių iš sistemos naudotojų pusės ( pavyzdys http://github.com/sauliusgrigaitis/bank/blob/master/uzduotys/savybes ). Kuo daugiau sugalvosite, tuo geriau, nes nebūtina visų įgyvendinti, svarbu įgyvendinti svarbiausias.
  3) Surušiuoti sistemos savybes pagal jų svarbą, t.y. pirmos savybės bus tos, kurios teikia didžiausią naudą vartotojui. 
  4) Susigrupuoti į komandas iš 1-2 žmonių
  5) 1), 2), 3) ir 4) užregistruoti el. paštu [saulius@necolt.com](saulius@necolt.com) būtinai nurodant studento pažymėjimo numerį.

Reikalavimai:
  * Užduoties tema turi būti pakankamos apimties, minimalus reikalavimas yra 5 esminės esybės (ne sąvybės). Pvz. jei kuriama bankinė sistema, tai esminės esybės būtų: Sąskaita, Vartotojas, Tranzakcija, Valiuta, PalūkanųNorma.
  * Negalima kurti tokios sistemos, kuri teorinių paskaitų metu buvo naudojama demonstracijoms.
  * Pačios kuriamos sistemos taip pat turi būti unikalios, t.y. pakeitus vienos sistemos esybių pavadinimus gauta sistema nebus skaitoma kaip unikali
 
Įvertinimas: 0.5 balo

# TEMA - Kino Teatras

## Esybės

* Bilietas
* Žiūrovas
* Filmas
* Seansas
* Kino salė
* Repertuaras
* _Reklama_
* _Cenzas_
* _Žanras_

## Savybės

### Klientas gali:
* nusipirkti bilietą:
    1. pasirinkti filmo bilietą
        * pasirinkti kino filmą
        * pasirinkti kino salę
        * pasirinkti datą
        * parininkti seansą
    2. pridėti į prekių krepšelį
    3. peržiūrėti prekių krepšelį
    4. gauti nuolaidą:
        * lojalumo kortelė(-s)
        * dovanų kuponas
    5. patvirtinti pirkimą
* rezervuoti bilietą(tokie patys žingsniai kaip ir pirkimo, tik bilietas dar neapmokėtas)
* atšaukti bilieto rezervaciją
* peržiūrėti kino filma(panaudoti bilietą)
* peržiūrėti repertuarą(visi dabar rodomi filmai)
* filtruoti repertuarą pagal:
    1. datą
    2. žanrą
    3. kino salę
    4. kino teatro vietą
* peržiūrėti tam tikro kino filmo:
    1. repertuarą
    2. bendrą informaciją
        * cenzą
        * žanrą
        * trukmę
        * įvertinimą
        * aprašymą
* peržiūrėti greitai rodomus filmus
* peržiūrėti populiariausių filmų sąrašą:
    1. pagal įvertinimą
    2. pagal bilietų perkamumą
* pamatyti dienos santrauką(tą dieną rodomus filmus)
* įvertinti matytą filmą
* peržiūrėti amžiaus cenzus - jų reikšmes ir apribojimus
* peržiūrėti savo pirkimų istoriją
* "atsispausdinti" nusipirktą bilietą

### "Moderatorius" gali:
* įvesti naują filmą
* ištrinti esamą filmą
* priskirti filmui seansą:
    * kino teatro vietą
    * kino salę
    * datą
* ištrinti esamą filmo seansą
* redaguoti esamą filmą
* redaguoti esamo filmo seansą
* "deaktyvuoti" bilietą

