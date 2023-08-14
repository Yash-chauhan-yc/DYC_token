 import React, {useState} from "react";
// import { token_backend, canisterId, createActor } from "../../../declarations/token_backend";
import { AuthClient } from "@dfinity/auth-client";
import { token_backend } from "../../../declarations/token_backend/index";

function Faucet() {

  const [isDisabled, setDisable] = useState(false);
  const [buttonText, setText] = useState("Gimme Gimme");

  async function handleClick(event) {
    setDisable(true);

    // const authClient = await AuthClient.create();
    // const identity = await AuthClient.getIdentity();


    // const authenticatedCanister = createActor(canisterId, {
    //   agentOptions: {
    //     identity,
    //   },
    // });

    const result = await token_backend.payOut();
    setText(result);
    // setDisable(false);
  }

  return (
    <div className="blue window">
      <h2>
        <span role="img" aria-label="tap emoji">
          🛄
        </span>
        Faucet
      </h2>
      <label>Get your free DYC tokens here! Claim 10,000 DYC to your account.</label>
      <p className="trade-buttons">
        <button 
          id="btn-payout" 
          onClick={handleClick}
          disabled={isDisabled}>
          Claim
        </button>
      </p>
    </div>
  );
}

export default Faucet;
