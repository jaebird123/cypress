class Vendor

	include Mongoid::Document
	include Mongoid::Attributes::Dynamic
	include Mongoid::Timestamps

	has_many :products, dependent: :destroy
	embeds_many :points_of_contact

	field :name, type: String
	field :vendor_id, type: String
	field :url, type: String
	field :address, type: String
	field :state, type: String
	field :zip, type: String
	# field :poc, type: String
	# field :tel, type: String

	validates_presence_of :name

	# Methods should be used only for testing

	def failing_products
		return 5
	end

	def passing_products
		return 3
	end

	def incomplete_products
		return 1
	end

	def total_products
		return 8
	end

end

class PointOfContact
	include Mongoid::Document

	embedded_in :vendor

	field :name
	field :email
end