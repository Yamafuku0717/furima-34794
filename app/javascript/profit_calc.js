window.addEventListener('load', () => {
  const priceInput = document.getElementById("item-price")
  priceInput.addEventListener("input", () => {
    const addTaXDom = document.getElementById("add-tax-price");
    const profit = document.getElementById("profit")
    const Tax = 0.1;
    const inputValue = priceInput.value;
    const addTaxPrice = (priceInput.value * Tax);
    const priceTax = Math.floor(addTaxPrice);
    addTaXDom.innerHTML = `${priceTax.toLocaleString()}`;
    profit.innerHTML = `${(inputValue - priceTax).toLocaleString()}`
  })
});