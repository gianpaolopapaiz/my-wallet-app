const handleSubcategoryOnTransactionForm = () => {
  let categorySelector = document.getElementById('transaction_category_id');
  let subcategorySelector = document.getElementById('subcategory-field');
  let subcategoryOptionsSelector = document.getElementById('transaction_subcategory_id');
  let subcategories = {}

  const getSubcategories = (e) => {
    let selectedCategory = e.currentTarget.selectedIndex;
    let isNoCategorySelection = e.currentTarget.value == '';
    if (!isNoCategorySelection) {
      fetch('/categories/' + selectedCategory + '/subcategories.json').then((response) => {
        return response.json();
      }).then((data) => {
        subcategories = data;
        if (subcategories.length > 0) {
          subcategorySelector.classList.remove('hide-container');
          subcategoryOptionsSelector.innerHTML = '';
          subcategoryOptionsSelector.insertAdjacentHTML('beforeend', "<option value=''>Choose a subcategory</option>");
          subcategories.forEach((subcategory) => {
            let htmlString = `<option value='${subcategory.id}'>${subcategory.name}</option>`
            subcategoryOptionsSelector.insertAdjacentHTML('beforeend', htmlString);
          })
        } else {
          subcategorySelector.classList.add('hide-container');
        }
      })
    } else {
      subcategorySelector.classList.add('hide-container');
    }
  }

  categorySelector.addEventListener('change', getSubcategories);
}

export { handleSubcategoryOnTransactionForm };

