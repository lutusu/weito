module Gw2Service
  class Achievements < Base
    class << self
      attr_reader :achievements,:types,:rewards,:bits

      def assemble
        Gw2::Achievement.all.find_each do |achievement|
          a_hash = achievement.gw2_achievement
          
          # assemble rewards
          if a_hash.has_key?("rewards")
            a_hash["rewards"].each_with_index do |reward,index|
              
              #replace item
              if reward["type"] == 'Item'
                item_id = a_hash["rewards"][index].delete("id")
                item = Gw2::Item.where("gw2_item.id": item_id).last
                if item
                  a_hash["rewards"][index]["content"] = item.gw2_item
                else
                  a_hash["rewards"][index]["id"] = item_id
                end
              end

              #replace mastery
              if reward["type"] == 'Mastery'
                item_id = a_hash["rewards"][index].delete("id")
                mastery = Gw2::Mastery.where("gw2_mastery.id": item_id).last
                if mastery
                  a_hash["rewards"][index]["content"] = mastery.gw2_mastery
                else
                  a_hash["rewards"][index]["id"] = item_id
                end
              end
              #replace title
              if reward["type"] == 'Title'
                item_id = a_hash["rewards"][index].delete("id")
                title = Gw2::Title.where("gw2_title.id": item_id).last
                if title
                  a_hash["rewards"][index]["content"] = title.gw2_title
                else
                  a_hash["rewards"][index]["id"] = item_id
                end
              end
            end
          end

          # assemble bits
          if a_hash.has_key?("bits")
            a_hash["bits"].each_with_index do |bits,index|
              
              # replace item
              if bits["type"] == 'Item'
                item_id = a_hash["bits"][index].delete("id")
                item = Gw2::Item.where("gw2_item.id": item_id).last
                if item
                  a_hash["bits"][index]["content"] = item.gw2_item
                else
                  a_hash["bits"][index]["id"] = item_id
                end 
              end
              
              # replace item
              if bits["type"] == 'Minipet'
                item_id = a_hash["bits"][index].delete("id")
                minipet = Gw2::Minipet.where("gw2_minipet.id": item_id).last
                if minipet
                  a_hash["bits"][index]["content"] = minipet.gw2_minipet
                else
                  a_hash["bits"][index]["id"] = item_id
                end
              end 

              # replace item
              if bits["type"] == 'Skin'
                item_id = a_hash["bits"][index].delete("id")
                skin = Gw2::Skin.where("gw2_skin.id": item_id).last
                if skin
                  a_hash["bits"][index]["content"] = skin.gw2_skin
                else
                  a_hash["bits"][index]["id"] = item_id
                end
              end 
            end
          end
          achievement = ::Achievement.where("doc.id": a_hash["id"]).last
          if achievement
            achievement.doc = a_hash
            achievement.save
          else
            ::Achievement.create(doc: a_hash) 
          end
        end
      end
    end
  end
end