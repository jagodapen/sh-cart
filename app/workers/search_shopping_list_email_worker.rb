class SearchShoppingListEmailWorker
   include Sidekiq::Worker
   def emails
     @emails = ShoppingListEmail.where(was_send: false, send_date: Date.today)
   end

   def email_shopping_list(email)
     @shopping_list_name = email.shopping_list.name
     @shopping_list_date = email.shopping_list.send_date
     @shopping_list_products = email.shopping_list.products.map do |product|
       [product.name, email.shopping_list.shopping_list_products.find_by(product_id: product.id).quantity] }.to_h
     end
   end
end
