class Client < ApplicationRecord
    has_many :memberships, dependent: :destroy
    has_many :gyms, through: :memberships

    validates :gyms, uniqueness: true

    def total_charges
        self.memberships.sum(:charge)
    end
end
