using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System.Net;
using System.IO;
using System.Text;

public class TestWWW : MonoBehaviour {

	public Material mat;

	//public const string C_URL = "http://172.23.1.118:8081/";
	//public const string C_URL = "https://upload.wikimedia.org/wikipedia/commons/e/ee/AFE_locomotora_2004.jpg";
	public const string C_URL = "http://news.qq.com/a/20161219/001148.htm";

	// Use this for initialization
	void Start () {
		string outResult = string.Empty;

		Debug.Log ("Begin Web");

		WebClient wc = new WebClient ();
		//wc.Credentials = CredentialCache.DefaultCredentials;

        Stream resStream = wc.OpenRead(C_URL);
        Encoding enc = Encoding.UTF8;

        StreamReader sr = new StreamReader(resStream, enc);

        outResult = sr.ReadToEnd();
        resStream.Close();

        Debug.Log (outResult);
	}
	
	// Update is called once per frame
	void Update () {
		
	}

	private void OpenRead(){
		string outResult = string.Empty;

		WebClient webClient = new WebClient ();
		Stream stream = webClient.OpenRead (C_URL);
		StreamReader streamReader = new StreamReader (stream);

		string strLine = "";
		while ((strLine = streamReader.ReadLine()) != null) {
			outResult += strLine;
		}
		streamReader.Close ();

		Debug.Log (outResult);
	}

}
