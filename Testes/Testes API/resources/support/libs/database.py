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

@keyword('Limpar usuario do database')
def clean_user(user):
    users = db["users"]
    user_email = user["email"]
    reservations = db["reservations"]
    u = users.find_one({"email": user_email})
    if(u):
        reservations.delete_many({"user": u["_id"]})
        users.delete_many({"email": user_email})