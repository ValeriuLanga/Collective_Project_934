from .RentPeriodModel import RentPeriodSchema
from . import db
from marshmallow import fields, Schema


class RentableItemModel(db.Model):
    __tablename__ = 'rentableitem'

    categoryTypes = ['Film & Photography', 'Projectors & Screens', 'Drones', 'DJ Equipment', 'Sports', 'Musical']

    id = db.Column(db.Integer, primary_key=True)
    category = db.Column(db.Enum('Film & Photography', 'Projectors and Screens', 'Drones', 'DJ Equipment', 'Sports', 'Musical', name='types'))
    title = db.Column(db.String)
    available_start_date = db.Column(db.Date)
    available_end_date = db.Column(db.Date)
    receiving_details = db.Column(db.String)
    price = db.Column(db.Integer)
    item_description = db.Column(db.String)
    owner_name = db.Column(db.String)
    photo_name = db.Column(db.String)
    rented = db.Column(db.Boolean)
    owner = db.relationship("UserModel", back_populates="rentableitems")
    owner_id = db.Column(db.Integer, db.ForeignKey('user.id'))
    reviews = db.relationship("ReviewItemModel", back_populates="rentableitem")
    rent_periods = db.relationship("RentPeriodModel", back_populates="rentableitem")

    def __init__(self, data):
        self.category = data.get("category")
        self.title = data.get("title")
        self.price = data.get("price")
        self.receiving_details = data.get("receiving_details")
        self.item_description = data.get("item_description")
        self.available_start_date = data.get('available_start_date')
        self.available_end_date = data.get('available_end_date')

    def save(self):
        db.session.add(self)
        db.session.commit()

    def delete(self):
        db.session.delete(self)
        db.session.commit()

    @staticmethod
    def get_rentableitem_by_id(value):
        return RentableItemModel.query.filter_by(id=value).first()

    @staticmethod
    def get_all():
        return RentableItemModel.query.all()

    @staticmethod
    def get_all_by_category(value):
        return RentableItemModel.query.filter_by(category=value).all()

    @staticmethod
    def get_all_like_name(value):
        return RentableItemModel.query.filter(RentableItemModel.title.like('%{0}%'.format(value))).all()


class RentableItemSchema(Schema):
    id = fields.Integer()
    category = fields.Str()
    available_start_date = fields.Date('%b %d %Y')
    available_end_date = fields.Date('%b %d %Y')
    receiving_details = fields.String()
    item_description = fields.String()
    rented = fields.Boolean()
    price = fields.Integer()
    title = fields.String()
    owner_name = fields.String()
    rent_periods = fields.Nested(RentPeriodSchema, many=True)


class RentableItems:
    def __init__(self, rentableitems):
        self.rentableitems = rentableitems


class RentableItemsSchema(Schema):
    rentableitems = fields.Nested(RentableItemSchema, many=True)
