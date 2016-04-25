using UnityEngine;
using System.Collections;
using UnityEngine.UI;

public class GoogleMap4Nexus : MonoBehaviour {

    // Ui 
    public Image mapImage;

    public enum MapType
    {
        RoadMap,
        Satellite,
        Terrain,
        Hybrid
    }
    public bool loadOnStart = true;
    public bool autoLocateCenter = true;
    public GoogleMapLocation centerLocation;
    public int zoom = 13;
    public MapType mapType;
    public int size = 512;
    public bool doubleResolution = false;
    public GoogleMapMarker[] markers;
    public GoogleMapPath[] paths;

    void Start()
    {
        Debug.Log("start");
        if (loadOnStart) Refresh();
    }

    public void Refresh()
    {
        if (autoLocateCenter && (markers.Length == 0 && paths.Length == 0))
        {
            Debug.LogError("Auto Center will only work if paths or markers are used.");
        }
        StartCoroutine(_Refresh());
    }

    IEnumerator _Refresh()
    {
        Debug.Log("_Refresh");
        var url = "http://maps.googleapis.com/maps/api/staticmap";
        var qs = "";
        if (!autoLocateCenter)
        {
            if (centerLocation.address != "")
            {
                Debug.Log("centerLocation.address = " + centerLocation.address);
                qs += "center=" + WWW.UnEscapeURL(centerLocation.address);
            }

            else {
                Debug.Log("centerLocation.address = null");
                qs += "center=" + WWW.UnEscapeURL(string.Format("{0},{1}", centerLocation.latitude, centerLocation.longitude));
            }
            qs += "&zoom=" + zoom.ToString();
        }
        qs += "&size=" + WWW.UnEscapeURL(string.Format("{0}x{0}", size));
        qs += "&scale=" + (doubleResolution ? "2" : "1");
        qs += "&maptype=" + mapType.ToString().ToLower();
        var usingSensor = false;
#if UNITY_IPHONE
		usingSensor = Input.location.isEnabledByUser && Input.location.status == LocationServiceStatus.Running;
#endif
        qs += "&sensor=" + (usingSensor ? "true" : "false");

        foreach (var i in markers)
        {
            qs += "&markers=" + string.Format("size:{0}|color:{1}|label:{2}", i.size.ToString().ToLower(), i.color, i.label);
            foreach (var loc in i.locations)
            {
                if (loc.address != "")
                    qs += "|" + WWW.UnEscapeURL(loc.address);
                else
                    qs += "|" + WWW.UnEscapeURL(string.Format("{0},{1}", loc.latitude, loc.longitude));
            }
        }

        foreach (var i in paths)
        {
            qs += "&path=" + string.Format("weight:{0}|color:{1}", i.weight, i.color);
            if (i.fill) qs += "|fillcolor:" + i.fillColor;
            foreach (var loc in i.locations)
            {
                if (loc.address != "")
                    qs += "|" + WWW.UnEscapeURL(loc.address);
                else
                    qs += "|" + WWW.UnEscapeURL(string.Format("{0},{1}", loc.latitude, loc.longitude));
            }
        }

        var req = new WWW(url + "?" + qs);
        yield return req;
        //GetComponent<Renderer>().material.mainTexture = req.texture;
        //mapImage.material.mainTexture = req.texture;
        Rect rec = new Rect(0, 0, req.texture.width, req.texture.height);
        mapImage.sprite = Sprite.Create(req.texture, rec, new Vector2(0.5f, 0.5f), 100);
    }
}
