using UnityEngine;
using System.Collections;
using UnityEngine.UI;

public class GpsTest : MonoBehaviour
{

    public Text mText;
    public Text mTextMessage;

    private float _timer;
    private int cnt = 0;

    IEnumerator Start()
    {
        mText.text = "Enter Start";
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
            mText.text = "Timed out";
            yield break;
        }

        // Connection has failed
        if (Input.location.status == LocationServiceStatus.Failed)
        {
            //print("Unable to determine device location");
            mText.text = "Unable to determine device location";
            yield break;
        }
        else
        {
            // Access granted and location value could be retrieved
            mText.text = "Location: " + Input.location.lastData.latitude + " " + Input.location.lastData.longitude + " " + Input.location.lastData.altitude + " " + Input.location.lastData.horizontalAccuracy + " " + Input.location.lastData.timestamp;
            //print("Location: " + Input.location.lastData.latitude + " " + Input.location.lastData.longitude + " " + Input.location.lastData.altitude + " " + Input.location.lastData.horizontalAccuracy + " " + Input.location.lastData.timestamp);
        }

        // Stop service if there is no need to query location updates continuously
        //Input.location.Stop();
    }

    void Update()
    {
        _timer += Time.deltaTime;
        cnt++;
        mTextMessage.text = "Time: " + _timer;
        if (_timer > 0.5f) {
            if (Input.location.status != LocationServiceStatus.Failed)
            {
                mText.text = "cnt:"+ cnt + ", Location: " + Input.location.lastData.latitude + " " + Input.location.lastData.longitude + " " + Input.location.lastData.altitude + " " + Input.location.lastData.horizontalAccuracy + " " + Input.location.lastData.timestamp;
            }
            _timer = 0.0f;
        }
        
    }


}
