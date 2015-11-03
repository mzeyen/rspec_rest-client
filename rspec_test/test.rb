require 'rspec'
require 'rest_client'
require 'json'
require 'jsonpath'



describe 'Github' do
    
    it 'should return 200 with block' do
    RestClient.get ('http://admin:admin@agrohmann-vm3.intern.epages.de/epages/DemoShop.rest/api/products'){|response, request, result, &block |
    case response.code
    when 200
    response
    when 423
    p "Status differs"
    else
        response.return!(request, result, &block)
    end
    }
    end
    
    it 'should return 200' do
        result = RestClient.get 'http://admin:admin@agrohmann-vm3.intern.epages.de/epages/DemoShop.rest/api/products', :content_type => :json
        expect(result.code).to eq(200)
    end
    
    it 'should make a POST to the new MS-MVP' do
        result = RestClient.post 'http://wsadmin:wsadmin@agrohmann-vm3.intern.epages.de/epages/Store.rest/api/multi-stores/ms-products', {"subshop_products":{"subshops":[{"id":4,"alias":"TestShop1","url":"https://TestShop1","database_id":1,"guid":"22222"}],"products":[{"alias":"MS-Test-01-Product-66","taxclass":"normal","isnew":false,"isdailyprice":false,"orderunit":"piece","pricequantity":"1.0","minorder":"1.0","intervalorder":"1.0","weightunit":"kilogram","weight":"0.0","refunit":"piece","refamount":1,"refcontentamount":"1.0","stocklevel":"0.0","length":"0.0","height":"0.0","width":"0.0","isavailable":true,"imagemediumsmall":"005_s.jpg","imagemediumlarge":"005_m.jpg","imagelarge":"005.jpg","imagehotdeal":"005_h.jpg","hassubownprices":true,"upcean":"","isdownloadproduct":false,"position":0}]}}.to_json, 
        :content_type => 'application/json'
        guid = JSON.parse(result.body)['subshop_products'].first['products'].first['guid']
        p guid
        
        #Debug code
        #guid = JSON.parse("{\"subshop_products\":[{\"alias\":\"TestShop1\",\"products\":[{\"guid\":\"086BA938-8174-11E5-BB9C-005056021499\",\"epages6-objectid\":18362,\"alias\":\"MS-Test-01-Product-florri12\"}]}]}")
        #p guid
    end
end
