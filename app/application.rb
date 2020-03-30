require 'pry'
class Application

    @@items = []

    def call(env)
        resp = Rack::Response.new
        req = Rack::Request.new(env)

        if req.path.match(/items/)
            item_name = req.path.split("/items/").last
            found_item = @@items.find{|item| item.name == item_name}
          if found_item #// if item exists
            resp.write found_item.price.to_s #//  returns the item's price for that item
          else #// if item doesn't exists
            resp.status = 400
            resp.write "Item not found"
            end  
        else #// if route doesn't exist
        resp.status = 404
        resp.write "Route not found"
        end 
        resp.finish
    end
end