import { LightningElement, track, api } from 'lwc';
import { loadStyle, loadScript } from 'lightning/platformResourceLoader';
import CalloutweatherLWC from '@salesforce/apex/WEbServiceDemoWeatherLWC.CalloutweatherLWC';
import CalloutonloadLWC from '@salesforce/apex/WEbServiceDemoWeatherLWC.CalloutonloadLWC';
import textdesign from '@salesforce/resourceUrl/textdesign';
 
export default class DemoWeatherLWC extends LightningElement {
 
    @track lat;
    @track long;
 
    @track mapMarkers = [];
   zoomLevel = 12;
    @track result;
    @track value;
    @track selectedMarkerValue
    @track toggleButtonLabel = 'My Current Location';
    @track placeholder ;

 //On load equivalent of LWC 
 //This loads user geo location on start

    connectedCallback() {
   
        this.currentlocation();
     
    
     }
       // Update the map marker on load and button click 
 
     currentlocation(){ 
        if (navigator.geolocation) {

            navigator.geolocation.getCurrentPosition((position)=>{
              console.log("position: ",position);
            console.log("position coords: ",position.coords);
            console.log("position coords lat: ",position.coords.latitude);
            
        
            CalloutonloadLWC ({ lat: position.coords.latitude,lon: position.coords.longitude}).then(data => {
                this.mapMarkers = [{
                    location: {
                        Latitude: data['cityLat'],
                        Longitude: data['cityLong']
                    }, 
                    title: 'My Current Location',
                }];
                this.result = data;
            }).catch(err => console.log(err));

            });
        }
        loadStyle(this, textdesign).then(result => {
            console.log('result :' , result);
        });

    }
    // Called on button click
    handleToggleClick(){
       this.currentlocation();
      
       this.value =this.placeholder;
    }

    // next get methods to set vlaues on page 
    get getCityName() {
        window.console.log('this titles : ',this.mapMarkers.title);
        if (this.result) {
            return this.result.cityName + ' Information';
        }  if(this.mapMarkers.title){
            return this.mapMarkers.title;
        } else {
            return '---'
        }
    }
    
 
    get getConvertedTemp() {
        if (this.result) {
            return Math.round((this.result.cityTemp * (9/5)) + 32) + ' deg F';
        } else {
            return '--'
        }
    }
 
    get getCurrentWindSpeed() {
        if (this.result) {
            return this.result.cityWindSpeed + ' MPH';
        } else {
            return '--'
        }
    }
 
    get getCurrentPrecip() {
        if (this.result) {
            return this.result.cityPrecip + " Inches"
        } else {
            return '--'
        }
    }
    get getCurrenthumidity() {
        if (this.result) {
            return this.result.cityhumidity + " %"
        } else {
            return '--'
        }
    }
    
    get options() {
        return [
            
            { label: 'Jaipur', value: 'Jaipur' },
            { label: 'Dubai', value: 'Dubai' },
            { label: 'Abu Dhabi', value: 'AbuDhabi' },
            { label: 'Sharjah', value: 'Sharjah' },
            { label: 'Delhi', value: 'Delhi' },
            { label: 'Mumbai', value: 'Mumbai' },
            { label: 'Muscat', value: 'Muscat' },
        ];
    }
    //called on selection of city values 
    handleChange(event) {
        this.value = event.detail.value;
        CalloutweatherLWC({location: this.value}).then(data => {
            this.mapMarkers = [{
                location: {
                    Latitude: data['cityLat'],
                    Longitude: data['cityLong']
                },
                title: data['cityName'] + ', ' + data['state'],
            }];
            this.result = data;
        }).catch(err => console.log(err));
    }

    // to handle marker change but currently get marker is limitiation of salesforce 
    handleMarkerSelect(event) {
        this.selectedMarkerValue = event.detail.selectedMarkerValue;
        window.console.log("selected marker values : ",this.selectedMarkerValue);
        window.console.log("selected marker values : ",event.detail.selectedMarkerValue);
    }

}