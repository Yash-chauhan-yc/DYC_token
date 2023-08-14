import Principal "mo:base/Principal";
import HashMap "mo:base/HashMap";
import Debug "mo:base/Debug";
import Iter "mo:base/Iter";




actor Token{
    Debug.print("Hello");

    let owner : Principal = Principal.fromText("xtygr-4mase-256ri-7q535-lgfop-eklf5-bv6z3-ynygf-fiibh-lk66m-wqe");
    let totalSupply : Nat = 1000000000;
    let symbol : Text = "DYC";

    // array of tuples
    private stable var balanceEntries : [(Principal, Nat)] = [];
    private var balances = HashMap.HashMap<Principal, Nat>(1, Principal.equal, Principal.hash);

    // balances.put(owner, totalSupply);

    public query func balanceOf(who: Principal): async Nat{

        // if(balances.get(who) == null)
        // {
        //     return 0;
        // }
        // else
        // {
            // there is a problem with this, it ouputs a data type of ? and instead of Nat
        //     return balance.get(who);   
        // }
        
        let balance : Nat = switch(balances.get(who)){
            case null 0;
            case (?result) result;
        };
        return balance;  
    };

    public query func getSymbol() : async Text{
        return symbol;
    };


    public shared(msg) func payOut() : async Text {
        // Debug.print(debug_show(msg.caller));

        if(balances.get(msg.caller) == null)
        {
            let amount = 10000;
            // balances.put(msg.caller, amount);
            // return "Sucess";
            let result = await transfer(msg.caller, amount);
            return result;
        }
        else
        {
            return "Already Claimed"; 
        }
    };

    public shared(msg) func transfer(to: Principal, amount: Nat): async Text{
        let fromBalance = await balanceOf(msg.caller);
        if(fromBalance > amount)
        {
            let newFromBalance : Nat = fromBalance - amount;
            balances.put(msg.caller, newFromBalance);

            let toBalance = balanceOf(to);
            let newToBalance : Nat = fromBalance + amount;
            balances.put(to, newToBalance);

            return "success";
        }
        else
        {
            return "insufficient Funds";
        }
    };


    system func preupgrade()
    {
        balanceEntries := Iter.toArray(balances.entries());
    };

    system func postupgrade()
    {
        balances := HashMap.fromIter<Principal, Nat>(balanceEntries.vals(), 1, Principal.equal, Principal.hash);
        if(balances.size() < 1)
        {
            balances.put(owner, totalSupply);
        }
    };
}