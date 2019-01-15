from flask import Flask
from flask_cors import CORS
from .models import db, bcrypt
from .views.UserView import user_api as user_blueprint
from .views.ReviewItemView import review_api as review_blueprint
from .views.RentableItemView import rentableitem_api as rentableitem_blueprint


def create_app():
    app = Flask(__name__, static_url_path='')
    CORS(app)
    app.config['SQLALCHEMY_DATABASE_URI'] = 'postgresql://postgres:postgres@localhost:5432/item_rental'
    bcrypt.init_app(app)
    db.init_app(app)

    app.register_blueprint(user_blueprint, url_prefix='/api/v1/users')
    app.register_blueprint(review_blueprint, url_prefix='/api/v1/reviews')
    app.register_blueprint(rentableitem_blueprint, url_prefix='/api/v1/rentableitems')

    return app
