from marshmallow import Schema, fields

from src.models import db


class RentPeriodModel(db.Model):
    __tablename__ = 'rentperiod'

    id = db.Column(db.Integer, primary_key=True)
    start_date = db.Column(db.Date)
    end_date = db.Column(db.Date)
    user_name = db.Column(db.String)
    rentableitem = db.relationship("RentableItemModel", back_populates="rent_periods")
    rentableitem_id = db.Column(db.Integer, db.ForeignKey('rentableitem.id'))

    def __init__(self, data):
        self.start_date = data.get("start_date")
        self.end_date = data.get("end_date")
        self.user_name = data.get("user_name")

    def save(self):
        db.session.add(self)
        db.session.commit()

    def delete(self):
        db.session.delete(self)
        db.session.commit()

    @staticmethod
    def get_all_rent_periods_with_rentableitem_id(value):
        return RentPeriodModel.query.filter_by(rentableitem_id=value).all()


class RentPeriodSchema(Schema):
    start_date = fields.Date('%b %d %Y')
    end_date = fields.Date('%b %d %Y')
    user_name = fields.String()

