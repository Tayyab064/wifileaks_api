class BankInformationSerializer < ActiveModel::Serializer
  attributes :id , :currency , :country , :bank_name , :routing_number , :account_number
  has_one :user

  def bank_name
  	object.name
  end
end
