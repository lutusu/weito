class Gw2::Item
  include Mongoid::Document

  field :gw2_item, type: Hash
  
  validate :gw2_id_present

  private
  
  def gw2_id_present
    errors.add(:gw2_item, 'is duplicated') if Gw2::Item.where("gw2_item.id": self.gw2_item["id"]).count != 0
  end
end
