ActiveAdmin.register Book do
  permit_params :title, :author_id, :genre, :price, :description, category_ids: []

  index do
    selectable_column
    id_column
    column :title
    column :author
    column :genre
    column :price
    column :categories do |book|
      book.categories.map(&:name).join(", ")
    end
    actions
  end

  filter :title
  filter :author
  filter :genre
  filter :categories

  form do |f|
    f.inputs do
      f.input :title
      f.input :author
      f.input :genre
      f.input :description
      f.input :price
      f.input :categories, as: :check_boxes
    end
    f.actions
  end
end
