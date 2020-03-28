class Application
    @@items = []

    def call(env)
        resp = Rack::Response.new
        req = Rack::Request.new(env)

        if req.path.match(/items/)
            item_search = req.path.split("/items/").last #gets the item searched from URL
            if item = @@items.find{|i|i.name == item_search} #sees if item is in array
                resp.write item.price #writes the price of the item
            else
                resp.write "Item not found"
                resp.status = 400
            end
        else
            resp.write "Route not found"
            resp.status = 404
        end

        resp.finish
    end

end


# Your application should only accept the /items/<ITEM NAME> route. 
# Everything else should 404
# If a user requests /items/<Item Name> it should return the price of that item
# If a user requests an item that you don't have,
# and then return a 400 and an error message