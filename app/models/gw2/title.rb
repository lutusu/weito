class Gw2::Title
  include Mongoid::Document
  
  field :gw2_title, type: Hash
  
  validate :gw2_id_present

  private
  
  def gw2_id_present
    errors.add(:gw2_title, 'is duplicated') if Gw2::Title.where("gw2_title.id": self.gw2_title["id"]).count != 0
  end
end
