//This Class is created to hold all Error logs 
//which makes eaiser error correction approaches 
//Created : 15-Mar_2020
//Version : 1 
//Currently being called From : WebserviceDemoWeatherLWC Class 
//

public class LogUtils{
    public static void createLogs(string message){
        Log__c objLog = new Log__c(Message__c=message);
        insert ObjLog;
    }
}