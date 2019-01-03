from src.models.LocationModel import LocationSchema, LocationModel
from . import db
from . import bcrypt
from marshmallow import fields, Schema


class UserModel(db.Model):
    __tablename__ = 'user'
    location_schema = LocationSchema()

    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(128), unique=True, nullable=False)
    password = db.Column(db.String(128), nullable=True)
    email = db.Column(db.String)
    rating = db.Column(db.Float)
    phone = db.Column(db.String)
    location = db.relationship("LocationModel", back_populates="user", uselist=False)
    reviews = db.relationship("ReviewItemModel", back_populates="owner")
    rentableitems = db.relationship("RentableItemModel", back_populates="owner")

    def __init__(self, data):
        self.name = data.get('name')
        self.password = self.__generate_hash(data.get('password'))
        self.email = data.get('email')
        self.rating = data.get('rating')
        self.phone = data.get('phone')
        self.location = LocationModel(data.get('location'))

    def save(self):
        db.session.add(self)
        db.session.add(self.location)
        db.session.commit()

    def update(self, data):
        for key, item in data.items():
            if key == 'password':
                self.password = self.__generate_hash(item)
            else:
                setattr(self, key, item)
        db.session.commit()

    def delete(self):
        db.session.delete(self)
        db.session.commit()

    @staticmethod
    def get_user_by_name(value):
        return UserModel.query.filter_by(name=value).first()

    def __generate_hash(self, password):
        return bcrypt.generate_password_hash(password, rounds=10).decode("utf-8")

    def check_hash(self, password):
        return bcrypt.check_password_hash(self.password, password)


class UserSchema(Schema):
    name = fields.Str()
    password = fields.Str()
    email = fields.Str()
    rating = fields.Float()
    phone = fields.Str()
    location = fields.Nested(LocationSchema)
