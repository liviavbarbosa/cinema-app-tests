from robot.api.deco import keyword
from pymongo import MongoClient
import bcrypt

client = MongoClient('mongodb://localhost:27017/cinema-app')
db = client['cinema-app']

@keyword('Remover usuario do database')
def remove_user(user):
    users = db['users']
    email = user["email"]
    users.delete_many({'email': email})
 

@keyword('Inserir usuario no database')
def insert_user(user):
    hash_pass = bcrypt.hashpw(user["password"].encode('utf-8'), bcrypt.gensalt(8))
    doc = {
        'name': user["name"],
        'email': user["email"],
        'password': hash_pass
    }
    users = db['users']
    users.insert_one(doc)


@keyword('Atualizar role do usuario para admin')
def update_user_role_to_admin(email):
    users = db['users']
    users.update_one(
        {'email': email},               
        {'$set': {'role': 'admin'}}     
    )


@keyword('Limpar usuario do database')
def clean_user(user):
    users = db["users"]
    user_email = user["email"]
    reservations = db["reservations"]
    u = users.find_one({"email": user_email})
    if(u):
        reservations.delete_many({"user": u["_id"]})
        users.delete_many({"email": user_email})


@keyword('Remover filme do database')
def remove_movie(id_movie):
    movies = db["movies"]
    movies.delete_many({'_id': id_movie})


@keyword('Inserir filme no database')
def insert_movie(movie):
    doc = {
        "title": movie["title"],
        "synopsis": movie["synopsis"],
        "director": movie["director"],
        "genres": movie["genres"],
        "duration": movie["duration"],
        "classification": movie["classification"],
        "poster": movie["poster"],
        "releaseDate": movie["releaseDate"]
    }
    movies = db['movies']
    movies.insert_one(doc)


@keyword('Pegar id do filme')
def get_movie_id(movie):
    movies = db["movies"]
    id_movie = movies.find_one({"title": movie["title"]})
    return id_movie["_id"] 


@keyword('Remover teatro do database')
def remove_theater(id_teatro):
    teatros = db["theaters"]
    teatros.delete_many({'_id': id_teatro})


@keyword('Inserir teatro no database')
def insert_theater(theater):
    doc = {
        "name": theater["name"],
        "capacity": theater["capacity"],
        "type": theater["type"]
    }
    theaters = db['theaters']
    theaters.insert_one(doc)


@keyword('Pegar id do teatro')
def get_theater_id(theater):
    theaters = db["theaters"]
    id_theater = theaters.find_one({"name": theater["name"]})
    return id_theater["_id"] 