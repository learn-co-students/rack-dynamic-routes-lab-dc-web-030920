require 'pry'
class Application
 
    @@items = []
    def call(env)
      resp = Rack::Response.new
      req = Rack::Request.new(env)
   
      if req.path.match(/item/)
         item_name = req.path.split("/items/").last
         found_item = @@items.find{|item| item.name == item_name}

         if found_item == nil
            resp.status = 400
            resp.write "Item not found"
         else
            resp.status = 200
            resp.write "#{found_item.price}"
         end
      else
        resp.write "Route not found"
        resp.status = 404
      end
   
      resp.finish
    end
  end