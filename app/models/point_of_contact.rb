class PointOfContact

  include Mongoid::Document
  include Mongoid::Attributes::Dynamic
  include Mongoid::Timestamps

  embedded_in :vendor

  field :name, type: String
  field :email, type: String
  field :phone, type: String
  field :contact_type, type: String

end