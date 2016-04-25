using UnityEngine;
using System.Collections;
using System;
using System.IO;
using System.Runtime.Serialization.Formatters.Binary;

public class LocalDataBase {

    static public bool isLoadedB4() {
        return File.Exists(Application.persistentDataPath + "/FishData.info");
    }

    static public void Save(MyClass myObject) {
        BinaryFormatter bf = new BinaryFormatter();
        FileStream file = File.Create(Application.persistentDataPath + "/FishData.info");
        Debug.Log(Application.persistentDataPath + "/FishData.info");
        bf.Serialize(file, myObject);
        file.Close();
    }

    static public void Load(ref MyClass myObject) {
        if (File.Exists(Application.persistentDataPath + "/FishData.info")) {
            BinaryFormatter bf = new BinaryFormatter();
            FileStream file = File.Open(Application.persistentDataPath + "/FishData.info", FileMode.Open);
            myObject = (MyClass)bf.Deserialize(file);
            file.Close();
        }
    }
}
