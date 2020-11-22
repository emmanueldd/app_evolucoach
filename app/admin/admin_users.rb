ActiveAdmin.register AdminUser do
  menu label: "Admins", priority: 3, parent: 'Users'
  controller do
    def permitted_params
      params.permit!
    end
  end



  index do
    selectable_column
    id_column
    column :email
    column :current_sign_in_at
    column :sign_in_count
    column :created_at
    actions
  end

  filter :email
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at

  form do |f|
    f.inputs "Admin Details" do
      f.has_many :admin_user_accesses, allow_destroy: true, new_record: true do |ff|
        ff.input :name, collection: (ActiveAdmin.application.namespaces[:admin].resources.map { |resource| resource.resource_label.classify.gsub(" ","") } ).sort
      end
      f.input :email
      if f.object.new_record?
        f.input :password
        f.input :password_confirmation
      end
    end
    f.actions
  end
end
