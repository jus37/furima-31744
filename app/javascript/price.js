function price() {
  const form = document.getElementById("item-price")
  const tax = document.getElementById("add-tax-price");
  const profit = document.getElementById("profit")
  form.addEventListener("keyup",() =>{
    const tax_price = parseInt(form.value /10)
    tax.innerHTML = `${tax_price}`
    const profit_price = form.value - tax_price
    profit.innerHTML = `${profit_price}`
  })

}
window.addEventListener("load", price);