using UnityEngine;
using System.Collections;
using UnityEngine.UI;
using System.Collections.Generic;
using System;
using System.IO;
using System.Runtime.Serialization.Formatters.Binary;

[Serializable]
public class MyClass
{
    public string id;
    [SerializeField]
    public List<Gear> gears;
}

[Serializable]
public class Gear {
    public string gearId;
    public string gearImage; // url to get the image
    public string type;
    public int createdTime;
    public int updatedTime;
    public int state;
}

public class UsedGear {
    public string _gearId;
    public string _latitude;
    public string _longitude;

    public UsedGear(string gearId, string latitude, string longitude) {
        _gearId = gearId;
        _latitude = latitude;
        _longitude = longitude;
    }
}

public class ButtonScript : MonoBehaviour
{
    // singleton
    static public ButtonScript instance;

    // Ui
    public Text Message;

    // server client data
    MyClass myObject;
    private string username = "CT5566";

    string token = "token=MTEzMjU5OTkwOUNBQUNFZEVvc2UwY0JBSURaQW91UXpSWXVIek9zN2ZPeW9JczVVQVpDTk96UnJSSkI1cVc0Z1pBY1lCWkJSczVaQVpBUEtuYWZUUkhueXpwWFVLR1VaQ3VTSHlIbmVud09YcXk0WkIwWkI0eUptbFJoSlU1b1htODkzWGNMOG5IWTgwWEpSM0F6UlpCRFpBWkMxa1pBRGl3cVpBQ3lyWkE5ZnJBVEg4SHNqM1dUTkJKcGJJMzlDUzQ1c1hEeVdTb3FHUPARKINGLUCKLOVEPARKING";

    void Awake() {
        instance = this;
    }

    void Start()
    {
        myObject = new MyClass();
        
        // load data from server at the first time
        // or load data from local resource
        if (LocalDataBase.isLoadedB4())
        {
            // already have info
            loadLocalData();
            Message.text = "您共有" + myObject.gears.Count + "顆光球";
        }
        else {
            // needs to be download from server
            logIn();
        }
        
    }

    IEnumerator WaitForRequest(WWW www)
    {
        yield return www;
        // check for errors
        if (www.error == null)
        {
            myObject = JsonUtility.FromJson<MyClass>(www.data);
            // save
            LocalDataBase.Save(myObject);
        }
        else {
            Debug.Log("WWW Error: " + www.error);
        }
    }

    IEnumerator GetGPS()
    {
        //message.text = "Enter Start";
        // First, check if user has location service enabled
        if (!Input.location.isEnabledByUser)
            yield break;

        // Start service before querying location
        Input.location.Start();

        // Wait until service initializes
        int maxWait = 20;
        while (Input.location.status == LocationServiceStatus.Initializing && maxWait > 0)
        {
            yield return new WaitForSeconds(1);
            maxWait--;
        }

        // Service didn't initialize in 20 seconds
        if (maxWait < 1)
        {
            //print("Timed out");
            //mText.text = "Timed out";
            yield break;
        }

        // Connection has failed
        if (Input.location.status == LocationServiceStatus.Failed)
        {
            //print("Unable to determine device location");
            //message.text = "Unable to determine device location";
            yield break;
        }
        else
        {
            // Access granted and location value could be retrieved
            //message.text = "Location: " + Input.location.lastData.latitude + " " + Input.location.lastData.longitude + " " + Input.location.lastData.altitude + " " + Input.location.lastData.horizontalAccuracy + " " + Input.location.lastData.timestamp;
            // print("Location: " + Input.location.lastData.latitude + " " + Input.location.lastData.longitude + " " + Input.location.lastData.altitude + " " + Input.location.lastData.horizontalAccuracy + " " + Input.location.lastData.timestamp);
            Debug.Log("Location: " + Input.location.lastData.latitude + " " + Input.location.lastData.longitude + " " + Input.location.lastData.altitude + " " + Input.location.lastData.horizontalAccuracy + " " + Input.location.lastData.timestamp);
        }

        // Stop service if there is no need to query location updates continuously
        Input.location.Stop();
    }

    public void getGPS()
    {
        Debug.Log("getGPS");
        StartCoroutine(GetGPS());
    }

    public void logIn()
    {
        Debug.Log("Login");
        //string id = "CT5566";
        string id = username;
        string url = "http://parkingluck.cloudas.info/pl1/rest/fishers?id=" + id + "&" + token;
        WWW www = new WWW(url);
        StartCoroutine(WaitForRequest(www));
    }

    public void loadLocalData()
    {
        LocalDataBase.Load(ref myObject);
    }

    public void SendData(string gearId)
    {
        string id = "CT5566";
        string url = "http://parkingluck.cloudas.info/pl1/rest/fishers/brokengear?id=" + id + "&gearId=" + gearId+ "&" + token;
        Debug.Log(url);
        WWW www = new WWW(url);
        StartCoroutine(WaitForRequest2(www));
    }

    IEnumerator WaitForRequest2(WWW www)
    {
        yield return www;
        // check for errors
        if (www.error == null)
        {
            Debug.Log("WWW Ok!: " + www.data);
            Manager.instance.sendcount--;
            if (Manager.instance.sendcount <= 0) {
                Manager.instance.AlarmPanel.SetActive(false);
                Manager.instance.AlarmMessage.text = "已通報";
            }
        }
        else {
            Debug.Log("WWW Error: " + www.error);
            Manager.instance.sendcount--;
            if (Manager.instance.sendcount <= 0)
            {
                Manager.instance.AlarmPanel.SetActive(false);
                Manager.instance.AlarmMessage.text = "通報失敗，請重試";
            }
        }
    }
}
