class ConnectionBillSerializer < ActiveModel::Serializer
  attributes :id , :wifi_name , :connected_at 

  def wifi_name
  	object.wifi.name
  end

  def connected_at
  	object.created_at.strftime("%I:%M%p")
  end

end
