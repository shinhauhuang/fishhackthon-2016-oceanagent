using UnityEngine;
using System.Collections;
using UnityEngine.SceneManagement;

public class LoginButton : MonoBehaviour {

	// Use this for initialization
	void Start () {
	
	}
	
	// Update is called once per frame
	void Update () {
	
	}

    public void Login() {
        SceneManager.LoadScene("Main");
    }
}
