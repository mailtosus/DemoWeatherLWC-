// WebServiceDemoweatherLWC Class being called from DemoWeatherLWc 
//Created on : 15-Mar-2020
//Version : 1 
//This Class serves as connection point betweeen Weatherbit.io and slaesforce 
//weatherbit.io provided the weather data and salesforce makes rest call to GET Data 
//
//Two Type of Rest Calls in this call 
//
// Method 1 GetWeatherCalloutbyCity : call based on City name 
// Method 2 GetWeatherCalloutbylatlon: call based on Longitude and Latitude
// CalloutweatherLWC and CalloutonloadLWC to share vales to LWC after successfull call 
// CalloutweatherLWC : gets data based on City based on user selection from list
// CalloutonloadLWC: called on Initial LWC load and return current user location based on button click 
//Sample JSON and field description are after ENd of code for better understanding

Global class WEbServiceDemoWeatherLWC {
  
     
    	
 	 Global static Httpresponse GetWeatherCalloutbyCity(String city) {
         HttpRequest req = new HttpRequest();
        req.setEndpoint('callout:DemoWeatherAPI?city=' + city + '&key=0c4e8a163ee84604b336aff1b40dc20b');
        req.setMethod('GET');
        Http http = new Http();
        HTTPResponse res = http.send(req);
        return res;
  }
    
    Global static Httpresponse GetWeatherCalloutbylatlon(String lat, string lon) {
        HttpRequest req = new HttpRequest();
        req.setEndpoint('callout:DemoWeatherAPI?lat=' + lat + '&lon='+ lon +'&key=0c4e8a163ee84604b336aff1b40dc20b');
        req.setMethod('GET');
        Http http = new Http();
        HTTPResponse res = http.send(req);
        return res;
  }
    
    @AuraEnabled (cacheable=true)
    global static WeatherLWCwrapper CalloutweatherLWC (String location) {
       	httpresponse res = GetWeatherCalloutbyCity(location);
        integer requeststatus = res.getStatusCode();
        WeatherLWCwrapper calloutresponse = new WeatherLWCwrapper();
        
        if (requeststatus == 200 ){
        string st = res.getbody();
        
        JSONParser parser = JSON.createParser(st);
        system.debug('test result'); 
       // system.debug(JSON.deserializeUntyped(res.getBody()));
        system.debug(parser);
		 while (parser.nextToken() != null) {
            if(parser.getCurrentToken() == JSONToken.FIELD_NAME) {
                parser.nextValue();
                if (parser.getCurrentName() == 'temp') {
                    calloutresponse.cityTemp = Decimal.valueOf(parser.getText());
                } else if (parser.getCurrentName() == 'city_name') {
                  calloutresponse.cityName = parser.getText();
                } else if (parser.getCurrentName() == 'state_code') {
                calloutresponse.state = parser.getText();
                } else if (parser.getCurrentName() == 'timezone') {
                    calloutresponse.cityTimeZone = parser.getText();
                } else if (parser.getCurrentName() == 'wind_spd') {
                   calloutresponse.cityWindSpeed = Decimal.valueOf(parser.getText());
                } else if (parser.getCurrentName() == 'lat') {
                   calloutresponse.cityLat = parser.getText();
                } else if (parser.getCurrentName() == 'lon') {
            	 calloutresponse.cityLong = parser.getText();
                } else if (parser.getCurrentName() == 'precip') {
                 calloutresponse.cityPrecip = Decimal.valueOf(parser.getText());
                }
                else if (parser.getCurrentName() == 'rh') {
                    calloutresponse.cityhumidity = Decimal.valueOf(parser.getText());
                   }      
            }
        }
        }
        else {
            
            calloutresponse.errorcode = 'Error in callout';
             LogUtils.createLogs('Error in callout : '+res.getbody() );
            
        }
        
        return calloutresponse;
        
        
    }
   
   
    @AuraEnabled (cacheable=true)
    global static WeatherLWCwrapper CalloutonloadLWC (String lat, String lon) {
        
        httpresponse res = GetWeatherCalloutbylatlon (lat,lon);
         integer requeststatus =res.getStatusCode();
         WeatherLWCwrapper calloutresponse = new WeatherLWCwrapper();
        if(requeststatus== 200 ){
        string sm = res.getbody();
        JSONParser parser = JSON.createParser(sm);
        system.debug('test result'); 
        //system.debug(JSON.deserializeUntyped(sm));
 
       
 
        while (parser.nextToken() != null) {
            if(parser.getCurrentToken() == JSONToken.FIELD_NAME) {
                parser.nextValue();
                if (parser.getCurrentName() == 'temp') {
                    calloutresponse.cityTemp = Decimal.valueOf(parser.getText());
                } else if (parser.getCurrentName() == 'city_name') {
                  calloutresponse.cityName = parser.getText();
                } else if (parser.getCurrentName() == 'state_code') {
                calloutresponse.state = parser.getText();
                } else if (parser.getCurrentName() == 'timezone') {
                    calloutresponse.cityTimeZone = parser.getText();
                } else if (parser.getCurrentName() == 'wind_spd') {
                   calloutresponse.cityWindSpeed = Decimal.valueOf(parser.getText());
                } else if (parser.getCurrentName() == 'lat') {
                   calloutresponse.cityLat = parser.getText();
                } else if (parser.getCurrentName() == 'lon') {
          		calloutresponse.cityLong = parser.getText();
                } else if (parser.getCurrentName() == 'precip') {
                 calloutresponse.cityPrecip = Decimal.valueOf(parser.getText());
                }
                else if (parser.getCurrentName() == 'rh') {
                    calloutresponse.cityhumidity = Decimal.valueOf(parser.getText());
                   }
            }
        }
        }
        else {
            calloutresponse.errorcode = 'Error in callout';
             LogUtils.createLogs('Error in callout : '+res.getbody() );
        }
        return calloutresponse;
    }
    


 //Wrapper Class to Return Values 
    global class WeatherLWCwrapper {
        @AuraEnabled public String cityName;
        @AuraEnabled public String cityTimeZone;
        @AuraEnabled public Decimal cityTemp;
        @AuraEnabled public String state;
        @AuraEnabled public Decimal cityWindSpeed;
        @AuraEnabled public String cityLat;
        @AuraEnabled public String cityLong;
        @AuraEnabled public Decimal cityPrecip;
        @AuraEnabled public Decimal cityhumidity;
        @AuraEnabled public string errorcode; 
    }
}


/*
Sample JSON : 
Documentation : weatherbit.io/api/weather-current
   {  
               "data":[  
                  {  
                     "wind_cdir":"NE",
                     "rh":59,
                     "pod":"d",
                     "lon":"-78.63861",
                     "pres":1006.6,
                     "timezone":"America\/New_York",
                     "ob_time":"2017-08-28 16:45",
                     "country_code":"US",
                     "clouds":75,
                     "vis":10,
                     "wind_spd":6.17,
                     "wind_cdir_full":"northeast",
                     "app_temp":24.25,
                     "state_code":"NC",
                     "ts":1503936000,
                     "h_angle":0,
                     "dewpt":15.65,
                     "weather":{  
                        "icon":"c03d",
                        "code":"803",
                        "description":"Broken clouds"
                     },
                     "uv":2,
                     "aqi":45,
                     "station":"CMVN7",
                     "wind_dir":50,
                     "elev_angle":63,
                     "datetime":"2017-08-28:17",
                     "precip":0,
                     "ghi":444.4,
                     "dni":500,
                     "dhi":120,
                     "solar_rad":350,
                     "city_name":"Raleigh",
                     "sunrise":"10:44",
                     "sunset":"23:47",
                     "temp":24.19,
                     "lat":"35.7721",
                     "slp":1022.2
                  }
               ],
               "count":1
            }

        Field Description : 
        count: Count of returned observations.
        data: [
        lat: Latitude (Degrees).
        lon: Longitude (Degrees).
        sunrise: Sunrise time (HH:MM).
        sunset: Sunset time (HH:MM).
        timezone: Local IANA Timezone.
        station: Source station ID.
        ob_time: Last observation time (YYYY-MM-DD HH:MM).
        datetime: Current cycle hour (YYYY-MM-DD:HH).
        ts: Last observation time (Unix timestamp).
        city_name: City name.
        country_code: Country abbreviation.
        state_code: State abbreviation/code.
        pres: Pressure (mb).
        slp: Sea level pressure (mb).
        wind_spd: Wind speed (Default m/s).
        wind_dir: Wind direction (degrees).
        wind_cdir: Abbreviated wind direction.
        wind_cdir_full: Verbal wind direction.
        temp: Temperature (default Celcius).
        app_temp: Apparent/"Feels Like" temperature (default Celcius).
        rh: Relative humidity (%).
        dewpt: Dew point (default Celcius).
        clouds: Cloud coverage (%).
        pod: Part of the day (d = day / n = night).
        weather: {
        icon:Weather icon code.
        code:Weather code.
        description: Text weather description.
        }
        vis: Visibility (default KM).
        precip: Liquid equivalent precipitation rate (default mm/hr).
        snow: Snowfall (default mm/hr).
        uv: UV Index (0-11+).
        aqi: Air Quality Index [US - EPA standard 0 - +500]
        dhi: Diffuse horizontal solar irradiance (W/m^2) [Clear Sky]
        dni: Direct normal solar irradiance (W/m^2) [Clear Sky]
        ghi: Global horizontal solar irradiance (W/m^2) [Clear Sky]
        solar_rad: Estimated Solar Radiation (W/m^2).
        elev_angle: Solar elevation angle (degrees).
        h_angle: Solar hour angle (degrees).
        ]

*/