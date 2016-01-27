class FilterCategoriesController < ApplicationController
  before_action :readonly_example_user, only: :update_filter_categories
  before_action :patch_hidden_categories, only: [:update_filter_categories]
  
  def edit_filter_categories
  end

  def update_filter_categories
    redirect_to edit_user_registration_path
    flash[:notice] = 'Filter was updated.'
  end

  private

  def feed_categories_to_hide_ids
    ids = []
    params.each do |param,value|
      if param =~ /(\d)+_category/
	ids << param.to_i
      end
    end
    ids
  end

  def patch_hidden_categories
    categories_to_hide = feed_categories_to_hide_ids
    categories_to_hide.each do |cat_id|
      category = Category.find(cat_id)
      unless current_user.hidden_categories.include? category
	current_user.relationships.create hidden_category_id: category.id
      end
    end
    unless current_user.hidden_categories.size.eql? categories_to_hide
      current_user.relationships.each do |rel|
	rel.destroy unless categories_to_hide.include? rel.hidden_category_id
      end
    end
  end
end
