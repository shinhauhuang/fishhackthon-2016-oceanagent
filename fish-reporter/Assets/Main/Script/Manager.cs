using UnityEngine;
using System.Collections;
using UnityEngine.UI;
using System.Collections.Generic;

public class Manager : MonoBehaviour {

    static public Manager instance;

    // panels
    public GameObject DownPanel;
    public GameObject UpPanel;
    public GameObject AlarmPanel;

    // main scene message
    public Text DownMessage;
    public Text UpMessage;
    public Text LostMessage;
    public Text AlarmMessage;

    // inner message
    public Text DownCntMessage;
    public Text UpCntMessage;
    public Text AlarmInnerMessage;

    // used lightbulb
    public List<UsedGear> DownGears;
    public List<UsedGear> UpGears;

    // send count
    public int sendcount = 0;

    private float timer;
    private bool goFlag = true;
    private int stages = 0;

    void Awake () {
        instance = this;
        DownGears = new List<UsedGear>();
        UpGears = new List<UsedGear>();
    }

    void Start() {
    }
	
	void Update () {
        
    }

    public void DownPanelClick() {
        DownPanel.SetActive(true);
    }

    public void UpPanelClick()
    {
        UpPanel.SetActive(true);
    }

    public void AlarmPanelClick()
    {
        AlarmPanel.SetActive(true);
        sendAlarmToServer();
    }

    public void ReturnClick() {
        if (DownPanel.activeSelf) {
            DownMessage.text = DownGears.Count.ToString();
        }
        if (UpPanel.activeSelf)
        {
            UpMessage.text = UpGears.Count.ToString();
            LostMessage.text = (DownGears.Count - UpGears.Count).ToString();
        }

        // lost number
        DownPanel.SetActive(false);
        UpPanel.SetActive(false);
        AlarmPanel.SetActive(false);
    }

    public void AddoneClick() {
        if (DownPanel.activeSelf) {
            DownGears.Add(new UsedGear("123", "123", "123"));
            DownCntMessage.text = DownGears.Count.ToString();
        }
        if (UpPanel.activeSelf) {
            UpGears.Add(new UsedGear("123", "123", "123"));
            UpCntMessage.text = UpGears.Count.ToString();
        }
    }

    public void LeaveClick() {
        Application.Quit();
    }

    public void sendAlarmToServer() {
        for (int i = 0; i < DownGears.Count; i++) {
            bool Matched = false;
            for (int j = 0; j < UpGears.Count; j++) {
                if (DownGears[i]._gearId == UpGears[j]._gearId) {
                    Matched = true;
                }
            }
            if (!Matched) {
                ButtonScript.instance.SendData(DownGears[i]._gearId);
                sendcount++;
            }
        }
    }
}
