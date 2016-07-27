class WifiSerializer < ActiveModel::Serializer
  attributes :id , :lat , :long , :address , :name , :ssid , :security_type , :password , :price , :data_usage , :earning , :no_of_users , :rating

  def earning
  	pri = 0
  	object.connections.each do |con|
  		pri =  pri + con.total_bill
  	end
  	pri
  end

  def rating
  	count = 0
  	ra = 0
  	object.connections.each do |rat|
  		unless rat.rating.nil?
	  		ra = ra + rat.rating.rate
	  		count = count + 1
		end
  	end
	if ra != 0 && count != 0
  		(ra.to_f()/count).round(1)
	else
		0
	end
  end

  def data_usage
  	data = 0
  	object.connections.each do |dat|
		unless dat.download_data.nil?
  			data = data + ( dat.download_data )
		end
  	end
  	data.round(2)
  end

  def no_of_users
  	object.connections.count
  end
end
