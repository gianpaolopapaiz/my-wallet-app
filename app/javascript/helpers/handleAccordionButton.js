const handleAccordionButton = () => {
  let accordionButtonsSelector = document.querySelectorAll('.wallet-accordion-button');
  const switchAccordionButton = (e) => {
    let accordionIcon = e.currentTarget.querySelector('i');
    if (accordionIcon.className.includes('fa-plus')) {
      accordionIcon.classList.remove('fa-plus');
      accordionIcon.classList.add('fa-minus');
    } else {
      accordionIcon.classList.remove('fa-minus');
      accordionIcon.classList.add('fa-plus');
    }
  }
  accordionButtonsSelector.forEach((accordionButton) => {
    accordionButton.addEventListener('click', switchAccordionButton);
  });
}

export { handleAccordionButton };
