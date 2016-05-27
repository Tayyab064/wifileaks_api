class WifiSerializer < ActiveModel::Serializer
  attributes :id , :lat , :long , :address , :name , :ssid
end
