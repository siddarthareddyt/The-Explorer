using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using TheExplorer.ExplorerService1;
using TheExplorer.StoreService;
using TheExplorer.InstaPicService;
using TheExplorer.CrimeService;
using TheExplorer.TripService;
using System.Net;
using System.IO;
using System.Xml;

namespace TheExplorer.Members
{
    public partial class Members : System.Web.UI.Page
    {
        //Remote Service Reference
        WSDLDiscovery wsdlService;
        NearestStoreDeal nearestStoreService;
        InstaPicService.Service1Client instaPic;
        CrimeService.Service1Client crimeService;
        TripService.Service1 tripService;


        //List to maintain selected preferences
        List<String> selectedItems = new List<string>();
        List<String> selectedCheckBoxes = new List<string>();

        Result[] stores = null;
        SearchListing[] dealsStores = null;
        protected void Page_Load(object sender, EventArgs e)
        {
            //If authenticated and has appropriate roles, display page
            if (User.Identity.IsAuthenticated && User.IsInRole("Member"))
            {
                UserName.Text = "Welcome "+User.Identity.Name;
                wsdlService = new WSDLDiscovery();
                nearestStoreService = new NearestStoreDeal();
                instaPic = new InstaPicService.Service1Client();
                crimeService = new CrimeService.Service1Client();
                tripService = new TripService.Service1();

            }
            else {
                //Else redirect to Login
                Response.Redirect("~/Login.aspx");
            }
            
        }

        //Logout
        protected void LogoutClicked(object sender, EventArgs e) {
            FormsAuthentication.SignOut();
            Session.Clear();
            Response.Redirect("~/Default.aspx");
        }

        protected void OnLocationClick(object sender, EventArgs e)
        {
            string[] currentLocationDetails = new string[5];
            String getLocationUrl = "http://webstrar33.fulton.asu.edu/page10/Service1.svc/getUserCurrentLocation";

            try
            {
                //url is built
                WebRequest locationRequest = WebRequest.Create(getLocationUrl);
                //georequest is the request made to obtain user current location details
                locationRequest.Credentials = CredentialCache.DefaultCredentials;
                WebResponse locationResponse = locationRequest.GetResponse();
                //georesponse is the response received for the request georequest
                Stream locationDataStream = locationResponse.GetResponseStream();
                XmlDocument locationXmlDoc = new XmlDocument();
                locationXmlDoc.Load(locationDataStream);

                XmlNodeList locationNode = locationXmlDoc.GetElementsByTagName("ArrayOfstring");
                XmlNodeList locationChildNodes = locationNode[0].ChildNodes;
                string currentZipCode = locationChildNodes[0].InnerXml;
                zipCodeTxt.Text = currentZipCode;
            }
            catch
            {
                currentLocationError.Text = "Error in getting current location. Try Again";
                currentLocationError.Visible = true;
            }
            

        }

        protected void trip_CheckedChanged(object sender, EventArgs e) {
            if (tripCheck.Checked)
            {
                fromId.Visible = true;
                toId.Visible = true;
            }
            else {
                fromId.Visible = false;
                toId.Visible = false;
            }

        }

        /*
         Handler to add a checkbox whenever they are selected
             */
        protected void setSelectedCheckboxes()
        {
            if (weatherCheck.Checked && !selectedCheckBoxes.Contains("Weather"))
                selectedCheckBoxes.Add("Weather");
            if ((nearestStoreCheck.Checked || dealsCheck.Checked) && !selectedCheckBoxes.Contains("NearestStore"))
                selectedCheckBoxes.Add("NearestStore");
            if (eventCheck.Checked && !selectedItems.Contains("Events"))
                selectedCheckBoxes.Add("Events");
            if (instaCheck.Checked)
                selectedCheckBoxes.Add("InstaPics");
            if (crimeCheck.Checked)
                selectedCheckBoxes.Add("CrimeIndex");
            if (tripCheck.Checked && !selectedCheckBoxes.Contains("Trip"))
                selectedCheckBoxes.Add("Trip");

        }

        //Resets the UI before a request
        protected void resetUi() {
            NoResultsWeather.Visible = false;
            ErrorWeather.Visible = false;
            FirstMessage.Visible = true;
            WeatherTable.Visible = false;

            NoresultsStores.Visible = false;
            ErrorStores.Visible = false;
            storesTable.Visible = false;
            nearestStoreDisplay.Visible = false;

            NoresultsEvents.Visible = false;
            ErrorEvents.Visible = false;
            EventTable.Visible = false;
            eventsDisplay.Visible = false;

            NoresultsInsta.Visible = false;
            instaDisplay.Visible = false;
            instaPics.Visible = false;

            NoresultsCrime.Visible = false;
            crimeDisplay.Visible = false;
            crimeData.Visible = false;

            NoresultsTrip.Visible = false;
            ErrorTrip.Visible = false;
            tripDisplay.Visible = false;
            tripTable.Visible = false;



        }

        protected void chkLinked_CheckedChanged(object sender, EventArgs e)
        {
            if (nearestStoreCheck.Checked || dealsCheck.Checked) {
                preferenceLabel.Visible = true;
                queryBox.Visible = true;
            }else
            {
                preferenceLabel.Visible = false;
                queryBox.Visible = false;
            }
            
        }

        protected void event_CheckedChanged(object sender, EventArgs e)
        {
            if (eventCheck.Checked)
            {
                preferenceLabel.Visible = true;
                eventBox.Visible = true;
            }
            else
            {
                eventBox.Visible = false;
            }

        }

        
        protected void Button1_Click(object sender, EventArgs e)
        {
            //Zip code entered by the user
            string zipCode = zipCodeTxt.Text.Trim();

            setSelectedCheckboxes();
            
            //To reset the UI
            resetUi();

            if (!string.IsNullOrEmpty(zipCode))
            {
                Address address = nearestStoreService.GetLocationFromAdress(zipCode);

                //If there is any preference selected
                if (selectedCheckBoxes.Count>0)
                {
                    //The weather remote service is implemented as of now.
                    if (selectedCheckBoxes.Contains("Weather"))
                    {
                        //Get the 6 day weather data from the remote service
                        string[] weatherReport = wsdlService.Weather5Day(zipCode);
                        if (weatherReport.Length > 0)
                        {
                            //Display the data
                            FirstMessage.Visible = false;
                            WeatherTable.Visible = true;
                            WeatherTable.Caption = "Weather Report for "+zipCode;
                            for (int i = 0; i < weatherReport.Length; i++)
                            {
                                WeatherTable.Rows[i].Cells[0].Text = weatherReport[i];
                            }
                        }
                        else
                        {
                            NoResultsWeather.Visible = true;
                        }
                    }

                    if (nearestStoreCheck.Checked || dealsCheck.Checked)
                    {
                        nearestStoreDisplay.Visible = true;
                        string[] preferences = queryBox.Text.Trim().Split(' ');

                        if (dealsCheck.Checked)
                        {
                            dealsStores = nearestStoreService.GetNearestDeal(preferences==null||preferences.Count()<1? null:preferences[0], zipCode);
                        }
                        else
                        {
                            stores = nearestStoreService.GetNearestStores(preferences, zipCode);
                        }


                        if (!dealsCheck.Checked)
                        {
                            if (stores == null || stores.Count() < 1)
                            {
                                NoresultsStores.Text = "No stores returned. Please refine your search.";
                                NoresultsStores.Visible = true;
                            }
                            else
                            {
                                storesTable.Visible = true;
                                storesTable.Caption = "Stores Nearby "+ zipCode;
                                for (int i = 0; i < stores.Count(); i++)
                                {
                                    if (i<5) {
                                        string openNow = stores[i].opening_hours != null ? stores[i].opening_hours.open_now != null ? "Yes" : "No" : "No";

                                        storesTable.Rows[i].Cells[0].Text += "Store:" + stores[i].name + "  Address: " + stores[i].formatted_address + "  Open now" + openNow + "  rating:" + stores[i].rating;
                                    }
                                    
                                     
                                }

                            }

                        }
                        else
                        {
                            if (dealsStores == null || dealsStores.Count() < 1)
                            {
                                NoresultsStores.Text = "No deals returned. Please refine your search.";
                                NoresultsStores.Visible = true;
                            }
                            else {
                                for (int i = 0; i < dealsStores.Count(); i++)
                                {
                                    Coupon[] coupons = null;
                                    if (dealsStores[i].coupons != null)
                                    {
                                        storesTable.Visible = true;
                                        storesTable.Caption = "Deals in "+ zipCode;
                                        coupons = dealsStores[i].coupons.coupon;
                                        if (coupons != null && coupons.Count() > 0 && i<5)
                                        {

                                            try
                                            {
                                                storesTable.Rows[i].Cells[0].Text += "Coupon:" + coupons[0].couponTitle + "  Description: " + coupons[i].couponDescription + "  startDate:" + coupons[i].couponStartDate + "  Disclaimer:" + coupons[i].couponDisclaimer + " Place:" + dealsStores[i].businessName + " " + dealsStores[i].city + " Distance: " + dealsStores[i].distance + "<br/>";
                                            }
                                            catch
                                            {
                                                Console.WriteLine("Exception at parsing");
                                            }
                                            
                                        }

                                    }
                                    
                                }
                            }
                               
                        }

                    }

                    if (eventCheck.Checked) {
                        eventsDisplay.Visible = true;
                        Preferences preference = new Preferences();
                        string query = eventBox.Text.Trim();
                        preference.address = zipCode;
                        preference.searchQuery = query;
                        Event[] events = null;

                        events = nearestStoreService.GetLocalEvents(preference);        //gets events

                        if (events == null || events.Count() < 1)
                        {
                            NoresultsEvents.Text = "No events found for your preference. Please refine it.";
                            NoresultsEvents.Visible = true;
                        }
                        else
                        {
                            EventTable.Visible = true;
                            EventTable.Caption = "Events Happening in "+ zipCode;
                            for (int i = 0; i < events.Count(); i++)
                            {
                                if(i<5)
                                    EventTable.Rows[i].Cells[0].Text += "<b>EventName:</b> " + events[i].title + "<b> Description:</b>" + events[i].description + " <b>address:</b>" + events[i].venue_address + " <b>starttime:</b>" + events[i].start_time + " <b>endtime:</b>" + events[i].stop_time  + " <b>price:</b>" + events[i].price+" <a href="+events[i].url+">Click forFurther Info</a>";
                            }
                        }
                    }

                    if (instaCheck.Checked)
                    {
                        instaDisplay.Visible = true;
                        
                        string[] imageUrls = null;
                        if (address != null)
                            imageUrls = instaPic.GetImages(address.geometry.location.lng,address.geometry.location.lat);
                        if (imageUrls != null && imageUrls.Count() > 0) {
                            string image = null;
                            for (int i = 0; i < imageUrls.Length; i++)
                            {
                                if (i<4)
                                    image = image + "<img src=" + imageUrls[i] + " style=\"width:304px;height:228px;\"> <br \\><br \\>";
                            }
                            instaPics.InnerHtml = image;
                            instaPics.Visible = true;
                        }
                        else
                        {
                            NoresultsInsta.Text = "No Images for selected Place. Try again";
                            NoresultsInsta.Visible = true;
                        }
                        

                    }

                    if (crimeCheck.Checked)
                    {
                        crimeDisplay.Visible = true;
                        string crime = crimeService.GetCrimeIndex(address.geometry.location.lng,address.geometry.location.lat);
                        if (string.IsNullOrEmpty(crime))
                        {
                            NoresultsCrime.Text = "No Crime Data Available for given Place. Try again";
                            NoresultsCrime.Visible = true;
                        }
                        else
                        {
                            crimeData.InnerHtml = crime;
                            crimeData.Visible = true;

                        }
                        

                    }

                    if (tripCheck.Checked) {
                        string[] tripDetails = new string[4];
                        tripDetails = tripService.getTripDetails(fromId.Text.Trim(), toId.Text.Trim());

                        if (tripDetails == null || tripDetails.Count() < 0)
                            NoresultsTrip.Text = "No Trip Details Available. Please try different";
                        else
                        {
                            tripDisplay.Visible = true;
                            tripTable.Visible = true;
                            tripTable.Caption = "Trip Estimation from "+ fromId.Text +" to "+toId.Text;
                            tripTable.Rows[0].Cells[0].Text = "Distance: " + tripDetails[0];
                            tripTable.Rows[1].Cells[0].Text = "Time: " + tripDetails[1];
                            tripTable.Rows[2].Cells[0].Text = "Fare: " + tripDetails[2]+" USD";
                            tripTable.Rows[3].Cells[0].Text = "Traffic Condition: " + tripDetails[3];

                        }
                    }

                }
                else
                {
                    ErrorWeather.Text = "Select atleast one preference to Search.";
                    ErrorWeather.Visible = true;

                }
            }
            else {
                ErrorWeather.Text = "Enter a zip Code";
                ErrorWeather.Visible = true;
                FirstMessage.Visible = false;
            } 
        }
    }
}