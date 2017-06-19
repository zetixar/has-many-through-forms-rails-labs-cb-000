+++ Choosing only one category
https://learn.co/tracks/full-stack-community-bootcamp/rails/associations-and-rails/forms-and-basic-association
https://github.com/learn-co-students/forms-and-basic-associations-rails-cb-000

      *select*
        <%= f.collection_select :doctor, Doctor.all, :id, :name %>
      *data list*
      <%= form_for @post do |f| %>
        <%= f.text_field :category, list: "categories_autocomplete" %>
        <datalist id="categories_autocomplete">
          <%= Category.all.each do |category| %>
            <option value="<%= category.name %>">
          <% end %>
        </datalist>
        <textarea name="post[content]"></textarea>
      <% end %>

+++ Choosing multiple categories
https://learn.co/tracks/full-stack-community-bootcamp/rails/associations-and-rails/has-many-through-in-forms
https://github.com/zetixar/has-many-through-forms-rails-cb-000
      *checkbox for each category*
        <%= f.collection_check_boxes :category_ids, Category.all, :id, :name %>

      *checkbox for each category with new category*
      <%= f.collection_check_boxes :category_ids, Category.all, :id, :name %>
      <%= f.fields_for :categories, post.categories.build do |categories_fields| %>
        <%= categories_fields.text_field :name %>
      <% end %>

      ------ Controller ------
      def post_params
        params.require(:post).permit(:title, :content, category_ids:[], categories_attributes: [:name])
      end
      ------ Model ------
      #to prevent duplicate we do the following:
      accepts_nested_attributes_for :categories

      def categories_attributes=(category_attributes)
        category_attributes.values.each do |category_attribute|
          category = Category.find_or_create_by(category_attribute)
          self.categories << category
        end
      end
