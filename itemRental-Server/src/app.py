from flask import Flask
from .models import db, bcrypt


def create_app():
    app = Flask(__name__)
    app.config['SQLALCHEMY_DATABASE_URI'] = 'postgresql://localhost:5432/item_rental'
    bcrypt.init_app(app)
    db.init_app(app)

    return app
