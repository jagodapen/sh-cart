desc "Call ShoppingListEmailJob to filter emails and send shopping lists"

task :send_shopping_lists do
  ShoppingListEmailJob.perform_later
end
