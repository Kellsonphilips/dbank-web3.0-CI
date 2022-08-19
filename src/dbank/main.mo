// To use the Debug, you have to import the liberary from motoko base
import Debug "mo:base/Debug";
import Time "mo:base/Time";
import Float "mo:base/Float";

// Creating a cannister that stores our data
actor DBank {
//creating a variable in motoko
  stable var currentValue: Float = 300;
// operator to use when assigning a new value to a variable
  // currentValue := 300;
  // Debug.print(debug_show(currentValue));

  stable var startTime = Time.now();
  // startTime := Time.now();
  Debug.print(debug_show(startTime));

// let is used to create to a variable to you won't be changing in the future
// the id can never change or be assigned a new value
let id = 4272521821535;

// pring a natural number in motoko
  // Debug.print(debug_show(currentValue));
  // Debug.print(debug_show(id));
// Printing a simple text motoko
  // Debug.print("Hello, we are getting started with Motoko");
  // Debug.print("Debug is a form of Console.log in JavaScript to debug our code and print the result in terminal")


  // Adding for codes 
  // All lines of codes needs to be closed off with a semicolon (;)
  // Do not forget that

// a function inside a canister is private untill it's made public
// to make a function public we have to add public to the function,  to make it private we use only func
// adding the public means we want the canister to recorganise the function
// and we can be able to call the function outside the canister

  public func topUp(amount: Float) {
    currentValue += amount;
    Debug.print(debug_show(currentValue));
  };
  
// this is in default Update funtion because the function have to check our currentValue
// then do some work and update the state of our currentValue before giving out the new currentValue
  public func withdraw(amount: Float) {
    let tempValue = currentValue - amount;

    if (tempValue >= 0) {
    currentValue -= amount;
    Debug.print(debug_show(currentValue));
    } else {
      Debug.print("Amount is greater than balance. Reduce amount!");
    }
  };

// Handling a query function for fast processing 
// Here what we are simply doing is a read only method and just to show the currentValue
// we then use the async function to let this function run without waiting for the about update functions
// to run first, so when we deploy  again (dfx deploy)
// we see that the checkBalance function was executed first because it doesn't have to wait for the topUp and withdraw functions
// to be executed first. That is the work of asynchronous function
  public query func checkBalance(): async Float {
    return currentValue
  };


  public func compound() {

    let currentTime = Time.now();
    let timeElapsedNS = currentTime - startTime;
    let timeElapsedS = timeElapsedNS / 1000000000;
    currentValue := currentValue * (1.01 ** Float.fromInt(timeElapsedS));
    startTime := currentTime;
  };
  
  
}
