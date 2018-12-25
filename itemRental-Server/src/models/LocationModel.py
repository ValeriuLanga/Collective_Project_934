from . import db
from marshmallow import fields, Schema


class LocationModel(db.Model):
    __tablename__ = 'location'

    id = db.Column(db.Integer, primary_key=True)
    city = db.Column(db.String)
    street = db.Column(db.String)
    coordX = db.Column(db.Float)
    coordY = db.Column(db.Float)
    user = db.relationship("UserModel", back_populates="location")
    user_id = db.Column(db.Integer, db.ForeignKey('user.id'))

    def __init__(self, data):
        self.city = data.get('city')
        self.street = data.get('street')
        self.coordX = data.get('coordX')
        self.coordY = data.get('coordY')

    def save(self):
        db.session.add(self)
        db.session.commit()

    def delete(self):
        db.session.delete(self)
        db.session.commit()


class LocationSchema(Schema):
    city = fields.Str()
    street = fields.Str()
    coordX = fields.Float()
    coordY = fields.Float()
