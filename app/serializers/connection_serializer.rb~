class ConnectionSerializer < ActiveModel::Serializer
  attributes :id , :wifi_name , :connected_at , :disconnected_at , :bill
  has_one :rating
  def wifi_name
  	object.wifi.name
  end

  def connected_at
  	unless object.connected_at.nil?
     object.connected_at.strftime("%I:%M%p")
    end
  end

  def disconnected_at
    unless object.disconnected_at.nil?
  	 object.disconnected_at.strftime("%I:%M%p")
    end
  end

  def bill
    unless object.download_data.nil?
     (object.download_data * 0.8) + (object.upload_data * 1.2)
    end
  end
end
