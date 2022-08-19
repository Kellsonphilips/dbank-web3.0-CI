import { dbank } from "../../declarations/dbank";

window.addEventListener("load", async function() {
  
   updateBalance();
});


document.querySelector("form").addEventListener("submit", async function(event) {
  event.preventDefault();
  // console.log("Submitted.");

  const button = event.target.querySelector("#submit-btn");

  const inputAmount = parseFloat(document.getElementById("input-amount").value);
  const withdrawalAmount = parseFloat(document.getElementById("withdrawal-amount").value);

    button.setAttribute("disabled", true);

  if (document.getElementById("input-amount").value.length != 0) {
    await dbank.topUp(inputAmount);
  } else if (document.getElementById("withdrawal-amount").value.length != 0) {
    await dbank.withdraw(withdrawalAmount);
  }

  await dbank.compound();
  
 updateBalance();

  document.getElementById("input-amount").value = "";
  document.getElementById("withdrawal-amount").value = "";



    button.removeAttribute("disabled");
});

async function updateBalance() {
   const currentAmount = await dbank.checkBalance();
   document.getElementById("value").innerText =
     Math.round(currentAmount * 100) / 100;
};
