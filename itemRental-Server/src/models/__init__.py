from flask_sqlalchemy import SQLAlchemy
from flask_bcrypt import Bcrypt

db = SQLAlchemy()
bcrypt = Bcrypt()

from .UserModel import UserModel, UserSchema
from .LocationModel import LocationModel, LocationSchema
from .RentableItemModel import RentableItemModel, RentableItemSchema, RentableItemsSchema
from .ReviewItemModel import ReviewItemModel, ReviewItemSchema, ReviewItemsSchema
from .RentPeriodModel import RentPeriodModel, RentPeriodSchema
