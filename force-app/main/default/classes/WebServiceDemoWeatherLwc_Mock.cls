//Mock Test CLass for WebServiceDemoweatherLWC 
//Created on : 15-Mar-2020
//Version : 1 
//Status Responces from : https://www.weatherbit.io/ StatusCode : 200 success & 0 Error 

@istest
Global class WebServiceDemoWeatherLwc_Mock implements HttpCalloutMock {
    
    global static String respType = '';
    global HTTPResponse respond(HTTPRequest req) {
        System.assertEquals(req.getMethod(), 'GET');
       
        HttpResponse res = new HttpResponse();
       if(respType.equalsIgnoreCase('success'))
       {
          res.setBody('{"response":{"current":{"data":[{ "wind_cdir":"NE", "rh":59, "pod":"d", "lon":"-78.63861","pres":1006.6, "timezone":"America", "ob_time":"2017-08-28 16:45", "country_code":"US", "clouds":75, "vis":10, "wind_spd":6.17, "wind_cdir_full":"northeast", "app_temp":24.25, "state_code":"NC", "ts":1503936000,"h_angle":0,"dewpt":15.65,"weather":{ "icon":"c03d","code":"803","description":"Broken clouds"}, "uv":2,"aqi":45,"station":"CMVN7", "wind_dir":50,"elev_angle":63, "datetime":"2017-08-28:17","precip":0,"ghi":444.4,"dni":500,"dhi":120,"solar_rad":350,"city_name":"Raleigh","sunrise":"10:44","sunset":"23:47","temp":24.19,"lat":"35.7721","slp":1022.2} ], "count":1 }}}');
           res.setHeader('Content-Type', 'application/json');  
            res.setStatusCode(200); 
       }
	       
        else if(respType.equalsIgnoreCase('error')){
            res.setBody('{"response":{"current":{"data":[{ "wind_cdir":"NE", "rh":59, "pod":"d", "lon":"-78.63861","pres":1006.6, "timezone":"America", "ob_time":"2017-08-28 16:45", "country_code":"US", "clouds":75, "vis":10, "wind_spd":6.17, "wind_cdir_full":"northeast", "app_temp":24.25, "state_code":"NC", "ts":1503936000,"h_angle":0,"dewpt":15.65,"weather":{ "icon":"c03d","code":"803","description":"Broken clouds"}, "uv":2,"aqi":45,"station":"CMVN7", "wind_dir":50,"elev_angle":63, "datetime":"2017-08-28:17","precip":0,"ghi":444.4,"dni":500,"dhi":120,"solar_rad":350,"city_name":"Raleigh","sunrise":"10:44","sunset":"23:47","temp":24.19,"lat":"35.7721","slp":1022.2} ], "count":1 }}}');
            res.setHeader('Content-Type', 'application/json');
             res.setStatusCode(0); 
        }
        else 
        {
            res.setStatusCode(0); 
        }
           return res;
         
       
    }

    
}