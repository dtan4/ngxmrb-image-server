require "spec_helper"

describe server(:target) do
  describe http("http://target/") do
    it "responds OK 200" do
      expect(response.status).to eq 200
    end

    it "responds content including welcome message" do
      expect(response.body).to include "Welcome to nginx!"
    end
  end

  describe http("http://target/hello") do
    it "responds OK 200" do
      expect(response.status).to eq 200
    end

    it "responds content including welcome message" do
      expect(response.body).to include "Welcome to ngx_mruby world!"
    end
  end
end
