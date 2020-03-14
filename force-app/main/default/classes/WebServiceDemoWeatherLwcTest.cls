// WebServiceDemoWeatherLwcTest Class being called to test WebServiceDemoWeatherLWC class  
//Created on : 15-Mar-2020
//Version : 1
//This class will make mock call to WebServiceDemoweatherLWC
//Method 1 :   to test Rest call for city parameter end point 
//Method 2 :   to test rest call for Longitude and lattitude baded  end point 
//Method 3 :   to Test success call of  calss method CalloutweatherLWC
//Method 4 :   to Test failure call of  calss method CalloutweatherLWC
//Method 5 :   to Test success call of  calss method CalloutonloadLWC
//Method 6 :   to Test failure call of  calss method CalloutonloadLWC


@isTest
public class WebServiceDemoWeatherLwcTest {

  
     @isTest static void testCityRestcallout() {
         Test.Starttest();
        // Set mock callout class 
        Test.setMock(HttpCalloutMock.class, new WebServiceDemoWeatherLwc_Mock());
         WebServiceDemoWeatherLwc_Mock.respType = 'Success';
           // Call method to test.
        // This causes a fake response to be sent
        // from the class that implements HttpCalloutMock. 
        string location = 'Raleigh';
        
      httpresponse res = WEbServiceDemoWeatherLWC.GetWeatherCalloutbyCity(location);
        
        // Verify response received contains fake values
        String contentType = res.getHeader('Content-Type');
         system.debug(contentType);
       // System.assert(contentType == 'application/json');
        String actualValue = res.getBody();
        System.assertEquals(200, res.getStatusCode());Test.StopTest();

         
    }
      @isTest static void testlatalonCallOut() {
          Test.Starttest();
        // Set mock callout class
         
        Test.setMock(HttpCalloutMock.class, new WebServiceDemoWeatherLwc_Mock());
          WebServiceDemoWeatherLwc_Mock.respType = 'Success';
          	 HttpRequest request1 = new HttpRequest();
          String lat = '35.7721';
          string lon = '-7863861'; 
           // Call method to test.
        // This causes a fake response to be sent
        // from the class that implements HttpCalloutMock. 
      httpresponse res1 = WEbServiceDemoWeatherLWC.GetWeatherCalloutbylatlon('35.7721','-78.63861');
        // Verify response received contains fake values
        String contentType = res1.getHeader('Content-Type');
         system.debug(contentType);
       // System.assert(contentType == 'application/json');
        String actualValue = res1.getBody();
        system.debug('lat lon test');
          system.debug(res1.getbody());
          
        System.assertEquals(200, res1.getStatusCode());
          Test.stoptest();
    }
    
     @isTest static void testCallout3() {
        // Set mock callout class 
        Test.Starttest();
        Test.setMock(HttpCalloutMock.class, new WebServiceDemoWeatherLwc_Mock());
       WebServiceDemoWeatherLwc_Mock.respType = 'Success';
   WEbServiceDemoWeatherLWC.WeatherLWCwrapper wc =    WEbServiceDemoWeatherLWC.CalloutweatherLWC('Raleigh');
    system.assertequals(wc.cityname,'Raleigh' );
         Test.StopTest();

    }
     @isTest static void testCallout4() {
        // Set mock callout class 
        Test.Starttest();
        Test.setMock(HttpCalloutMock.class, new WebServiceDemoWeatherLwc_Mock());
       WebServiceDemoWeatherLwc_Mock.respType = 'Error';
         
   WEbServiceDemoWeatherLWC.WeatherLWCwrapper wc =    WEbServiceDemoWeatherLWC.CalloutweatherLWC('');
    system.assertequals(wc.errorcode,'Error in callout' );
         Test.StopTest();

    }
     @isTest static void testCallout5() {
        // Set mock callout class
        	String lat = '35.7721';
          	string lon = '-78.63861'; 
        Test.Starttest();
        Test.setMock(HttpCalloutMock.class, new WebServiceDemoWeatherLwc_Mock());
       WebServiceDemoWeatherLwc_Mock.respType = 'Success';
   WEbServiceDemoWeatherLWC.WeatherLWCwrapper wc =    WEbServiceDemoWeatherLWC.CalloutonloadLWC(lat,lon);
    system.assertequals(wc.cityname,'Raleigh' );Test.StopTest();

    }
     @isTest static void testCallout6() {
        // Set mock callout class
        	String lat = '35.7721';
          string lon = '-7863861';  
        Test.Starttest();
        Test.setMock(HttpCalloutMock.class, new WebServiceDemoWeatherLwc_Mock());
       WebServiceDemoWeatherLwc_Mock.respType = 'Error';
         
   WEbServiceDemoWeatherLWC.WeatherLWCwrapper wc =    WEbServiceDemoWeatherLWC.CalloutonloadLWC(lat,lon);
    system.assertequals(wc.errorcode,'Error in callout' );
         Test.StopTest();

    }
    
}