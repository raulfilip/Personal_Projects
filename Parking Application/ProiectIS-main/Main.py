from adresa_parcari import get_adresa_pret_minim, get_parcari
from harta import get_location, calculeaza_distanta,afiseaza_toate_parcarile
from harta import afiseaza_adrese

def gaseste_cea_mai_apropiata_parcare(adresa_curenta):
    adresa = get_parcari()
    distanta_minima = 10 ** 1000
    adresa_parc_apropiata = " "
    numef=""
    for e in adresa:
        # Găsim ultima poziție a ", " în text
        ultima_pozitie = e.rfind(", ")

        if ultima_pozitie != -1:
            nume=e[ultima_pozitie+2:]
            e = e[:ultima_pozitie]
        print(e)
        a=get_location(adresa_curenta)
        b=get_location(e)
        distanta = calculeaza_distanta(a[0],a[1],b[0],b[1])

        if distanta < distanta_minima:
            distanta_minima = distanta
            numef=nume
            adresa_parc_apropiata=e

    afiseaza_adrese(adresa_curenta, adresa_parc_apropiata, numef)


def gaseste_cea_mai_ieftina_parcare(adresa_curenta):
    adresa = get_adresa_pret_minim()
    nume="JON"
    print(adresa)
    ultima_pozitie = adresa.rfind(", ")
    if ultima_pozitie != -1:
          nume=adresa[ultima_pozitie+2:] 
          adresa = adresa[:ultima_pozitie]
            
    print(adresa)
    print(nume)
    afiseaza_adrese(adresa_curenta, adresa,nume)
    
    
#gaseste_cea_mai_apropiata_parcare("Strada Minerilor, Cluj Napoca, Romania")
#gaseste_cea_mai_ieftina_parcare("Strada Minerilor, Cluj Napoca, Romania")
#afiseaza_toate_parcarile("Strada Minerilor, Cluj Napoca, Romania")