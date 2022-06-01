require "rails_helper"

RSpec.describe BillionairesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/billionaires").to route_to("billionaires#index")
    end

    it "routes to #show" do
      expect(get: "/billionaires/1").to route_to("billionaires#show", id: "1")
    end


    it "routes to #create" do
      expect(post: "/billionaires").to route_to("billionaires#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/billionaires/1").to route_to("billionaires#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/billionaires/1").to route_to("billionaires#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/billionaires/1").to route_to("billionaires#destroy", id: "1")
    end
  end
end
