ActiveAdmin.register AllowedAccount do
  permit_params AllowedAccount.attribute_names.map{|n| n.to_sym}
end
