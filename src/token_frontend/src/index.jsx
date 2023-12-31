import ReactDOM from 'react-dom'
import React from 'react'
import App from "./components/App";
import { AuthClient } from "@dfinity/auth-client";


const init = async () => { 
    // ReactDOM.render(<App />, document.getElementById("root"));

    const authClient = await AuthClient.create();

    if(await authClient.isAuthenticated()){
          // console.log("Logged In");
          handleAuthenticated(authClient);
    }
    else
    {
      await authClient.login({
        identityProvider: "https://identity.ic0.app/#authorize",
        onSuccess: ()=>{
          // ReactDOM.render(<App />, document.getElementById("root"));
          handleAuthenticated(authClient);
        }
      });
    }
  }

async function handleAuthenticated(authClient)
{
  ReactDOM.render(<App />, document.getElementById("root"));
}


init();


