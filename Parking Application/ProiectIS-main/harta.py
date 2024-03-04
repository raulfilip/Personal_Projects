import folium
from geopy.geocoders import Nominatim
from adresa_parcari import get_adresa_pret_minim, get_parcari
from geopy.distance import geodesic
import ssl
import certifi

def get_location(address):
    ssl_context = ssl.create_default_context(cafile=certifi.where())
    geolocator = Nominatim(user_agent="location_tracker", ssl_context=ssl_context)
    location = geolocator.geocode(address)

    if location is not None:
        return location.latitude, location.longitude
    else:
        print(f"Locația pentru {address} nu a putut fi găsită.")
        return None, None


def calculeaza_distanta(lat1, lon1, lat2, lon2):
    locatie1 = (lat1, lon1)
    locatie2 = (lat2, lon2)

    distanta = geodesic(locatie1, locatie2).kilometers

    return distanta


def afiseaza_adrese(address1, address2, nume):
    lat1, lon1 = get_location(address1)
    lat2, lon2 = get_location(address2)

    if lat1 is not None and lon1 is not None and lat2 is not None and lon2 is not None:
        # Crează o hartă centrată pe o locație medie
        latitude = (lat1 + lat2) / 2
        longitude = (lon1 + lon2) / 2
        my_map = folium.Map(location=[latitude, longitude], zoom_start=13)

        # Adaugă pini pentru cele două locații
        folium.Marker([lat2, lon2], tooltip=nume, icon=folium.Icon(color='red')).add_to(my_map)
        folium.Marker([lat1, lon1], tooltip="Adresa curenta").add_to(my_map)

        # Salvează harta într-un fișier HTML
        file_path = "templates/location_map.html"
        my_map.save(file_path)
        print(f"Harta a fost salvată în {file_path}")
    else:
        print("Nu s-au putut găsi coordonate valide pentru una sau ambele adrese.")

def afiseaza_toate_parcarile(adresa_curenta):

    adrese = get_parcari()
    lat1, lon1 = get_location(adresa_curenta)
    my_map = folium.Map(location=[lat1, lon1], zoom_start=13)
    if lat1 is not None and lon1 is not None:
        folium.Marker([lat1, lon1], tooltip="Adresa curenta").add_to(my_map)

    for e in adrese:
        print(e)
        ultima_pozitie = e.rfind(", ")
        if ultima_pozitie != -1:
            nume=e[ultima_pozitie+2:] 
            adresa_p = e[:ultima_pozitie]

        lat1, lon1 = get_location(adresa_p)
        if lat1 is not None and lon1 is not None:
             folium.Marker([lat1, lon1], tooltip=nume, icon=folium.Icon(color='red')).add_to(my_map)
    # Salvează harta într-un fișier HTML
    file_path = "templates/location_map.html"
    my_map.save(file_path)
    print(f"Harta a fost salvată în {file_path}")



