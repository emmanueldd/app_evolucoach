ActiveAdmin.register Program do
  permit_params Program.attribute_names.map{|n| n.to_sym}
end
