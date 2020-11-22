ActiveAdmin.register Exercise do
  permit_params Exercise.attribute_names.map{|n| n.to_sym}

  index download_links: proc{ current_admin_user.email == 'e.derozin@gmail.com' }

end
