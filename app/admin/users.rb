ActiveAdmin.register User do
  permit_params :email, :first_name, :last_name, :nick_name, :gender

  index do
    selectable_column
    id_column
    column :email
    column :nick_name
    column(:gender) { |user| I18n.t("user.gender.#{user.gender}") }
    actions
  end

  filter :name_includes, as: :string, label: I18n.t("user.name_or_email")
  filter :gender, as: :select, collection: User::GENDERS.invert

  form do |f|
    f.inputs do
      f.input :email
      f.input :nick_name
      f.input :gender, as: :radio, collection: User::GENDERS.invert
    end
    f.actions
  end

  show do |user|
    div :class => "table" do 
      table do
        tr do
          th "Attributes"
          th "Info"
        end
        tr do
          td I18n.t("activerecord.attributes.user.email")
          td user.email
        end
        tr do
          td I18n.t("activerecord.attributes.user.nick_name")
          td user.nick_name
        end
        tr do
          td I18n.t("activerecord.attributes.user.gender")
          td I18n.t("user.gender.#{user.gender}") 
        end
      end
    end
  end
end
