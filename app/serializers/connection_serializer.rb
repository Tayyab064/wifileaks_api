class ConnectionSerializer < ActiveModel::Serializer
  attributes :id , :wifi_name , :connected_at , :disconnected_at , :bill

  def wifi_name
  	object.wifi.name
  end

  def connected_at
  	object.created_at.strftime("%I:%M%p")
  end

  def disconnected_at
    unless object.disconnected_at.nil?
  	 object.disconnected_at.strftime("%I:%M%p")
    end
  end

  def bill
    unless object.data.nil?
     object.data * 0.8
    end
  end
end
